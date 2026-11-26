#!/system/bin/sh
# M30s root backend. No eval/source, thermal writes, overclock or module changes.
# Every option is offered only when this kernel or ROM has it (cpufreq tables and governors, UFS block queues, TCP congestion list, Mali DVFS table, vm and scheduler
# nodes, the framework commands a setting needs). A control exists in the app only when its key is published in the state file. Requests are checked against fixed
# lists and what the kernel advertises, written with readback and rolled back on failure.
SYS=/sys; PROC=/proc; APP=/data/user/0/org.m30s.tuner/files; WORK=/data/misc/m30s-tuner; TEST=0; DXS=/system/bin/dexopt_all.sh; DALVIK=/data/dalvik-cache; DEVBLK=/dev/block
if [ "$1" = --test ]; then
    TEST=1; FIXTURE=$2; SYS=$2/sys; PROC=$2/proc; APP=$2/app; WORK=$2/private; DXS=$2/dexopt_all.sh; DALVIK=$2/dalvik-cache; DEVBLK=$2/dev/block; shift 2
else
    [ "$(getprop ro.product.device)" = m30s ] || exit 1
    [ "$(id -u)" = 0 ] || exit 1
fi
P0=$SYS/devices/system/cpu/cpufreq/policy0
P4=$SYS/devices/system/cpu/cpufreq/policy4
BOOST=$SYS/module/input_boost_m30s/parameters
GPU=; for g in "$SYS"/devices/platform/*.mali; do [ -f "$g/clock" ] && { GPU=$g; break; }; done
# "PID ARGS" per process. ps shows a script as "sh", so the arguments are asked for (and /proc read where ps gives nothing). The host test supplies its own list.
proclist() {
    if [ "$TEST" = 1 ] && [ -n "$M30S_PROCLIST" ]; then "$M30S_PROCLIST"; return; fi
    _pl=$(ps -A -o PID,ARGS 2>/dev/null)
    if [ -n "$_pl" ]; then printf '%s\n' "$_pl"; return; fi
    for pd in /proc/[0-9]*; do pd=${pd#/proc/}; printf '%s %s\n' "$pd" "$(tr '\000' ' ' < "/proc/$pd/cmdline" 2>/dev/null)"; done
}
# the arguments of one process (empty when it is gone)
pidargs() {
    if [ "$TEST" = 1 ] && [ -n "$M30S_PROCLIST" ]; then proclist | while read -r pp rest; do [ "$pp" = "$1" ] && { echo "$rest"; break; }; done
    else tr '\000' ' ' < "/proc/$1/cmdline" 2>/dev/null; fi
}
# every daemon process: any copy of this script (a validation copy has another path), its background jobs included; not this shell and not a --stop call
daemons() {
    proclist | while read -r dp rest; do
        case "$dp" in ''|*[!0-9]*) continue;; esac
        [ "$dp" = "$$" ] && continue
        case "$rest" in *--stop*) continue;; *m30s_tunerd*.sh*) ;; *) continue;; esac
        if [ "$TEST" = 1 ]; then case "$rest" in *"$FIXTURE"*) ;; *) continue;; esac; fi
        echo "$dp"
    done
}
if [ "$1" = --stop ]; then   # ends every daemon, says which and whether one is left (the lock file names one pid; this looks at the processes)
    first=$(daemons | tr '\n' ' '); [ -n "$first" ] && echo "stopping: $first"
    i=0
    while left=$(daemons | tr '\n' ' '); [ -n "$left" ] && [ $i -lt 12 ]; do
        i=$((i + 1)); if [ $i -gt 5 ]; then kill -9 $left 2>/dev/null; else kill $left 2>/dev/null; fi
        sleep 1
    done
    left=$(daemons | tr '\n' ' ')
    if [ -n "$left" ]; then echo "still running: $left"; exit 1; fi
    rm -f "$WORK/lock/pid"; rmdir "$WORK/lock" 2>/dev/null
    echo "no daemon left"; exit 0
fi
[ ! -L "$WORK" ] || exit 1
mkdir -p "$WORK" || exit 1
chmod 0700 "$WORK"
if ! mkdir "$WORK/lock" 2>/dev/null; then
    previous=$(cat "$WORK/lock/pid" 2>/dev/null)
    case "$previous" in ''|*[!0-9]*) previous=0;; esac
    # a live daemon of any copy of the script owns the lock; the old test looked for /system/bin/m30s_tunerd.sh only, so a copy elsewhere took the lock of a daemon that went on running
    if [ "$previous" -gt 0 ] && [ "$previous" != "$$" ] && kill -0 "$previous" 2>/dev/null && pidargs "$previous" | grep -q 'm30s_tunerd.*\.sh'; then exit 1; fi
    rm -f "$WORK/lock/pid"; rmdir "$WORK/lock" 2>/dev/null || exit 1
    mkdir "$WORK/lock" || exit 1
fi
printf '%s\n' "$$" > "$WORK/lock/pid"
# the lock is released only by the daemon it names (an exiting daemon must not remove the lock of the one that took over)
own_lock() { _lp=; { read -r _lp < "$WORK/lock/pid"; } 2>/dev/null; [ "$_lp" = "$$" ]; }
trap 'own_lock && { rm -f "$WORK/lock/pid"; rmdir "$WORK/lock" 2>/dev/null; }' EXIT
CFG=$WORK/config; STATE=$APP/state; STATUS='Ready; thermal limits unchanged'; LASTREQ=
# The first line of a node or file. A /proc/sys node is read with cat, never with the shell's read: the builtin takes one byte at a time and a
# sysctl answers a one byte read with one character and nothing after it (130 became 1). Stable sysfs attributes are read with the builtin (no
# program to start: the state has about fifty of them and the phone needs 0.1 s per program); values that change while they are read use cat.
readnode() {
    _rnp=$1
    case "$1" in
        "$SYS"/*cur_freq|"$SYS"/*/temp|"$SYS"/*/clock|"$SYS"/*/capacity) _rn=$(cat "$1" 2>/dev/null);;
        "$SYS"/*) _rn=; if [ -r "$1" ]; then read -r _rn < "$1" || :; fi;;
        *) _rn=$(cat "$1" 2>/dev/null);;
    esac
    printf '%s\n' "${_rn%%
*}"
}
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
disks_scan() {
    root=$(readlink -f "$SYS" 2>/dev/null) || return 0
    for d in "$SYS"/block/sd*; do
        [ -f "$d/queue/scheduler" ] && [ ! -L "$d/queue/scheduler" ] || continue
        real=$(readlink -f "$d" 2>/dev/null); real=${real#"$root"}
        case "$real" in *ufs*) echo "${d##*/}";; esac
    done
}
# the scan costs a readlink per disk, so the main loop does it once per round (DISKS) and every later use reads that
disks() { if [ -n "$DISKS_OK" ]; then for d in $DISKS; do echo "$d"; done; else disks_scan; fi; }
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
value() { _vr=; if [ -r "$CFG" ]; then while IFS='=' read -r _vk _vv || [ -n "$_vk" ]; do [ "$_vk" = "$1" ] && _vr=$_vv; done < "$CFG"; fi; printf '%s\n' "$_vr"; }
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
log() { printf '%s %s\n' "$(date +%T)" "$*" >> "$WORK/tuner.log" 2>/dev/null; }
# a background job with its own stdio; the host test runs it in the foreground so results are deterministic (M30S_ASYNC=1 keeps it in the background)
bg() { if [ "$TEST" = 1 ] && [ "$M30S_ASYNC" != 1 ]; then "$@"; else ( trap - EXIT; "$@" ) < /dev/null > /dev/null 2>&1 & fi; }
alive() {
    case "$1" in ''|*[!0-9]*) return 1;; esac
    kill -0 "$1" 2>/dev/null || return 1
    [ "$TEST" = 1 ] && return 0
    tr '\000' ' ' < "$PROC/$1/cmdline" 2>/dev/null | grep -q m30s_tunerd.sh
}
# ---------- framework settings ----------
# settings get prints "null" for a key that is not set
sget() { v=$(settings get "$1" "$2" 2>/dev/null); case "$v" in ''|null) echo "$3";; *) echo "$v";; esac; }
# write, read back, put the old value back on a mismatch
sset() {
    old=$(settings get "$1" "$2" 2>/dev/null)
    settings put "$1" "$2" "$3" > /dev/null 2>&1 && [ "$(settings get "$1" "$2" 2>/dev/null)" = "$3" ] && return 0
    if [ -z "$old" ] || [ "$old" = null ]; then settings delete "$1" "$2" > /dev/null 2>&1; else settings put "$1" "$2" "$old" > /dev/null 2>&1; fi
    return 1
}
ovl() { cmd overlay list --user 0 2>/dev/null | grep -qE "[ .]$1\$"; }
ovlenabled() { cmd overlay list --user 0 2>/dev/null | grep -qE "^\[x\] .*$1\$"; }
bool01() { case "$1" in 0|1) return 0;; esac; return 1; }

# ---------- GPU lock ----------
# On the phone dvfs_max_lock reads "683000 / -1" while limited and "-1" when free; writing -1 does nothing, writing 0 releases the lock. The limit is the first word.
gpu_lock_now() { gl=$(readnode "$GPU/dvfs_max_lock"); gl=${gl%% *}; case "$gl" in 0) echo -1;; *) echo "$gl";; esac; }
gpu_lock_is() { [ "$(gpu_lock_now)" = "$1" ]; }
gpu_lock_write() { printf '%s\n' "$([ "$1" = -1 ] && echo 0 || echo "$1")" > "$GPU/dvfs_max_lock" 2>/dev/null; gpu_lock_is "$1"; }
# set the limit; whatever fails, the lock the GPU had before is put back (no lock left behind)
gpu_lock_set() {
    go=$(gpu_lock_now); [ -n "$go" ] || go=-1
    gpu_lock_write "$1" && return 0
    gpu_lock_write "$go" || { [ "$go" = -1 ] && printf '0\n' > "$GPU/dvfs_max_lock" 2>/dev/null; }
    return 1
}

