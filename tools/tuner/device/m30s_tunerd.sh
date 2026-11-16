#!/system/bin/sh
# M30s root backend. No eval/source, thermal writes, overclock or module changes.
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
            allowed "$v" "$P0/scaling_available_governors" && allowed "$v" "$P4/scaling_available_governors" || return 1
            case "$v" in schedutil|performance) ;; *) return 1;; esac
            old0=$(readnode "$P0/scaling_governor"); old4=$(readnode "$P4/scaling_governor")
            if writecheck "$P0/scaling_governor" "$v" && writecheck "$P4/scaling_governor" "$v"; then return 0; fi
            writecheck "$P0/scaling_governor" "$old0"; writecheck "$P4/scaling_governor" "$old4"; return 1;;
        touch_enabled) case "$v" in 0|1) ;; *) return 1;; esac; path=$BOOST/enabled;;
        touch_duration_ms) number "$v" && [ "$v" -ge 50 ] && [ "$v" -le 500 ] || return 1; path=$BOOST/duration_ms;;
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
profile() {
    case "$1" in
        battery) little=1326000; big=1768000; duration=100;;
        balanced) little=1742000; big=2314000; duration=150;;
        performance) little=1742000; big=2314000; duration=300;;
        *) return 1;;
    esac
    # Prevalidate the exact supported table before touching either cluster.
    allowed "$little" "$P0/scaling_available_frequencies" && allowed "$big" "$P4/scaling_available_frequencies" || return 1
    [ -f "$BOOST/duration_ms" ] && [ -f "$BOOST/enabled" ] || return 1
    snap0=$(readnode "$P0/scaling_max_freq"); snap4=$(readnode "$P4/scaling_max_freq")
    snapg0=$(readnode "$P0/scaling_governor"); snapg4=$(readnode "$P4/scaling_governor")
    snapd=$(readnode "$BOOST/duration_ms"); snape=$(readnode "$BOOST/enabled")
    if apply cap_little "$little" && apply cap_big "$big" && apply governor schedutil && apply touch_duration_ms "$duration" && apply touch_enabled 1; then
        savekey cap_little "$little"; savekey cap_big "$big"; savekey governor schedutil
        savekey touch_duration_ms "$duration"; savekey touch_enabled 1; savekey perf_profile "$1"
        return 0
    fi
    writecheck "$P0/scaling_max_freq" "$snap0"; writecheck "$P4/scaling_max_freq" "$snap4"
    writecheck "$P0/scaling_governor" "$snapg0"; writecheck "$P4/scaling_governor" "$snapg4"
    writecheck "$BOOST/duration_ms" "$snapd"; writecheck "$BOOST/enabled" "$snape"
    return 1
}
publish() {
    [ -d "$APP" ] && [ ! -L "$APP" ] || return 1
    {
        echo backend=m30s
        printf 'status=%s\n' "$STATUS"
        echo "perf_profile=$(value perf_profile)"
        echo "preset=$(value perf_profile)"
        for spec in "cap_little:$P0/scaling_max_freq" "cap_big:$P4/scaling_max_freq" "governor:$P0/scaling_governor" "governor_big:$P4/scaling_governor" "touch_enabled:$BOOST/enabled" "touch_duration_ms:$BOOST/duration_ms" "swappiness:$PROC/sys/vm/swappiness" "cpu_little_khz:$P0/scaling_cur_freq" "cpu_big_khz:$P4/scaling_cur_freq" "gpu_khz:$SYS/devices/platform/11500000.mali/clock" "temp_mc:$SYS/class/thermal/thermal_zone0/temp" "battery_percent:$SYS/class/power_supply/battery/capacity"; do
            key=${spec%%:*}; node=${spec#*:}; printf '%s=%s\n' "$key" "$(readnode "$node")"
        done
        case "$(readnode "$BOOST/enabled")" in Y|1) echo touch_enabled=1;; N|0) echo touch_enabled=0;; esac
        echo "anim_scale=$(setting get global window_animation_scale)"
        echo "little_freqs=$(readnode "$P0/scaling_available_frequencies" | xargs | tr ' ' ',')"
        echo "big_freqs=$(readnode "$P4/scaling_available_frequencies" | xargs | tr ' ' ',')"
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
                    case "$key" in perf_profile) ;; *) apply "$key" "$val" || STATUS="Could not restore $key";; esac
                done < "$CFG"
            fi
        fi
        handle; publish
    fi
    done
    [ "$1" = --once ] && break
    sleep 2
done
