#!/system/bin/sh
# M30s root backend. No eval/source, thermal writes, overclock or module changes.
# Every option is offered only when this kernel advertises it (cpufreq tables and governors, UFS block queues, TCP congestion list, Mali DVFS table, input boost module);
# requests are checked against those lists, written with readback and rolled back on failure.
SYS=/sys; PROC=/proc; APP=/data/user/0/org.m30s.tuner/files; WORK=/data/misc/m30s-tuner; TEST=0
if [ "$1" = --test ]; then
    TEST=1; FIXTURE=$2; SYS=$2/sys; PROC=$2/proc; APP=$2/app; WORK=$2/private; shift 2
else
    [ "$(getprop ro.product.device)" = m30s ] || exit 1
    [ "$(id -u)" = 0 ] || exit 1
fi
P0=$SYS/devices/system/cpu/cpufreq/policy0
P4=$SYS/devices/system/cpu/cpufreq/policy4
BOOST=$SYS/module/input_boost_m30s/parameters
GPU=; for g in "$SYS"/devices/platform/*.mali; do [ -f "$g/clock" ] && { GPU=$g; break; }; done
[ ! -L "$WORK" ] || exit 1
mkdir -p "$WORK" || exit 1
chmod 0700 "$WORK"
if ! mkdir "$WORK/lock" 2>/dev/null; then
    previous=$(cat "$WORK/lock/pid" 2>/dev/null)
    case "$previous" in ''|*[!0-9]*) previous=0;; esac
    if [ "$previous" -gt 0 ] && kill -0 "$previous" 2>/dev/null &&
        tr '\000' ' ' < "$PROC/$previous/cmdline" 2>/dev/null | grep -q '/system/bin/m30s_tunerd.sh'; then exit 1; fi
    rm -f "$WORK/lock/pid"; rmdir "$WORK/lock" 2>/dev/null || exit 1
    mkdir "$WORK/lock" || exit 1
fi
printf '%s\n' "$$" > "$WORK/lock/pid"
trap 'rm -f "$WORK/lock/pid"; rmdir "$WORK/lock" 2>/dev/null' EXIT
CFG=$WORK/config; STATE=$APP/state; STATUS='Ready; thermal limits unchanged'
readnode() { cat "$1" 2>/dev/null; }
allowed() { for a in $(readnode "$2"); do [ "$1" = "$a" ] && return 0; done; return 1; }
number() { case "$1" in ''|*[!0-9]*) return 1;; esac; [ ${#1} -le 8 ]; }
name_ok() { case "$1" in ''|*[!A-Za-z0-9_.-]*) return 1;; esac; [ ${#1} -le 32 ]; }
# exact word in a space separated list
allowed_in() { case " $2 " in *" $1 "*) return 0;; esac; return 1; }
# words both lists advertise
common() { out=; for a in $1; do allowed_in "$a" "$2" && out="$out $a"; done; echo $out; }
csv() { echo $* | tr ' ' ','; }
touch_ok() { [ -f "$BOOST/enabled" ] && [ ! -L "$BOOST/enabled" ] && [ -f "$BOOST/duration_ms" ] && [ ! -L "$BOOST/duration_ms" ]; }
governors() { common "$(readnode "$P0/scaling_available_governors" | tr -d '[]')" "$(readnode "$P4/scaling_available_governors" | tr -d '[]')"; }
maxfreq() { awk '{for (i = 1; i <= NF; i++) if ($i + 0 > m) m = $i + 0} END {print m + 0}' "$1" 2>/dev/null; }
# largest advertised step not above the limit, else the lowest step
stepbelow() { awk -v lim="$2" '{for (i = 1; i <= NF; i++) {v = $i + 0; if (v <= lim && v > b) b = v; if (m == 0 || v < m) m = v}} END {print (b > 0 ? b : m + 0)}' "$1" 2>/dev/null; }
# UFS disks only: a USB stick is also sdX and must not be tuned
disks() {
    root=$(readlink -f "$SYS" 2>/dev/null) || return 0
    for d in "$SYS"/block/sd*; do
        [ -f "$d/queue/scheduler" ] && [ ! -L "$d/queue/scheduler" ] || continue
        real=$(readlink -f "$d" 2>/dev/null); real=${real#"$root"}
        case "$real" in *ufs*) echo "${d##*/}";; esac
    done
}
# queue value; the active scheduler is the bracketed word of "noop [cfq]"
blkval() { l=$(readnode "$1"); case "$l" in *\[*\]*) l=${l#*\[}; echo "${l%%\]*}";; *) echo $l;; esac; }
blkwrite() { printf '%s\n' "$2" > "$1" 2>/dev/null && [ "$(blkval "$1")" = "$2" ]; }
blkwords() { readnode "$1" | tr -d '[]'; }
# the same words on every disk
blkcommon() {
    words=; first=1
    for d in $(disks); do
        w=$(blkwords "$SYS/block/$d/queue/$1")
        if [ $first = 1 ]; then words=$w; first=0; else words=$(common "$words" "$w"); fi
    done
    echo $words
}
# the value every disk has, or mixed
blkcurrent() {
    cur=; for d in $(disks); do bv=$(blkval "$SYS/block/$d/queue/$1"); if [ -z "$cur" ]; then cur=$bv; elif [ "$cur" != "$bv" ]; then echo mixed; return; fi; done
    echo $cur
}
# write queue/$1 on every UFS disk; any failure puts all disks back
setblk() {
    devs=$(disks); [ -n "$devs" ] || return 1
    snap=
    for d in $devs; do
        node=$SYS/block/$d/queue/$1
        [ -f "$node" ] && [ ! -L "$node" ] || return 1
        snap="$snap $d=$(blkval "$node")"
    done
    bad=0
    for d in $devs; do blkwrite "$SYS/block/$d/queue/$1" "$2" || bad=1; done
    [ $bad = 0 ] && return 0
    for e in $snap; do blkwrite "$SYS/block/${e%%=*}/queue/$1" "${e#*=}"; done
    return 1
}
setting() { settings "$@"; }
value() { awk -F= -v k="$1" '$1==k {v=substr($0,length(k)+2)} END {print v}' "$CFG" 2>/dev/null; }
savekey() {
    [ ! -L "$CFG" ] && [ ! -L "$CFG.new" ] || return 1
    [ -f "$CFG" ] || : > "$CFG"
    awk -F= -v k="$1" '$1!=k' "$CFG" > "$CFG.new"
    printf '%s=%s\n' "$1" "$2" >> "$CFG.new"
    mv "$CFG.new" "$CFG"
}
writecheck() {
    printf '%s\n' "$2" > "$1" || return 1
    actual=$(readnode "$1")
    # Boolean kernel parameters render 1/0 as Y/N.
    [ "$actual" = "$2" ] || { [ "$2" = 1 ] && [ "$actual" = Y ]; } || { [ "$2" = 0 ] && [ "$actual" = N ]; }
}
apply() {
    k=$1; v=$2; path=
    case "$k" in
        cap_little|cap_big)
            number "$v" || return 1
            policy=$P0; [ "$k" = cap_big ] && policy=$P4
            allowed "$v" "$policy/scaling_available_frequencies" || return 1
            min=$(readnode "$policy/scaling_min_freq"); number "$min" || return 1
            [ "$v" -ge "$min" ] || return 1
            path=$policy/scaling_max_freq;;
        governor)
            name_ok "$v" && allowed_in "$v" "$(governors)" || return 1
            old0=$(readnode "$P0/scaling_governor"); old4=$(readnode "$P4/scaling_governor")
            if writecheck "$P0/scaling_governor" "$v" && writecheck "$P4/scaling_governor" "$v"; then return 0; fi
            writecheck "$P0/scaling_governor" "$old0"; writecheck "$P4/scaling_governor" "$old4"; return 1;;
        touch_enabled) touch_ok || return 1; case "$v" in 0|1) ;; *) return 1;; esac; path=$BOOST/enabled;;
        touch_duration_ms) touch_ok || return 1; number "$v" && [ "$v" -ge 50 ] && [ "$v" -le 500 ] || return 1; path=$BOOST/duration_ms;;
        io_sched) name_ok "$v" && allowed_in "$v" "$(blkcommon scheduler)" || return 1; setblk scheduler "$v"; return;;
        read_ahead_kb) number "$v" && allowed_in "$v" "128 256 512 1024 2048" || return 1; setblk read_ahead_kb "$v"; return;;
        tcp_cc) name_ok "$v" && allowed_in "$v" "$(readnode "$PROC/sys/net/ipv4/tcp_available_congestion_control")" || return 1; path=$PROC/sys/net/ipv4/tcp_congestion_control;;
        gpu_max)
            [ -n "$GPU" ] && [ -f "$GPU/dvfs_max_lock" ] || return 1
            if [ "$v" != -1 ]; then
                number "$v" && allowed_in "$v" "$(readnode "$GPU/dvfs_table")" || return 1
                min=$(readnode "$GPU/dvfs_min_lock")
                case "$min" in ''|-1|0) ;; *[!0-9]*) return 1;; *) [ "$v" -ge "$min" ] || return 1;; esac
            fi
            path=$GPU/dvfs_max_lock;;
        swappiness) number "$v" && [ "$v" -le 200 ] || return 1; path=$PROC/sys/vm/swappiness;;
        anim_scale)
            case "$v" in 0|0.5|1.0|1.5) ;; *) return 1;; esac
            oldw=$(setting get global window_animation_scale)
            oldt=$(setting get global transition_animation_scale)
            olda=$(setting get global animator_duration_scale)
            if setting put global window_animation_scale "$v" && setting put global transition_animation_scale "$v" && setting put global animator_duration_scale "$v" &&
                [ "$(setting get global window_animation_scale)" = "$v" ] && [ "$(setting get global transition_animation_scale)" = "$v" ] && [ "$(setting get global animator_duration_scale)" = "$v" ]; then return 0; fi
            setting put global window_animation_scale "$oldw"; setting put global transition_animation_scale "$oldt"; setting put global animator_duration_scale "$olda"; return 1;;
        *) return 1;;
    esac
    [ -f "$path" ] && [ ! -L "$path" ] || return 1
    old=$(readnode "$path")
    writecheck "$path" "$v" && return 0
    writecheck "$path" "$old"; return 1
}
# Battery saver: the largest advertised step at most 77 percent of the maximum (1326/1768 MHz on the tables of the stock kernel). Balanced: the maximum of each
# table. Responsive is Balanced plus a 300 ms touch boost, so it exists only when the kernel has the touch boost module.
profiles() {
    allowed_in schedutil "$(governors)" || return 0   # every profile selects schedutil
    if touch_ok; then echo battery balanced performance; else echo battery balanced; fi
}
profile() {
    allowed_in "$1" "$(profiles)" || return 1
    tl=$P0/scaling_available_frequencies; tb=$P4/scaling_available_frequencies
    maxl=$(maxfreq "$tl"); maxb=$(maxfreq "$tb")
    [ "$maxl" -gt 0 ] && [ "$maxb" -gt 0 ] || return 1
    case "$1" in
        battery) little=$(stepbelow "$tl" $((maxl * 77 / 100))); big=$(stepbelow "$tb" $((maxb * 77 / 100))); duration=100;;
        balanced) little=$maxl; big=$maxb; duration=150;;
        performance) little=$maxl; big=$maxb; duration=300;;
        *) return 1;;
    esac
    # Prevalidate the exact supported table before touching either cluster.
    allowed "$little" "$tl" && allowed "$big" "$tb" || return 1
    snap0=$(readnode "$P0/scaling_max_freq"); snap4=$(readnode "$P4/scaling_max_freq")
    snapg0=$(readnode "$P0/scaling_governor"); snapg4=$(readnode "$P4/scaling_governor")
    if touch_ok; then snapd=$(readnode "$BOOST/duration_ms"); snape=$(readnode "$BOOST/enabled"); fi
    if apply cap_little "$little" && apply cap_big "$big" && apply governor schedutil && { ! touch_ok || { apply touch_duration_ms "$duration" && apply touch_enabled 1; }; }; then
        savekey cap_little "$little"; savekey cap_big "$big"; savekey governor schedutil
        if touch_ok; then savekey touch_duration_ms "$duration"; savekey touch_enabled 1; fi
        savekey perf_profile "$1"
        return 0
    fi
    writecheck "$P0/scaling_max_freq" "$snap0"; writecheck "$P4/scaling_max_freq" "$snap4"
    writecheck "$P0/scaling_governor" "$snapg0"; writecheck "$P4/scaling_governor" "$snapg4"
    if touch_ok; then writecheck "$BOOST/duration_ms" "$snapd"; writecheck "$BOOST/enabled" "$snape"; fi
    return 1
}
publish() {
    [ -d "$APP" ] && [ ! -L "$APP" ] || return 1
    {
        echo backend=m30s
        printf 'status=%s\n' "$STATUS"
        echo "perf_profile=$(value perf_profile)"
        echo "preset=$(value perf_profile)"
        for spec in "cap_little:$P0/scaling_max_freq" "cap_big:$P4/scaling_max_freq" "governor:$P0/scaling_governor" "governor_big:$P4/scaling_governor" "swappiness:$PROC/sys/vm/swappiness" "cpu_little_khz:$P0/scaling_cur_freq" "cpu_big_khz:$P4/scaling_cur_freq" "temp_mc:$SYS/class/thermal/thermal_zone0/temp" "battery_percent:$SYS/class/power_supply/battery/capacity"; do
            key=${spec%%:*}; node=${spec#*:}; printf '%s=%s\n' "$key" "$(readnode "$node")"
        done
        # Capabilities: what this kernel offers right now. The app builds its option lists from these and hides what is missing.
        echo caps=2
        echo "governors=$(csv "$(governors)")"
        echo "profiles=$(csv "$(profiles)")"
        for pr in battery balanced; do
            case "$pr" in battery) pl=$(stepbelow "$P0/scaling_available_frequencies" $(($(maxfreq "$P0/scaling_available_frequencies") * 77 / 100))); pb=$(stepbelow "$P4/scaling_available_frequencies" $(($(maxfreq "$P4/scaling_available_frequencies") * 77 / 100)));;
                *) pl=$(maxfreq "$P0/scaling_available_frequencies"); pb=$(maxfreq "$P4/scaling_available_frequencies");; esac
            echo "profile_$pr=$pl,$pb"
        done
        if touch_ok; then
            echo touch_supported=1
            echo "touch_duration_ms=$(readnode "$BOOST/duration_ms")"
            case "$(readnode "$BOOST/enabled")" in Y|1) echo touch_enabled=1;; N|0) echo touch_enabled=0;; esac
        else echo touch_supported=0; fi
        echo "io_devices=$(csv "$(disks)")"
        if [ -n "$(disks)" ]; then
            echo "io_scheds=$(csv "$(blkcommon scheduler)")"
            echo "io_sched=$(blkcurrent scheduler)"
            echo "read_aheads=128,256,512,1024,2048"
            echo "read_ahead_kb=$(blkcurrent read_ahead_kb)"
        fi
        echo "tcp_ccs=$(csv "$(readnode "$PROC/sys/net/ipv4/tcp_available_congestion_control")")"
        echo "tcp_cc=$(readnode "$PROC/sys/net/ipv4/tcp_congestion_control")"
        if [ -n "$GPU" ]; then
            echo "gpu_khz=$(readnode "$GPU/clock")"
            if [ -f "$GPU/dvfs_table" ] && [ -f "$GPU/dvfs_max_lock" ]; then
                echo "gpu_freqs=$(csv "$(readnode "$GPU/dvfs_table")")"
                echo "gpu_max=$(readnode "$GPU/dvfs_max_lock")"
            fi
        fi
        echo "anim_scale=$(setting get global window_animation_scale)"
        echo "little_freqs=$(csv "$(readnode "$P0/scaling_available_frequencies")")"
        echo "big_freqs=$(csv "$(readnode "$P4/scaling_available_frequencies")")"
        echo "mem_available=$(awk '/^MemAvailable:/ {print $2}' "$PROC/meminfo")"
    } > "$WORK/state.new" || return 1
    if [ "$TEST" = 0 ]; then
        owner=$(stat -c %u "$APP"); group=$(stat -c %g "$APP")
        chown "$owner:$group" "$WORK/state.new"
        chcon --reference="$APP" "$WORK/state.new" 2>/dev/null || restorecon "$WORK/state.new"
    fi
    chmod 0644 "$WORK/state.new"; mv "$WORK/state.new" "$STATE"
}
handle() {
    [ -f "$APP/request" ] && [ ! -L "$APP/request" ] || return 0
    [ "$(wc -c < "$APP/request")" -le 128 ] || { rm "$APP/request"; STATUS='Rejected oversized request'; return 1; }
    mv "$APP/request" "$APP/request.processing" || return 1
    line=$(cat "$APP/request.processing"); rm "$APP/request.processing"
    case "$line" in *=*) key=${line%%=*}; val=${line#*=};; *) STATUS='Rejected malformed request'; return 1;; esac
    case "$line" in *'
'*) STATUS='Rejected multiple requests'; return 1;; esac
    if [ "$key" = preset ]; then key=perf_profile; fi
    if [ "$key" = perf_profile ]; then
        if profile "$val"; then STATUS="Applied $val; thermal limits unchanged"; else STATUS='Rejected or restored failed profile'; return 1; fi
    elif apply "$key" "$val"; then
        savekey "$key" "$val"; savekey perf_profile custom; STATUS="Applied $key; readback verified"
    else STATUS="Rejected $key; no supported value"; return 1
    fi
}
# Existing configuration is parsed as data and revalidated. Fresh installation
# does not apply any preset or alter current device settings.
started=0
APPS=$APP
if [ "$TEST" = 1 ]; then
    [ ! -d "$FIXTURE/app-tablet" ] || APPS="$APP $FIXTURE/app-tablet"
else APPS="$APP /data/user/0/org.tablet.tuner/files"; fi
while :; do
    for APP in $APPS; do
    STATE=$APP/state
    if [ -d "$APP" ] && [ ! -L "$APP" ]; then
        if [ "$started" = 0 ]; then
            started=1
            if [ -f "$CFG" ] && [ ! -L "$CFG" ] && [ "$(wc -c < "$CFG")" -le 2048 ]; then
                while IFS='=' read -r key val; do
                    case "$key" in
                        ''|perf_profile) ;;
                        touch_enabled|touch_duration_ms) touch_ok && { apply "$key" "$val" || STATUS="Could not restore $key"; };;   # the module is not in every kernel
                        gpu_max) [ -n "$GPU" ] && { apply "$key" "$val" || STATUS="Could not restore $key"; };;
                        *) apply "$key" "$val" || STATUS="Could not restore $key";;
                    esac
                done < "$CFG"
            fi
        fi
        handle; publish
    fi
    done
    [ "$1" = --once ] && break
    sleep 2
done