# a recovery partition by name, flat or under the controller (the Exynos boards list them under platform/*/by-name)
recovery_part() { for rp in "$DEVBLK/by-name/recovery" "$DEVBLK"/platform/*/by-name/recovery; do [ -e "$rp" ] || [ -L "$rp" ] && return 0; done; return 1; }

# ---------- read-ahead probe ----------
# Some kernels accept a write to read_ahead_kb and keep the old value (the M30s UFS disks do). The row exists only where a changed value sticks: once per boot the
# first disk is given another step, read back and put back.
RAF=$WORK/ra.state
ra_probe() {
    rb=$(readnode "$PROC/sys/kernel/random/boot_id"); [ -n "$rb" ] || rb=none
    case "$(readnode "$RAF")" in "$rb "*) return 0;; esac
    rd_=$(disks | head -n 1); ra_res=unsupported
    if [ -n "$rd_" ] && [ -f "$SYS/block/$rd_/queue/read_ahead_kb" ] && [ ! -L "$SYS/block/$rd_/queue/read_ahead_kb" ]; then
        ro=$(blkval "$SYS/block/$rd_/queue/read_ahead_kb"); rn=256; [ "$ro" = 256 ] && rn=512
        if blkwrite "$SYS/block/$rd_/queue/read_ahead_kb" "$rn"; then ra_res=supported; fi
        blkwrite "$SYS/block/$rd_/queue/read_ahead_kb" "$ro" || log "read-ahead probe: could not put $rd_ back to $ro"
    fi
    printf '%s %s\n' "$rb" "$ra_res" > "$RAF"
}
ra_ok() { [ -n "$(disks)" ] && case "$(readnode "$RAF")" in *" supported") return 0;; esac; return 1; }

# Same for the schedutil rate limits: the M30s kernel takes a write to up/down_rate_limit_us and keeps 5000. A row exists only where a changed value sticks on both
# clusters; once per boot (and again if schedutil was not there yet) the node is given another value, read back and put back.
# Both nodes are written and read again after a second: the M30s kernel answers the write and reads the new value back at once, then puts 5000 back about half a second later
# (device, 2026-11-26), so a read back straight after the write proves nothing. Needs r0 and r4.
rate_set() {
    writecheck "$r0" "$1" && writecheck "$r4" "$1" || return 1
    sleep 1
    [ "$(readnode "$r0")" = "$1" ] && [ "$(readnode "$r4")" = "$1" ]
}
rate_probe() {
    rk=$1; rn=${rk}_rate_limit_us; r0=$P0/schedutil/$rn; r4=$P4/schedutil/$rn
    [ -f "$r0" ] && [ ! -L "$r0" ] && [ -f "$r4" ] && [ ! -L "$r4" ] || return 0
    rb=$(readnode "$PROC/sys/kernel/random/boot_id"); [ -n "$rb" ] || rb=none
    case "$(readnode "$WORK/rate.$rk")" in "$rb "*) return 0;; esac
    o0=$(readnode "$r0"); o4=$(readnode "$r4"); rv=10000; [ "$o0" = 10000 ] && rv=5000
    rr=unsupported
    if rate_set "$rv"; then rr=supported; fi
    writecheck "$r0" "$o0" || log "rate probe: could not put $rn back to $o0"
    writecheck "$r4" "$o4" || log "rate probe: could not put $rn back to $o4"
    printf '%s %s\n' "$rb" "$rr" > "$WORK/rate.$rk"
}
rate_ok() { case "$(readnode "$WORK/rate.$1")" in *" supported") return 0;; esac; return 1; }

# the mode the clocks and governor match (balanced: table maximum, battery: 77 percent step), schedutil on both clusters
mode_match() {
    allowed_in schedutil "$(governors)" && [ "$(curval governor)" = schedutil ] && [ "$(readnode "$P4/scaling_governor")" = schedutil ] || return 0
    ml=$(maxfreq "$P0/scaling_available_frequencies"); mb=$(maxfreq "$P4/scaling_available_frequencies")
    cl=$(curval cap_little); cb=$(curval cap_big)
    if [ "$cl" = "$ml" ] && [ "$cb" = "$mb" ]; then echo balanced; return 0; fi
    [ "$cl" = "$(stepbelow "$P0/scaling_available_frequencies" $((ml * 77 / 100)))" ] && [ "$cb" = "$(stepbelow "$P4/scaling_available_frequencies" $((mb * 77 / 100)))" ] && echo battery
    return 0
}
# every other kernel setting at its stock value (a key without a stock value is not held against the mode)
at_stock() {
    for ak in $STOCKKEYS; do
        case "$ak" in cap_little|cap_big|governor|touch_enabled|touch_duration_ms) continue;; esac
        as=$(stockof "$ak"); [ -n "$as" ] || continue
        [ "$(curval "$ak")" = "$as" ] || return 1
    done
    return 0
}
# the mode the user chose; before any choice, the one the clocks and governor already match (so a fresh install does not say "custom" while it runs Balanced). A custom
# mode left behind by a change that was undone is a stock mode again once every value is back where a mode would put it.
mode_now() {
    mv=$(value perf_profile)
    case "$mv" in
        '') mode_match; return 0;;
        custom) [ -z "$(value profile_active)" ] || { echo custom; return 0; }
            mm=$(mode_match); if [ -n "$mm" ] && at_stock; then echo "$mm"; else echo custom; fi; return 0;;
    esac
    echo "$mv"
}

# ---------- stock values ----------
# The values this kernel had when the daemon first ran after a boot, before saved values were restored. The app labels them "stock" and compares modes against them.
STOCK=$WORK/stock
STOCKKEYS="cap_little cap_big governor io_sched read_ahead_kb tcp_cc gpu_max swappiness vfs_cache page_cluster watermark extra_free schedstats up_rate down_rate deep_idle touch_enabled touch_duration_ms"
STOCKV=3   # files written by version 2 hold truncated values (see readnode): never read them
stockraw() { _sr=; if [ -r "$STOCK" ]; then while IFS='=' read -r _sk _sv || [ -n "$_sk" ]; do [ "$_sk" = "$1" ] && _sr=$_sv; done < "$STOCK"; fi; printf '%s\n' "$_sr"; }
stockof() { case "$1" in boot|v) stockraw "$1";; *) [ "$(stockraw v)" = "$STOCKV" ] && stockraw "$1" || echo;; esac; }
stock_capture() {
    bid=$(readnode "$PROC/sys/kernel/random/boot_id")
    # an old snapshot cannot be repaired and the values are no longer the kernel's own: keep none until the next boot
    if [ -e "$STOCK" ] && [ "$(stockraw v)" != "$STOCKV" ]; then printf 'boot=%s\nv=%s\n' "$bid" "$STOCKV" > "$STOCK.new" && mv "$STOCK.new" "$STOCK"; log "dropped the stock values of an older version"; return 0; fi
    [ "$(stockraw boot)" = "$bid" ] && [ -n "$bid" ] && return 0
    { echo "boot=$bid"; echo "v=$STOCKV"; for sk in $STOCKKEYS; do sv=$(curval "$sk"); case "$sv" in ''|mixed) ;; *) echo "$sk=$sv";; esac; done; } > "$STOCK.new" && mv "$STOCK.new" "$STOCK"
}
# the current value of a kernel node or setting, empty when this device does not have it
ratecur() { a=$(readnode "$P0/schedutil/$1"); b=$(readnode "$P4/schedutil/$1"); [ -n "$a" ] && [ -n "$b" ] || return 0; if [ "$a" = "$b" ]; then echo "$a"; else echo mixed; fi; }
idlenodes() { for n in "$SYS"/devices/system/cpu/cpu[0-9]*/cpuidle/state[1-9]/disable; do [ -f "$n" ] && [ ! -L "$n" ] && echo "$n"; done; }
idlecur() {
    on=0; off=0
    for n in $(idlenodes); do case "$(readnode "$n")" in 0) on=$((on + 1));; 1) off=$((off + 1));; esac; done
    [ $((on + off)) -gt 0 ] || return 0
    if [ $off = 0 ]; then echo 1; elif [ $on = 0 ]; then echo 0; else echo mixed; fi
}
curval() {
    case "$1" in
        cap_little) readnode "$P0/scaling_max_freq";;
        cap_big) readnode "$P4/scaling_max_freq";;
        governor) readnode "$P0/scaling_governor";;
        io_sched) [ -n "$(disks)" ] && blkcurrent scheduler;;
        read_ahead_kb) ra_ok && blkcurrent read_ahead_kb;;
        tcp_cc) readnode "$PROC/sys/net/ipv4/tcp_congestion_control";;
        gpu_max) [ -n "$GPU" ] && [ -f "$GPU/dvfs_table" ] && [ -f "$GPU/dvfs_max_lock" ] && gpu_lock_now;;
        swappiness) readnode "$PROC/sys/vm/swappiness";;
        vfs_cache) readnode "$PROC/sys/vm/vfs_cache_pressure";;
        page_cluster) readnode "$PROC/sys/vm/page-cluster";;
        watermark) readnode "$PROC/sys/vm/watermark_scale_factor";;
        extra_free) readnode "$PROC/sys/vm/extra_free_kbytes";;
        schedstats) readnode "$PROC/sys/kernel/sched_schedstats";;
        up_rate) rate_ok up && ratecur up_rate_limit_us;;
        down_rate) rate_ok down && ratecur down_rate_limit_us;;
        deep_idle) idlecur;;
        touch_enabled) touch_ok && case "$(readnode "$BOOST/enabled")" in Y|1) echo 1;; N|0) echo 0;; esac;;
        touch_duration_ms) touch_ok && readnode "$BOOST/duration_ms";;
        anim_scale) sget global window_animation_scale "";;
        window_blur) sget global disable_window_blurs 0;;
        screen_timeout) sget system screen_off_timeout "";;
        bg_procs) bgcur;;
        cached_apps) cachedcur;;
        carplay_boost) [ -n "$(carplay_pkgs)" ] && { cv=$(value carplay_boost); echo "${cv:-0}"; };;
        *) return 0;;
    esac
}

# ---------- more framework controls ----------
bgcur() { v=$(device_config get activity_manager max_cached_processes 2>/dev/null); case "$v" in ''|null) echo default;; *) echo "$v";; esac; }
cachedcur() { sget global activity_manager_constants "" | tr ',' '\n' | sed -n 's/^max_cached_processes=//p' | head -n 1 | grep . || echo default; }
cachedset() {   # $1 default or a number; the other constants stay
    cc=$(sget global activity_manager_constants "")
    rest=$(echo "$cc" | tr ',' '\n' | grep -v '^max_cached_processes=' | grep -v '^$' | tr '\n' ',' | sed 's/,$//')
    [ "$1" != default ] && rest="max_cached_processes=$1${rest:+,$rest}"
    if [ -n "$rest" ]; then settings put global activity_manager_constants "$rest" > /dev/null 2>&1; else settings delete global activity_manager_constants > /dev/null 2>&1; fi
    [ "$(cachedcur)" = "$1" ] && return 0
    if [ -n "$cc" ]; then settings put global activity_manager_constants "$cc" > /dev/null 2>&1; else settings delete global activity_manager_constants > /dev/null 2>&1; fi
    return 1
}
dnscur() {
    case "$(sget global private_dns_mode "")" in
        off) echo off;;
        opportunistic) echo auto;;
        hostname) case "$(sget global private_dns_specifier "")" in dns.google) echo google;; one.one.one.one) echo cloudflare;; dns.adguard-dns.com) echo adguard;; dns.quad9.net) echo quad9;; *) echo custom;; esac;;
    esac
}
dnsset() {
    om=$(sget global private_dns_mode ""); os=$(sget global private_dns_specifier "")
    case "$1" in
        off) sset global private_dns_mode off;;
        auto) sset global private_dns_mode opportunistic;;
        *) case "$1" in google) h=dns.google;; cloudflare) h=one.one.one.one;; adguard) h=dns.adguard-dns.com;; quad9) h=dns.quad9.net;; *) return 1;; esac
           sset global private_dns_specifier "$h" && sset global private_dns_mode hostname;;
    esac && return 0
    [ -n "$os" ] && settings put global private_dns_specifier "$os" > /dev/null 2>&1
    [ -n "$om" ] && settings put global private_dns_mode "$om" > /dev/null 2>&1
    return 1
}
nightcur() { cmd uimode night 2>/dev/null | sed -n 's/^Night mode: *//p' | head -n 1; }
nightok() { [ -n "$(nightcur)" ]; }
NAVPKG=com.android.internal.systemui.navbar
navok() { ovl "$NAVPKG\\.gestural" && ovl "$NAVPKG\\.threebutton"; }
navcur() { ovlenabled "$NAVPKG\\.threebutton" && { echo threebutton; return 0; }; ovlenabled "$NAVPKG\\.gestural" && echo gestural; }
# display density: the physical value, the override (if any) and the sizes offered, always the same percentages of the physical value
densphys() { wm density 2>/dev/null | awk '/Physical density:/ {print $3; exit}'; }
densnow() { wm density 2>/dev/null | awk '/Override density:/ {o = $3} /Physical density:/ {p = $3} END {print (o != "" ? o : p)}'; }
densopts() {   # ascending, with reset standing for the physical value
    dp=$(densphys); number "$dp" || return 0
    echo "$((dp * 80 / 100)),$((dp * 90 / 100)),reset,$((dp * 110 / 100)),$((dp * 125 / 100))"
}
densset() {
    allowed_in "$1" "$(densopts | tr ',' ' ')" || return 1
    od=$(densnow)
    if [ "$1" = reset ]; then wm density reset > /dev/null 2>&1; else wm density "$1" > /dev/null 2>&1; fi
    [ "$(densnow)" = "$([ "$1" = reset ] && densphys || echo "$1")" ] && return 0
    if [ "$od" = "$(densphys)" ]; then wm density reset > /dev/null 2>&1; else wm density "$od" > /dev/null 2>&1; fi
    return 1
}
wifiok() { cmd wifi help 2>&1 | grep -q force-country-code; }
wifiset() {   # $1 auto or a country code from the list
    if [ "$1" = auto ]; then wo=$(cmd wifi force-country-code disabled 2>&1); else wo=$(cmd wifi force-country-code enabled "$1" 2>&1); fi
    wr=$?
    echo "$wo" | grep -qiE "can't find|exception|error|unknown|usage" && return 1
    return $wr
}
wifiboot() {   # Wi-Fi may not be ready right after boot, and the override is lost when system_server restarts
    wc=$(value wifi_country); [ -n "$wc" ] || return 0
    wn=0; [ "$TEST" = 1 ] && wn=11
    while [ $wn -lt 12 ]; do wifiset "$wc" && { log "wifi country $wc"; return 0; }; wn=$((wn + 1)); sleep 5; done
    log "wifi country not applied"
}
adbtcpcur() { case "$(getprop service.adb.tcp.port)" in ''|*[!0-9]*) echo 0;; 0) echo 0;; *) echo 1;; esac; }
loggingcur() { if [ "$(getprop persist.log.tag)" = S ]; then echo 0; else echo 1; fi; }
consolecur() { if [ "$(getprop init.svc.console)" = running ]; then echo 1; else echo 0; fi; }

# ---------- theme (accent, palette style, fonts, icon shape and pack, pure black) ----------
# SystemUI's theme controller reads one JSON value; it is rebuilt from the current value with the one change, so what the user set elsewhere stays.
THEMEK=android.theme.customization
tjv() { printf '%s' "$TJ" | sed -n 's/.*"'"$THEMEK"'\.'"$1"'":"\([^"]*\)".*/\1/p' | head -n 1; }
fontlist() { cmd overlay list --user 0 2>/dev/null | grep -oE "[A-Za-z0-9_.]*\\.font\\.[a-z0-9]+\$" | sed 's/.*font\.//' | sort -u | tr '\n' ' '; }
themeok() { settings get secure theme_customization_overlay_packages > /dev/null 2>&1 && cmd overlay list --user 0 > /dev/null 2>&1; }
BLACK=org.lineageos.overlay.customization.blacktheme
ACCENTS="3E91FF 7C5CFF 00B8A9 34C759 FF9500 FF3B30 FF4F9A"
STYLES="TONAL_SPOT VIBRANT EXPRESSIVE SPRITZ RAINBOW FRUIT_SALAD MONOCHROMATIC"
SHAPES="squircle roundedrect teardrop pebble vessel taperedrect square"
PACKS="rounded filled kai sam victor circular"
themeset() {   # $1 key, $2 value
    TJ=$(settings get secure theme_customization_overlay_packages 2>/dev/null); [ "$TJ" = null ] && TJ=
    tsrc=$(tjv color_source); tacc=$(tjv accent_color); tsty=$(tjv theme_style)
    tfont=$(tjv font); tshape=$(tjv adaptive_icon_shape); tpack=$(tjv "icon_pack.android" | sed 's/^com\.android\.theme\.icon_pack\.\(.*\)\.android$/\1/')
    [ -n "$tsrc" ] || tsrc=preset; [ -n "$tacc" ] || tacc=3E91FF; [ -n "$tsty" ] || tsty=TONAL_SPOT
    fp=
    case "$1" in
        palette_source) allowed_in "$2" "preset home_wallpaper" || return 1; tsrc=$2;;
        accent) allowed_in "$2" "$ACCENTS" || return 1; tacc=$2; tsrc=preset;;
        theme_style) allowed_in "$2" "$STYLES" || return 1; tsty=$2;;
        font) if [ "$2" = default ]; then tfont=; else
                fp=$(cmd overlay list --user 0 2>/dev/null | grep -oE "[A-Za-z0-9_.]*\\.font\\.$2\$" | head -n 1); [ -n "$fp" ] || return 1; tfont=$fp; fi;;
        icon_shape) if [ "$2" = default ]; then tshape=; else allowed_in "$2" "$SHAPES" && ovl "icon\\.$2" || return 1; tshape=com.android.theme.icon.$2; fi;;
        icon_pack) if [ "$2" = default ]; then tpack=; else allowed_in "$2" "$PACKS" && ovl "icon_pack\\.$2\\.android" || return 1; tpack=$2; fi;;
        *) return 1;;
    esac
    if [ "$tsrc" = home_wallpaper ]; then J="{\"$THEMEK.color_both\":\"1\",\"$THEMEK.color_source\":\"home_wallpaper\""
    else J="{\"$THEMEK.color_both\":\"0\",\"$THEMEK.color_source\":\"preset\",\"$THEMEK.system_palette\":\"$tacc\",\"$THEMEK.accent_color\":\"$tacc\""; fi
    J="$J,\"$THEMEK.theme_style\":\"$tsty\""
    [ -n "$tfont" ] && J="$J,\"$THEMEK.font\":\"$tfont\""
    [ -n "$tshape" ] && J="$J,\"$THEMEK.adaptive_icon_shape\":\"$tshape\""
    if [ -n "$tpack" ]; then for t in android launcher settings systemui; do J="$J,\"$THEMEK.icon_pack.$t\":\"com.android.theme.icon_pack.$tpack.$t\""; done; fi
    old=$TJ
    settings put secure theme_customization_overlay_packages "$J,\"_applied_timestamp\":$(date +%s)000}" > /dev/null 2>&1
    TJ=$(settings get secure theme_customization_overlay_packages 2>/dev/null)
    case "$1" in
        palette_source) [ "$(tjv color_source)" = "$tsrc" ] || { settings put secure theme_customization_overlay_packages "$old" > /dev/null 2>&1; return 1; };;
        accent) [ "$(tjv accent_color)" = "$tacc" ] || { settings put secure theme_customization_overlay_packages "$old" > /dev/null 2>&1; return 1; };;
        theme_style) [ "$(tjv theme_style)" = "$tsty" ] || { settings put secure theme_customization_overlay_packages "$old" > /dev/null 2>&1; return 1; };;
        font) [ "$(tjv font)" = "$tfont" ] || { settings put secure theme_customization_overlay_packages "$old" > /dev/null 2>&1; return 1; };;
        icon_shape) [ "$(tjv adaptive_icon_shape)" = "$tshape" ] || { settings put secure theme_customization_overlay_packages "$old" > /dev/null 2>&1; return 1; };;
        icon_pack) [ "$(tjv "icon_pack.android" | sed 's/^com\.android\.theme\.icon_pack\.\(.*\)\.android$/\1/')" = "$tpack" ] || { settings put secure theme_customization_overlay_packages "$old" > /dev/null 2>&1; return 1; };;
    esac
    # SystemUI does not switch font overlays by itself on every build
    if [ "$1" = font ]; then
        if [ "$2" = default ]; then for o in $(cmd overlay list --user 0 2>/dev/null | grep -oE "[A-Za-z0-9_.]*\\.font\\.[a-z0-9]+\$"); do cmd overlay disable --user 0 "$o" > /dev/null 2>&1; done
        else cmd overlay enable-exclusive --user 0 --category "$fp" > /dev/null 2>&1; fi
    fi
    return 0
}
blackset() {
    ovl "$BLACK" || return 1
    if [ "$1" = 1 ]; then cmd overlay enable --user 0 "$BLACK" > /dev/null 2>&1; cmd overlay set-priority "$BLACK" highest > /dev/null 2>&1
    else cmd overlay disable --user 0 "$BLACK" > /dev/null 2>&1; fi
    if [ "$1" = 1 ]; then ovlenabled "$BLACK"; else ! ovlenabled "$BLACK"; fi
}

# the settings that exist only in the framework: each one is checked against a fixed list, written, read back and put back on failure
is_x() {
    case "$1" in
        screen_timeout|font_scale|font_weight|text_contrast|stay_awake|auto_rotate|show_taps|window_blur|dns|bg_procs|cached_apps|anim_scale|night|nav_mode|density|wifi_country|adb_tcp|serial_console|logging|palette_source|accent|theme_style|font|icon_shape|icon_pack|black_theme) return 0;;
    esac
    return 1
}
xapply() {
    xk=$1; xv=$2
    case "$xk" in
        screen_timeout) allowed_in "$xv" "15000 30000 60000 120000 300000 600000 1800000" || return 1; sset system screen_off_timeout "$xv";;
        font_scale) allowed_in "$xv" "0.85 1.0 1.15 1.3" || return 1; sset system font_scale "$xv";;
        font_weight) allowed_in "$xv" "0 100 200 300" || return 1; sset secure font_weight_adjustment "$xv";;
        text_contrast) bool01 "$xv" || return 1; sset secure high_text_contrast_enabled "$xv";;
        stay_awake) allowed_in "$xv" "0 3 7" || return 1; sset global stay_on_while_plugged_in "$xv";;
        auto_rotate) bool01 "$xv" || return 1; sset system accelerometer_rotation "$xv";;
        show_taps) bool01 "$xv" || return 1; sset system show_touches "$xv";;
        window_blur) bool01 "$xv" || return 1; sset global disable_window_blurs "$xv";;
        dns) allowed_in "$xv" "off auto google cloudflare adguard quad9" || return 1; dnsset "$xv" && [ "$(dnscur)" = "$xv" ];;
        bg_procs) case "$xv" in default) ;; 8|16|32|64) ;; *) return 1;; esac
            bo=$(bgcur)
            if [ "$xv" = default ]; then device_config delete activity_manager max_cached_processes > /dev/null 2>&1; else device_config put activity_manager max_cached_processes "$xv" > /dev/null 2>&1; fi
            [ "$(bgcur)" = "$xv" ] && return 0
            if [ "$bo" = default ]; then device_config delete activity_manager max_cached_processes > /dev/null 2>&1; else device_config put activity_manager max_cached_processes "$bo" > /dev/null 2>&1; fi
            return 1;;
        cached_apps) allowed_in "$xv" "default 16 24 32 48" || return 1; cachedset "$xv";;
        anim_scale)
            case "$xv" in 0|1|2|0.[0-9]|1.[0-9]|2.0) ;; *) return 1;; esac
            oldw=$(settings get global window_animation_scale); oldt=$(settings get global transition_animation_scale); olda=$(settings get global animator_duration_scale)
            if settings put global window_animation_scale "$xv" && settings put global transition_animation_scale "$xv" && settings put global animator_duration_scale "$xv" &&
                [ "$(settings get global window_animation_scale)" = "$xv" ] && [ "$(settings get global transition_animation_scale)" = "$xv" ] && [ "$(settings get global animator_duration_scale)" = "$xv" ]; then return 0; fi
            settings put global window_animation_scale "$oldw"; settings put global transition_animation_scale "$oldt"; settings put global animator_duration_scale "$olda"; return 1;;
        night) nightok && allowed_in "$xv" "auto no yes" || return 1; cmd uimode night "$xv" > /dev/null 2>&1; [ "$(nightcur)" = "$xv" ];;
        nav_mode) navok && allowed_in "$xv" "gestural threebutton" || return 1
            no=$(navcur); cmd overlay enable-exclusive --user 0 --category "$NAVPKG.$xv" > /dev/null 2>&1
            [ "$(navcur)" = "$xv" ] && return 0
            [ -n "$no" ] && cmd overlay enable-exclusive --user 0 --category "$NAVPKG.$no" > /dev/null 2>&1
            return 1;;
        density) densset "$xv";;
        wifi_country) wifiok && allowed_in "$xv" "auto CA US GB DE FR IN AU JP MX BR" || return 1; wifiset "$xv";;
        adb_tcp) bool01 "$xv" || return 1
            if [ "$xv" = 1 ]; then setprop service.adb.tcp.port 5555; else setprop service.adb.tcp.port -1; fi
            stop adbd; start adbd; [ "$(adbtcpcur)" = "$xv" ];;
        serial_console) bool01 "$xv" && [ -n "$(getprop init.svc.console)" ] || return 1
            if [ "$xv" = 1 ]; then setprop persist.sys.console 1; start console; else setprop persist.sys.console 0; stop console; fi
            [ "$TEST" = 1 ] || sleep 1
            [ "$(consolecur)" = "$xv" ];;
        logging) bool01 "$xv" || return 1
            if [ "$xv" = 1 ]; then setprop persist.log.tag ""; logcat -b all -G 1M; else setprop persist.log.tag S; logcat -b all -G 64K; fi
            [ "$(loggingcur)" = "$xv" ];;
        palette_source|accent|theme_style|font|icon_shape|icon_pack) themeok || return 1; themeset "$xk" "$xv";;
        black_theme) bool01 "$xv" || return 1; blackset "$xv";;
        *) return 1;;
    esac
}
# keys whose value the daemon keeps in its own configuration: the kernel keys (they are lost at boot) and the Wi-Fi country (lost at boot too); the Android settings keep their own
persisted() { is_x "$1" || return 0; case "$1" in wifi_country) return 0;; esac; return 1; }
# changing one of these turns the mode into custom
mode_key() {
    case "$1" in cap_little|cap_big|governor|gpu_max|io_sched|read_ahead_kb|tcp_cc|swappiness|vfs_cache|page_cluster|watermark|extra_free|schedstats|up_rate|down_rate|deep_idle|touch_enabled|touch_duration_ms) return 0;; esac
    return 1
}
set_any() { if is_x "$1"; then xapply "$1" "$2"; else apply "$1" "$2"; fi; }

# ---------- saved profiles ----------
# One line per profile in $PF: "name|key=value key=value". They hold the performance, memory and a few system keys, not the look.
PF=$WORK/profiles
# version 2 saved profiles with truncated values (see readnode): put them aside once
pf_check() { [ "$(cat "$WORK/profiles.v" 2>/dev/null)" = 3 ] && return 0; [ -e "$PF" ] && { mv "$PF" "$PF.v2" 2>/dev/null; log "set aside the saved profiles of an older version"; }; echo 3 > "$WORK/profiles.v"; }
PKEYS="cap_little cap_big governor gpu_max io_sched read_ahead_kb tcp_cc swappiness vfs_cache page_cluster watermark extra_free schedstats up_rate down_rate deep_idle touch_enabled touch_duration_ms anim_scale window_blur cached_apps bg_procs carplay_boost"
pf_names() { cut -d'|' -f1 "$PF" 2>/dev/null | tr '\n' ',' | sed 's/,$//'; }
pf_line() { [ -r "$PF" ] || return 0; while IFS= read -r pln || [ -n "$pln" ]; do [ "${pln%%\|*}" = "$1" ] && { echo "${pln#*\|}"; return 0; }; done < "$PF"; return 0; }
pf_save() {   # $1 name; an existing profile of that name is replaced in place
    name_ok "$1" && [ ${#1} -le 24 ] || return 1
    if [ -z "$(pf_line "$1")" ] && [ "$(pf_names | tr ',' '\n' | grep -c .)" -ge 24 ]; then return 1; fi
    pl="$1|"
    for pk in $PKEYS; do
        pv=$(curval "$pk")
        case "$pv" in ''|mixed|*[!A-Za-z0-9._-]*) continue;; esac
        pl="$pl$pk=$pv "
    done
    pd=0
    { if [ -r "$PF" ]; then while IFS= read -r pln || [ -n "$pln" ]; do
            [ -z "$pln" ] && continue
            if [ "${pln%%\|*}" = "$1" ]; then echo "$pl"; pd=1; else echo "$pln"; fi
        done < "$PF"; fi
      [ $pd = 1 ] || echo "$pl"; } > "$PF.new" && mv "$PF.new" "$PF"
}
pf_delete() { [ -r "$PF" ] || return 0; { while IFS= read -r pln || [ -n "$pln" ]; do [ -n "$pln" ] && [ "${pln%%\|*}" != "$1" ] && echo "$pln"; done < "$PF"; : ; } > "$PF.new" && mv "$PF.new" "$PF"; }
# applies every key the profile holds that this device has; one rejected key puts all of them back
pf_apply() {
    pa=$(pf_line "$1"); [ -n "$pa" ] || return 1
    psnap=; for kv in $pa; do pk=${kv%%=*}; allowed_in "$pk" "$PKEYS" || continue; pv=$(curval "$pk"); [ -n "$pv" ] && psnap="$psnap $pk=$pv"; done
    pbad=
    for kv in $pa; do
        pk=${kv%%=*}; pv=${kv#*=}
        allowed_in "$pk" "$PKEYS" || continue
        [ -n "$(curval "$pk")" ] || continue          # this device does not have that control: skipped
        if [ "$pk" = carplay_boost ]; then bool01 "$pv" || { pbad=$pk; break; }; continue; fi
        set_any "$pk" "$pv" || { pbad=$pk; break; }
    done
    if [ -n "$pbad" ]; then
        log "profile $1: $pbad rejected, restoring"
        for kv in $psnap; do set_any "${kv%%=*}" "${kv#*=}"; done
        return 1
    fi
    for kv in $pa; do
        pk=${kv%%=*}; pv=${kv#*=}
        allowed_in "$pk" "$PKEYS" || continue
        [ -n "$(curval "$pk")" ] || continue
        persisted "$pk" && savekey "$pk" "$pv"
    done
    savekey perf_profile custom; savekey profile_active "$1"; savekey profile_base "$1"
}

# ---------- app compile ----------
DXL=$WORK/dexopt.log; DXP=$WORK/dexopt.pid; DXT=$WORK/dexopt.total; DXE=$WORK/dexopt.end; DXSUM=$WORK/dexopt.summary
QF=$WORK/queue; QR=$WORK/q.run; QC=$WORK/qcount; PST=$WORK/pkgstat; AFD=$WORK/apps.state; AFAIL=$WORK/apps.fail; RL=$WORK/r.lock
pkgok() { printf '%s\n' "$1" | grep -qE '^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z0-9_]+)+$'; }
cstat() {   # idle, running, done (the script prints DONE last) or missing
    p=$(cat "$DXP" 2>/dev/null)
    if alive "$p"; then echo running
    elif [ ! -f "$DXS" ]; then echo missing
    elif tail -n 1 "$DXL" 2>/dev/null | grep -q '^DONE'; then echo done
    else echo idle; fi
}
# the setup compile that the image starts after a data wipe must not run together with ours
fbrunning() {
    [ "$TEST" = 1 ] && return 1
    for fp in $(pidof sh 2>/dev/null); do tr '\000' ' ' < "$PROC/$fp/cmdline" 2>/dev/null | grep -q firstboot_dexopt && return 0; done
    return 1
}
qlock() { ql=0; while ! mkdir "$WORK/qf.lock" 2>/dev/null; do ql=$((ql + 1)); [ $ql -gt 100 ] && return 1; sleep 0.1; done; }
qunlock() { rmdir "$WORK/qf.lock" 2>/dev/null; }
countpkgs() { pm list packages 2>/dev/null | wc -l | tr -d ' ' > "$DXT"; }
runcompile() { DEXOPT_RESTART_UI=$([ -z "$1" ] && echo 1 || echo 0) DEXOPT_FORCE=$1 sh "$DXS" >> "$DXL" 2>&1 < /dev/null; date +%s > "$DXE"; }
compile() {   # $1 empty skips apps that are already compiled, -f recompiles all
    [ "$M30S_NO_COMPILE" = 1 ] && { log "compile refused: validation daemon (M30S_NO_COMPILE=1)"; return 1; }
    [ "$(cstat)" = running ] && { log "compile already running"; return 1; }
    [ -d "$QR" ] && { log "app compile running"; return 1; }
    [ -f "$DXS" ] || { log "no $DXS"; return 1; }
    fbrunning && { log "setup compile running"; return 1; }
    rm -f "$DXE" "$DXT" "$DXSUM"; echo "=== run $(date +%s) ===" > "$DXL"
    bg countpkgs
    if [ "$TEST" = 1 ] && [ "$M30S_ASYNC" != 1 ]; then runcompile "$1"
    else ( trap - EXIT; runcompile "$1" ) < /dev/null > /dev/null 2>&1 & echo $! > "$DXP"; fi
    log "compile started ($1)"
}
# stdin: "art dump" text ("[com.x]" header, then "path:" blocks with "arm64: [status=speed] ..."). Prints "package=filter", the first status of each package.
dexstates() {
    sed -n -e 's/^ *\[\([A-Za-z][A-Za-z0-9_.]*\)\] *$/P \1/p' -e 's/^ *known secondary dex files:.*/X x/p' -e 's/^ *arm64: \[status=\([A-Za-z0-9_-]*\)\].*/A \1/p' -e 's/^ *arm: \[status=\([A-Za-z0-9_-]*\)\].*/S \1/p' | {
        pk=; a=; s=; x=
        emit() { [ -n "$pk" ] || return 0; if [ -n "$a" ]; then echo "$pk=$a"; elif [ -n "$s" ]; then echo "$pk=$s"; fi; }
        while read t v; do
            case $t in
                P) emit; pk=$v; a=; s=; x=;;
                X) x=1;;
                A) [ -z "$x" ] && [ -z "$a" ] && a=$v;;
                S) [ -z "$x" ] && [ -z "$s" ] && s=$v;;
            esac
        done
        emit
    }
}
put_app_file() {   # $1 source file, $2 name in each app directory
    for d in $APPS; do
        [ -d "$d" ] && [ ! -L "$d" ] || continue
        cp "$1" "$d/$2.new" || continue
        if [ "$TEST" = 0 ]; then chown "$(stat -c %u "$d"):$(stat -c %g "$d")" "$d/$2.new"; chcon --reference="$d" "$d/$2.new" 2>/dev/null || restorecon "$d/$2.new"; fi
        chmod 0660 "$d/$2.new"; mv "$d/$2.new" "$d/$2"
    done
}
apps_refresh() {   # $1 empty: every package (takes seconds); $1 package: that one only
    if [ -n "$1" ]; then while ! mkdir "$RL" 2>/dev/null; do sleep 1; done; else mkdir "$RL" 2>/dev/null || return 0; fi
    if [ -n "$1" ]; then
        qs=$(cmd package art dump "$1" 2>/dev/null | dexstates | head -n 1)
        [ -n "$qs" ] && [ -f "$AFD" ] && { { grep -v -e "^$1=" -e '^apps_state_time=' "$AFD"; echo "$qs"; echo "apps_state_time=$(date +%s)"; } > "$AFD.new" && mv "$AFD.new" "$AFD"; }
    else
        qs=$(cmd package art dump 2>/dev/null | dexstates)
        [ -z "$qs" ] && qs=$(dumpsys package dexopt 2>/dev/null | dexstates)
        if [ -n "$qs" ]; then { echo "$qs"; echo "apps_state_time=$(date +%s)"; } > "$AFD.new" && mv "$AFD.new" "$AFD"; rm -f "$AFAIL"
        else : > "$AFAIL"; log "could not read the compile states"; fi
    fi
    [ -f "$AFD" ] && put_app_file "$AFD" apps_state
    rmdir "$RL"
}
fixpkg() {   # the same stale copy cleanup as fixcache in dexopt_all.sh, for one package
    pm path "$1" | sed 's/^package://' | while read qk; do
        case $qk in /system/*|/product/*|/system_ext/*) ;; *) continue;; esac
        qd=${qk%/*}; qb=${qk##*/}; qb=${qb%.apk}
        [ -f "$qd/oat/arm64/$qb.odex" ] || continue
        rm -f "$DALVIK"/arm64/$(echo "${qk#/}" | sed 's|/|@|g')@classes.*
    done
}
pkg_job() {   # $1 speed|speed-profile|reset, $2 package
    echo "$2:running" > "$PST"
    qr=done; qo=
    if ! allowed_in "$1" "speed speed-profile reset" || ! pkgok "$2" || ! pm path "$2" > /dev/null 2>&1; then qr=failed
    elif [ "$1" = reset ]; then qo=$(cmd package compile --reset "$2" 2>&1) || qr=failed
    else qo=$(cmd package compile -m "$1" -f "$2" 2>&1) || qr=failed
    fi
    echo "$qo" | grep -qE '^(Failure|Error)|Exception|Unknown' && qr=failed
    if [ $qr = done ] && [ "$1" != reset ]; then
        fixpkg "$2"
        # a running process keeps the old code; never stop the interface, the phone service or this app itself
        case "$2" in org.tablet.tuner|org.m30s.tuner|android|com.android.systemui|com.android.phone|com.google.android.apps.nexuslauncher|com.android.launcher3) ;; *) am force-stop "$2";; esac
    fi
    log "$1 $2 $qr: $(echo "$qo" | head -n 1)"
    apps_refresh "$2"
    qs=; [ -f "$QC" ] && read -r qd qf qs < "$QC"; [ -n "$qs" ] && echo "$((qd + 1)) $((qf + $([ $qr = failed ] && echo 1 || echo 0))) $qs" > "$QC"
    echo "$2:$qr" > "$PST"
}
qworker() {   # one job at a time; the empty check and the flag reset happen under the queue lock, so a request that arrives meanwhile is never stranded
    while :; do
        qlock || break
        qj=$(sed -n 1p "$QF" 2>/dev/null)
        if [ -z "$qj" ]; then rm -f "$QC"; rmdir "$QR"; qunlock; break; fi
        sed 1d "$QF" > "$QF.new"; mv "$QF.new" "$QF"; qunlock
        set -- $qj; pkg_job "$1" "$2"
    done
}
pkg_enqueue() {   # $1 speed|speed-profile|reset, $2 package
    [ "$M30S_NO_COMPILE" = 1 ] && { log "compile refused: validation daemon (M30S_NO_COMPILE=1)"; return 1; }
    if [ "$(cstat)" = running ] || fbrunning; then log "refused $1 $2: system compile running"; echo "$2:failed" > "$PST"; return 1; fi
    pkgok "$2" && pm path "$2" > /dev/null 2>&1 || { log "no package $2"; return 1; }
    qlock || return 1
    if ! grep -qx "$1 $2" "$QF" 2>/dev/null; then echo "$1 $2" >> "$QF"; fi
    qunlock
    if mkdir "$QR" 2>/dev/null; then echo "0 0 $(date +%s)" > "$QC"; bg qworker; fi
}
# ---------- compile progress ----------
# dexopt_all.sh prints "<package>" and then Success/Failure for its explicit lists, "[<package>] Success|Failure" for the last step (-a), and ends with DONE. The daemon
# writes "=== run <epoch> ===" first. A line without its newline is not counted (the writer is still on it).
dxrun() { n=$(grep -n '^=== run ' "$DXL" 2>/dev/null | tail -n 1 | cut -d: -f1); tail -n +${n:-1} "$DXL" 2>/dev/null; }
dxparse() {   # stdin: the run. Sets C_CUR, C_KIND (compiling: no result yet; finished), C_DONE, C_FAIL, C_START, C_END
    C_CUR=; C_KIND=; C_DONE=0; C_FAIL=0; C_START=; C_END=; seen=" "; dp=
    while IFS= read -r dl; do
        case $dl in
            '=== run '*) C_START=${dl#=== run }; C_START=${C_START%% *}; case $C_START in ''|*[!0-9]*) C_START=;; esac;;
            DONE) C_END=1;;
            Success*|Failure*)
                [ -z "$dp" ] && continue
                case $seen in *" $dp "*) ;; *) seen="$seen$dp "; C_DONE=$((C_DONE + 1)); case $dl in Failure*) C_FAIL=$((C_FAIL + 1));; esac;; esac
                dp=; C_KIND=finished;;
            \[*\]\ Success*|\[*\]\ Failure*)
                pk=${dl#\[}; pk=${pk%%\]*}; C_CUR=$pk; C_KIND=finished; dp=
                case $seen in *" $pk "*) ;; *) seen="$seen$pk "; C_DONE=$((C_DONE + 1)); case ${dl#*\] } in Failure*) C_FAIL=$((C_FAIL + 1));; esac;; esac;;
            ''|[!A-Za-z]*|*[!A-Za-z0-9_.]*|*..*|*.) ;;
            *.*) C_CUR=$dl; dp=$dl; C_KIND=compiling;;
        esac
    done
}
mmss() { printf '%d:%02d' $(($1 / 60)) $(($1 % 60)); }
pubcompile() {
    cs=$(cstat)
    echo "compile_status=$cs"
    echo "compile_pkg_status=$(cat "$PST" 2>/dev/null)"
    echo "compile_queue=$(cut -d' ' -f2 "$QF" 2>/dev/null | tr '\n' ',' | sed 's/,$//')"
    if [ "$cs" = running ]; then
        dxrun > "$WORK/dx.run"; dxparse < "$WORK/dx.run"
        t=$(cat "$DXT" 2>/dev/null); t=$((${t:-0} + 0)); [ "$t" -gt 0 ] && [ "$t" -lt "$C_DONE" ] && t=$C_DONE
        echo "compile_current=$C_CUR"; echo "compile_current_state=$C_KIND"; echo "compile_done=$C_DONE"; echo "compile_total=$t"
        echo "compile_failed=$C_FAIL"; echo "compile_started=$C_START"
    elif [ -d "$QR" ] && [ -f "$QC" ]; then   # the per app queue: jobs done, the running one and the waiting ones are all known
        read -r qd qf qs < "$QC"; ps_=; [ -f "$PST" ] && read -r ps_ < "$PST"
        qw=0; [ -f "$QF" ] && qw=$(wc -l < "$QF" | tr -d ' '); qw=$((qw + 0)); qr_=0; qc_=; case $ps_ in *:running) qc_=${ps_%:*}; qr_=1;; esac
        echo "compile_current=$qc_"; echo "compile_current_state=$([ -n "$qc_" ] && echo compiling)"; echo "compile_done=$qd"
        echo "compile_total=$((qd + qr_ + qw))"; echo "compile_failed=$qf"; echo "compile_started=$qs"
    elif [ "$cs" = done ]; then
        [ -f "$DXSUM" ] || { dxrun > "$WORK/dx.run"; dxparse < "$WORK/dx.run"; e=$(cat "$DXE" 2>/dev/null); echo "$C_DONE done, $C_FAIL failed$([ -n "$C_START" ] && [ -n "$e" ] && echo " in $(mmss $((e - C_START)))")" > "$DXSUM"; }
        echo "compile_summary=$(cat "$DXSUM")"
    fi
    echo "apps_state_time=$(sed -n 's/^apps_state_time=//p' "$AFD" 2>/dev/null)"
    echo "apps_refresh=$([ -d "$RL" ] && echo running || { [ -f "$AFAIL" ] && echo failed || echo idle; })"
}

# ---------- Boost while a CarPlay receiver is on screen ----------
# From Battery to Balanced while DiPlay or its fork Pillion is the top app, then back. Only when the mode is Battery with no saved profile; anything else is left alone.
BOOSTF=$WORK/carplay.boost
carplay_pkgs() { for cp in org.tablet.pillion com.shihab.diplay; do pm path "$cp" > /dev/null 2>&1 && printf '%s ' "$cp"; done; }
carplay_top() {   # the top app has oom_score_adj 0; a running session that is not on screen has a higher one
    for cp in org.tablet.pillion com.shihab.diplay; do for cpid in $(pidof "$cp"); do [ "$(cat "$PROC/$cpid/oom_score_adj" 2>/dev/null)" = 0 ] && return 0; done; done
    return 1
}
boostwatch() {
    if [ "$(value carplay_boost)" != 1 ]; then
        # switched off while boosted: Battery comes back, unless the user chose something else meanwhile
        if [ -f "$BOOSTF" ]; then
            if [ "$(value perf_profile)" = balanced ] && [ -z "$(value profile_active)" ]; then profile battery && log "carplay boost off"; fi
            rm -f "$BOOSTF"
        fi
        return 0
    fi
    if carplay_top; then
        [ -f "$BOOSTF" ] && return 0
        [ "$(value perf_profile)" = battery ] && [ -z "$(value profile_active)" ] || return 0
        echo battery > "$BOOSTF"
        profile balanced && log "carplay boost on"
    elif [ -f "$BOOSTF" ]; then
        # only put it back while the boost is still what is set: if the user picked something else meanwhile, theirs wins
        if [ "$(value perf_profile)" = balanced ] && [ -z "$(value profile_active)" ]; then profile battery && log "carplay boost off"; else log "carplay boost dropped"; fi
        rm -f "$BOOSTF"
    fi
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
        read_ahead_kb) ra_ok && number "$v" && allowed_in "$v" "128 256 512 1024 2048" || return 1; setblk read_ahead_kb "$v"; return;;
        tcp_cc) name_ok "$v" && allowed_in "$v" "$(readnode "$PROC/sys/net/ipv4/tcp_available_congestion_control")" || return 1; path=$PROC/sys/net/ipv4/tcp_congestion_control;;
        gpu_max)
            [ -n "$GPU" ] && [ -f "$GPU/dvfs_max_lock" ] && [ ! -L "$GPU/dvfs_max_lock" ] || return 1
            if [ "$v" != -1 ]; then
                number "$v" && allowed_in "$v" "$(readnode "$GPU/dvfs_table")" || return 1
                min=$(readnode "$GPU/dvfs_min_lock"); min=${min%% *}
                case "$min" in ''|-1|0) ;; *[!0-9]*) return 1;; *) [ "$v" -ge "$min" ] || return 1;; esac
            fi
            gpu_lock_set "$v"; return;;
        swappiness) number "$v" && [ "$v" -le 200 ] || return 1; path=$PROC/sys/vm/swappiness;;
        vfs_cache) number "$v" && allowed_in "$v" "25 50 100 150 $(stockof vfs_cache)" || return 1; path=$PROC/sys/vm/vfs_cache_pressure;;
        page_cluster) number "$v" && allowed_in "$v" "0 1 2 3" || return 1; path=$PROC/sys/vm/page-cluster;;
        watermark) number "$v" && allowed_in "$v" "10 20 30 $(stockof watermark)" || return 1; path=$PROC/sys/vm/watermark_scale_factor;;
        extra_free) number "$v" && allowed_in "$v" "0 24576 49152 98304 $(stockof extra_free)" || return 1; path=$PROC/sys/vm/extra_free_kbytes;;
        schedstats) bool01 "$v" || return 1; path=$PROC/sys/kernel/sched_schedstats;;
        up_rate|down_rate)
            rate_ok "${k%_rate}" || return 1
            rn=up_rate_limit_us; rl="0 2000 5000 10000"
            [ "$k" = down_rate ] && { rn=down_rate_limit_us; rl="2000 5000 10000 20000 40000"; }
            number "$v" && allowed_in "$v" "$rl $(stockof $k)" || return 1
            r0=$P0/schedutil/$rn; r4=$P4/schedutil/$rn
            [ -f "$r0" ] && [ ! -L "$r0" ] && [ -f "$r4" ] && [ ! -L "$r4" ] || return 1
            o0=$(readnode "$r0"); o4=$(readnode "$r4")
            if rate_set "$v"; then return 0; fi
            writecheck "$r0" "$o0"; writecheck "$r4" "$o4"; return 1;;
        deep_idle)
            bool01 "$v" || return 1
            nodes=$(idlenodes); [ -n "$nodes" ] || return 1
            for n in $nodes; do printf '%s %s\n' "$n" "$(readnode "$n")"; done > "$WORK/idle.snap"
            ibad=0; for n in $nodes; do writecheck "$n" $((1 - v)) || ibad=1; done
            [ $ibad = 0 ] && return 0
            while read -r n o; do [ -n "$o" ] && writecheck "$n" "$o"; done < "$WORK/idle.snap"; return 1;;
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
# What the framework offers and its settings right now. Each `settings get` is a process, so this is rebuilt in the background (at start, every minute and after a
# request that changed a setting) into $WORK/slow, which publish copies. A key is published only when this ROM can change it.
xcur() {
    case "$1" in
        screen_timeout) sget system screen_off_timeout "";;
        font_scale) sget system font_scale 1.0;;
        font_weight) sget secure font_weight_adjustment 0;;
        text_contrast) sget secure high_text_contrast_enabled 0;;
        stay_awake) sget global stay_on_while_plugged_in 0;;
        auto_rotate) sget system accelerometer_rotation 1;;
        show_taps) sget system show_touches 0;;
        window_blur) sget global disable_window_blurs 0;;
        anim_scale) sget global window_animation_scale 1.0;;
        dns) dnscur;;
        bg_procs) bgcur;;
        cached_apps) cachedcur;;
        night) nightok && nightcur;;
        nav_mode) navok && navcur;;
        density) densnow;;
        wifi_country) wifiok && { wv=$(value wifi_country); echo "${wv:-auto}"; };;
        adb_tcp) adbtcpcur;;
        serial_console) [ -n "$(getprop init.svc.console)" ] && consolecur;;
        logging) loggingcur;;
        black_theme) ovl "$BLACK" && { if ovlenabled "$BLACK"; then echo 1; else echo 0; fi; };;
    esac
}
slow_data() {
    for sx in screen_timeout font_scale font_weight text_contrast stay_awake auto_rotate show_taps window_blur anim_scale dns bg_procs cached_apps night nav_mode density wifi_country adb_tcp serial_console logging black_theme; do
        sv=$(xcur "$sx"); [ -n "$sv" ] && echo "$sx=$sv"
    done
    do_=$(densopts); [ -n "$do_" ] && { echo "density_opts=$do_"; echo "density_phys=$(densphys)"; }
    if themeok; then
        TJ=$(settings get secure theme_customization_overlay_packages 2>/dev/null); [ "$TJ" = null ] && TJ=
        echo theme_ok=1
        src=$(tjv color_source); [ -n "$src" ] && echo "palette_source=$src"
        acc=$(tjv accent_color); [ -n "$acc" ] && echo "accent=$acc"
        sty=$(tjv theme_style); [ -n "$sty" ] && echo "theme_style=$sty"
        fnt=$(tjv font); [ -n "$fnt" ] && echo "font=${fnt##*.}"
        shp=$(tjv adaptive_icon_shape); [ -n "$shp" ] && echo "icon_shape=${shp##*.}"
        pck=$(tjv "icon_pack.android" | sed 's/^com\.android\.theme\.icon_pack\.\(.*\)\.android$/\1/'); [ -n "$pck" ] && echo "icon_pack=$pck"
        echo "fonts=$(fontlist | tr ' ' ',' | sed 's/,$//')"
        if ovl "icon\\.squircle"; then echo has_shapes=1; else echo has_shapes=0; fi
        if ovl "icon_pack\\.rounded\\.android"; then echo has_packs=1; else echo has_packs=0; fi
    fi
    cps=$(carplay_pkgs); [ -n "$cps" ] && { echo "carplay_pkgs=$(echo $cps | tr ' ' ',')"; echo "carplay_boost=$(curval carplay_boost)"; }
    return 0
}
# What this kernel offers and the values only a boot or a new disk changes. Rebuilt in the background every minute and once at start (about a hundred
# small commands: on the phone the whole state took 12 s with these in it, and a request waits for the publish in progress).
static_data() {
        # Capabilities: what this kernel offers right now. The app builds its option lists from these and hides what is missing.
        echo caps=2
        echo "governors=$(csv "$(governors)")"
        echo "profiles=$(csv "$(profiles)")"
        for pr in battery balanced; do
            case "$pr" in battery) pl=$(stepbelow "$P0/scaling_available_frequencies" $(($(maxfreq "$P0/scaling_available_frequencies") * 77 / 100))); pb=$(stepbelow "$P4/scaling_available_frequencies" $(($(maxfreq "$P4/scaling_available_frequencies") * 77 / 100)));;
                *) pl=$(maxfreq "$P0/scaling_available_frequencies"); pb=$(maxfreq "$P4/scaling_available_frequencies");; esac
            echo "profile_$pr=$pl,$pb"
        done
        if touch_ok; then echo touch_supported=1; else echo touch_supported=0; fi
        recovery_part && echo reboot_recovery=1
        echo "io_devices=$(csv "$(disks)")"
        if [ -n "$(disks)" ]; then
            echo "io_scheds=$(csv "$(blkcommon scheduler)")"
            ra_ok && echo "read_aheads=128,256,512,1024,2048"
        fi
        echo "tcp_ccs=$(csv "$(readnode "$PROC/sys/net/ipv4/tcp_available_congestion_control")")"
        if [ -n "$GPU" ] && [ -f "$GPU/dvfs_table" ] && [ -f "$GPU/dvfs_max_lock" ]; then echo "gpu_freqs=$(csv "$(readnode "$GPU/dvfs_table")")"; fi
        for sk in $STOCKKEYS; do sv=$(stockof "$sk"); [ -n "$sv" ] && echo "stock_$sk=$sv"; done
        echo "little_freqs=$(csv "$(readnode "$P0/scaling_available_frequencies")")"
        echo "big_freqs=$(csv "$(readnode "$P4/scaling_available_frequencies")")"
        return 0
}
refresh_static() {
    mkdir "$WORK/static.lock" 2>/dev/null || return 0
    static_data > "$WORK/static.new" 2>/dev/null && mv "$WORK/static.new" "$WORK/static"
    rmdir "$WORK/static.lock"
}
refresh_slow() {
    mkdir "$WORK/slow.lock" 2>/dev/null || return 0
    slow_data > "$WORK/slow.new" 2>/dev/null; mv "$WORK/slow.new" "$WORK/slow"
    : > "$WORK/slow.fresh"   # the main loop publishes once more: the new values are in the state a moment after the request that changed them
    rmdir "$WORK/slow.lock"
}
# A request that arrives while the state is being built is answered first: the build stops at its next checkpoint (the half built file is thrown away) and
# the main loop handles the request at once. At most three times in a row, so the state is still written when requests keep coming.
PUBYIELD=0
request_waiting() { for ra_ in $APPS; do [ -f "$ra_/request" ] && [ ! -L "$ra_/request" ] && return 0; done; return 1; }
checkpoint() { [ $PUBYIELD -lt 3 ] && request_waiting && { PUBYIELD=$((PUBYIELD + 1)); return 0; }; return 1; }
# builds the state once into $WORK/state.new: 0 done, 2 stopped for a request
build_state() {
    {
        echo backend=m30s
        printf 'status=%s\n' "$STATUS"
        printf 'last_request=%s\n' "$LASTREQ"
        mn=$(mode_now); echo "perf_profile=$mn"; echo "preset=$mn"
        checkpoint && return 2   # mode_now compares every stock value: seconds on a loaded phone
        for spec in "cap_little:$P0/scaling_max_freq" "cap_big:$P4/scaling_max_freq" "governor:$P0/scaling_governor" "governor_big:$P4/scaling_governor" "swappiness:$PROC/sys/vm/swappiness" "cpu_little_khz:$P0/scaling_cur_freq" "cpu_big_khz:$P4/scaling_cur_freq" "temp_mc:$SYS/class/thermal/thermal_zone0/temp" "battery_percent:$SYS/class/power_supply/battery/capacity"; do
            checkpoint && return 2
            key=${spec%%:*}; node=${spec#*:}; printf '%s=%s\n' "$key" "$(readnode "$node")"
        done
        if touch_ok; then
            echo "touch_duration_ms=$(readnode "$BOOST/duration_ms")"
            case "$(readnode "$BOOST/enabled")" in Y|1) echo touch_enabled=1;; N|0) echo touch_enabled=0;; esac
        fi
        if [ -n "$(disks)" ]; then
            echo "io_sched=$(blkcurrent scheduler)"
            ra_ok && echo "read_ahead_kb=$(blkcurrent read_ahead_kb)"
        fi
        checkpoint && return 2
        echo "tcp_cc=$(readnode "$PROC/sys/net/ipv4/tcp_congestion_control")"
        if [ -n "$GPU" ]; then
            echo "gpu_khz=$(readnode "$GPU/clock")"
            if [ -f "$GPU/dvfs_table" ] && [ -f "$GPU/dvfs_max_lock" ]; then echo "gpu_max=$(gpu_lock_now)"; fi
        fi
        checkpoint && return 2
        for ck in vfs_cache page_cluster watermark extra_free schedstats up_rate down_rate deep_idle; do
            checkpoint && return 2
            cv=$(curval "$ck"); [ -n "$cv" ] && echo "$ck=$cv"
        done
        checkpoint && return 2
        echo "saved_profiles=$(pf_names)"
        echo "profile_active=$(value profile_active)"
        echo "profile_base=$(value profile_base)"
        echo "mem_available=$(awk '/^MemAvailable:/ {print $2}' "$PROC/meminfo")"
        checkpoint && return 2
        [ -f "$WORK/static" ] && cat "$WORK/static"
        [ -f "$WORK/slow" ] && cat "$WORK/slow"
        checkpoint && return 2
        pubcompile
    } > "$WORK/state.new"
    _br=$?
    [ $_br = 0 ] && PUBYIELD=0
    return $_br
}
# puts the built state into one app's directory (a copy each: both apps get the same state from one build)
deliver_state() {
    [ -d "$APP" ] && [ ! -L "$APP" ] && [ -f "$WORK/state.new" ] || return 1
    cp "$WORK/state.new" "$WORK/state.copy" || return 1
    if [ "$TEST" = 0 ]; then
        owner=$(stat -c %u "$APP"); group=$(stat -c %g "$APP")
        chown "$owner:$group" "$WORK/state.copy"
        chcon --reference="$APP" "$WORK/state.copy" 2>/dev/null || restorecon "$WORK/state.copy"
    fi
    chmod 0644 "$WORK/state.copy"; mv "$WORK/state.copy" "$STATE"
}
publish() { build_state && deliver_state; _pr=$?; rm -f "$WORK/state.new"; return $_pr; }
# the new status line goes into the published state at once (a full publish takes seconds on the phone)
quick_status() {
    [ -f "$STATE" ] && [ ! -L "$STATE" ] || return 0
    { while IFS= read -r ql || [ -n "$ql" ]; do case "$ql" in status=*) printf 'status=%s\n' "$STATUS";; last_request=*) printf 'last_request=%s\n' "$LASTREQ";; *) printf '%s\n' "$ql";; esac; done < "$STATE"; } > "$WORK/state.quick" 2>/dev/null || return 0
    if [ "$TEST" = 0 ]; then chown "$(stat -c %u "$APP"):$(stat -c %g "$APP")" "$WORK/state.quick"; chcon --reference="$APP" "$WORK/state.quick" 2>/dev/null || restorecon "$WORK/state.quick"; fi
    chmod 0644 "$WORK/state.quick"; mv "$WORK/state.quick" "$STATE"
}
reject() { STATUS="Rejected $1; $2"; return 1; }
handle() {
    [ -f "$APP/request" ] && [ ! -L "$APP/request" ] || return 0
    [ "$(wc -c < "$APP/request")" -le 128 ] || { rm "$APP/request"; HANDLED=1; LASTREQ=oversized; STATUS='Rejected oversized request'; return 1; }
    mv "$APP/request" "$APP/request.processing" || return 1
    HANDLED=1
    line=$(cat "$APP/request.processing"); rm "$APP/request.processing"
    case "$line" in *[!A-Za-z0-9._=-]*) LASTREQ=rejected;; *) LASTREQ=$line;; esac   # echoed in the state: the app shows the status once this is its newest request
    case "$line" in *=*) key=${line%%=*}; val=${line#*=};; *) STATUS='Rejected malformed request'; return 1;; esac
    case "$line" in *'
'*) STATUS='Rejected multiple requests'; return 1;; esac
    case "$key" in ''|*[!A-Za-z0-9_]*) STATUS='Rejected malformed request'; return 1;; esac
    case "$val" in ''|*[!A-Za-z0-9._-]*) reject "$key" "value not allowed"; return 1;; esac
    if [ "$key" = preset ]; then key=perf_profile; fi
    case "$key" in
        perf_profile)
            if profile "$val"; then savekey profile_active ""; savekey profile_base ""; STATUS="Applied $val; thermal limits unchanged"; else STATUS='Rejected or restored failed profile'; return 1; fi;;
        restart_ui) [ "$val" = 1 ] || { reject "$key" "no supported value"; return 1; }; pkill -f com.android.systemui; STATUS='Restarting the interface';;
        reboot) [ "$val" = 1 ] || { reject "$key" "no supported value"; return 1; }; STATUS='Rebooting'; PUBYIELD=3; publish; sync; reboot;;
        reboot_recovery) [ "$val" = 1 ] || { reject "$key" "no supported value"; return 1; }; recovery_part || { reject "$key" "no recovery partition"; return 1; }; STATUS='Rebooting to recovery'; PUBYIELD=3; publish; sync; reboot recovery;;
        compile_now|compile_all)
            [ "$val" = 1 ] || { reject "$key" "no supported value"; return 1; }
            if [ "$key" = compile_all ]; then cf=-f; else cf=; fi
            if compile $cf; then STATUS='Compile started'; else reject "$key" "cannot start now"; return 1; fi;;
        compile_pkg|compile_pkg_profile|reset_pkg)
            case "$key" in compile_pkg) cm=speed;; compile_pkg_profile) cm=speed-profile;; *) cm=reset;; esac
            if pkg_enqueue "$cm" "$val"; then STATUS="Queued $cm for $val"; else reject "$key" "cannot queue it"; return 1; fi;;
        refresh_apps) [ "$val" = 1 ] || { reject "$key" "no supported value"; return 1; }; bg apps_refresh; STATUS='Reading compile states';;
        save_profile) if pf_save "$val"; then savekey profile_active "$val"; savekey profile_base "$val"; STATUS="Saved profile $val"; else reject "$key" "name or limit"; return 1; fi;;
        update_profile) if [ -n "$(pf_line "$val")" ] && pf_save "$val"; then savekey profile_active "$val"; savekey profile_base "$val"; STATUS="Updated profile $val"; else reject "$key" "no such profile"; return 1; fi;;
        apply_profile) if pf_apply "$val"; then STATUS="Using profile $val"; bg refresh_slow; else reject "$key" "restored the previous settings"; return 1; fi;;
        delete_profile)
            pf_delete "$val"
            [ "$(value profile_active)" = "$val" ] && savekey profile_active ""
            [ "$(value profile_base)" = "$val" ] && savekey profile_base ""
            STATUS="Deleted profile $val";;
        carplay_boost)
            if bool01 "$val" && [ -n "$(carplay_pkgs)" ]; then savekey carplay_boost "$val"; savekey profile_active ""; STATUS="Applied $key"; bg refresh_slow; else reject "$key" "no supported value"; return 1; fi;;
        *)
            if set_any "$key" "$val"; then
                persisted "$key" && savekey "$key" "$val"
                mode_key "$key" && savekey perf_profile custom
                allowed_in "$key" "$PKEYS" && savekey profile_active ""
                is_x "$key" && bg refresh_slow
                STATUS="Applied $key; readback verified"
            else STATUS="Rejected $key; no supported value"; return 1
            fi;;
    esac
}
# saved values are parsed as data and revalidated; the rates go last because they belong to the governor
restore_config() {
    [ -f "$CFG" ] && [ ! -L "$CFG" ] && [ "$(wc -c < "$CFG")" -le 4096 ] || return 0
    for pass in 1 2; do
        while IFS='=' read -r key val; do
            case "$key" in up_rate|down_rate) [ $pass = 2 ] || continue;; *) [ $pass = 1 ] || continue;; esac
            case "$key" in
                ''|perf_profile|profile_active|profile_base|carplay_boost|wifi_country|anim_scale) ;;   # anim_scale: older versions saved it; the Settings database keeps it
                touch_enabled|touch_duration_ms) touch_ok && { apply "$key" "$val" || STATUS="Could not restore $key"; };;   # the module is not in every kernel
                gpu_max) [ -n "$GPU" ] && { apply "$key" "$val" || STATUS="Could not restore $key"; };;
                read_ahead_kb) ra_ok && { apply "$key" "$val" || STATUS="Could not restore $key"; };;
                *) set_any "$key" "$val" || STATUS="Could not restore $key";;
            esac
        done < "$CFG"
    done
}
# Fresh installation does not apply any preset or alter current device settings.
started=0
APPS=$APP
if [ "$TEST" = 1 ]; then
    [ ! -d "$FIXTURE/app-tablet" ] || APPS="$APP $FIXTURE/app-tablet"
else APPS="$APP /data/user/0/org.tablet.tuner/files"; fi
refresh_slow; SLOWAT=$(date +%s); DISKAT=0; SSPID=; PUBAT=0; LASTBUSY=x; DISKS_OK=
rmdir "$WORK/static.lock" "$WORK/qf.lock" "$WORK/q.run" "$WORK/r.lock" "$WORK/slow.lock" 2>/dev/null; rm -f "$QF" "$PST" "$AFAIL" "$QC"
[ -f "$WORK/tuner.log" ] && [ "$(wc -c < "$WORK/tuner.log")" -gt 262144 ] && mv "$WORK/tuner.log" "$WORK/tuner.log.1"
# the daemon does little per round: the state is rebuilt (about a hundred small commands) after a request, every round while something compiles and every 20 s
# otherwise; the live clocks and temperature in the app come from /sys directly
while :; do
    own_lock || { log "lock lost, daemon exits"; exit 1; }   # rollback or a newer daemon: nothing is done here without the lock
    now=$(date +%s)
    if [ $((now - DISKAT)) -ge 20 ]; then DISKAT=$now; DISKS=$(disks_scan | tr '\n' ' '); DISKS_OK=1; fi
    if [ $((now - SLOWAT)) -ge 60 ]; then SLOWAT=$now; rate_probe up; rate_probe down; bg refresh_slow; bg refresh_static; fi
    need=0; busy=0; YIELDED=0
    [ -d "$QR" ] && busy=1
    [ "$busy" = 0 ] && [ -f "$DXP" ] && [ "$(cstat)" = running ] && busy=1
    [ "$busy" = "$LASTBUSY" ] || { need=1; LASTBUSY=$busy; }
    [ "$busy" = 1 ] && need=1
    [ $((now - PUBAT)) -ge 20 ] && need=1
    [ -f "$WORK/slow.fresh" ] && { rm -f "$WORK/slow.fresh"; need=1; }
    for APP in $APPS; do
        if [ -d "$APP" ] && [ ! -L "$APP" ]; then
            STATE=$APP/state
            if [ "$started" = 0 ]; then
                started=1; need=1
                ra_probe; rate_probe up; rate_probe down
                pf_check
                stock_capture
                refresh_static
                restore_config
                [ -f "$AFD" ] && put_app_file "$AFD" apps_state
                [ "$TEST" = 1 ] && bg wifiboot
            fi
            HANDLED=0; handle; [ "$HANDLED" = 1 ] && { need=1; quick_status; log "request $LASTREQ answered: $STATUS"; }
        fi
    done
    if [ "$need" = 1 ]; then
        PUBAT=$now
        have=0; for APP in $APPS; do [ -d "$APP" ] && [ ! -L "$APP" ] && have=1; done
        if [ $have = 1 ]; then
            build_state; br=$?
            if [ $br = 0 ]; then
                for APP in $APPS; do STATE=$APP/state; deliver_state; done
            elif [ $br = 2 ]; then YIELDED=1; log "state build stopped for a request ($PUBYIELD)"; fi
            rm -f "$WORK/state.new"
        fi
        pubs=$(( $(date +%s) - now )); [ $pubs -ge 3 ] && log "publish took $pubs s"   # evidence for the stale-state reports
    fi
    boostwatch
    if [ $((now % 5)) -eq 0 ] || [ "$TEST" = 1 ]; then sp=$(pidof system_server 2>/dev/null); if [ -n "$sp" ] && [ "$sp" != "$SSPID" ]; then SSPID=$sp; bg wifiboot; fi; fi
    if [ "$YIELDED" = 1 ]; then YIELDED=0; continue; fi   # the request that stopped the build is handled in the next round, without waiting
    [ "$1" = --once ] && break
    sleep 1
done
