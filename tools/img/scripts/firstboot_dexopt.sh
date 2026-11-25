#!/system/bin/sh
# Compiles the apps in speed mode by itself after a data wipe. Started once per boot by zz_firstboot_dexopt.rc; does nothing when $D/.dexopt_done exists.
# Pass 1 waits until the setup wizard is finished (Settings.Secure user_setup_complete=1; at most 20 minutes, then it starts anyway), so the wizard has the CPU
# (measured on a fresh-data boot: dex2oat at about 400% CPU and load average 25 to 57 while the wizard was open). Pass 2 runs 45 minutes after pass 1,
# after the Play Store has updated Play services, Maps and YouTube (an update resets them to interpreted code). Apps that are already compiled are skipped
# (DEXOPT_FORCE empty). ART Service starts dex2oat itself (nice 10, cgroup /dev/cpuctl/dex2oat with the default cpu.shares 1024, measured on the phone), so
# nice on this shell would not reach it and renice alone only orders tasks inside that group. While a pass runs, cpu.shares of that group is 2 (the wizard and
# GMS in other groups win every contention, also in the 20-minute fallback) and the dex2oat processes are reniced to 19.
# Log: $D/dexopt.log. The D, DEXOPT_ALL and SETUP_WAIT_STEPS overrides are for the host test (tools/img/test_startup_scripts.py).
D=${FIRSTBOOT_DIR:-/data/local/tmp}
# Network location (Wi-Fi positioning): without the setup wizard Play services has no location opt-in and its location app ops stay on "ignore", so
# its network location service refuses its own requests ("Appop Denial ... requires appop COARSE_LOCATION"). Once, when Play services is installed.
L=$D/.location_done
if [ ! -f $L ] && pm path com.google.android.gms >/dev/null 2>&1; then
  for p in ACCESS_FINE_LOCATION ACCESS_COARSE_LOCATION ACCESS_BACKGROUND_LOCATION NEARBY_WIFI_DEVICES; do pm grant com.google.android.gms android.permission.$p; done
  appops reset com.google.android.gms
  for o in COARSE_LOCATION FINE_LOCATION NEARBY_WIFI_DEVICES; do appops set --uid com.google.android.gms $o allow; done
  settings put secure google_location_accuracy_enabled 1
  settings put secure network_location_opt_in 1
  settings put global network_location_opt_in 1
  touch $L
fi
M=$D/.dexopt_done
[ -f $M ] && exit 0
export DEXOPT_FORCE=""
A=${DEXOPT_ALL:-/system/bin/dexopt_all.sh}
C=${CPUCTL_DEX2OAT:-/dev/cpuctl/dex2oat}
lowprio() { while :; do p=$(pidof dex2oat32 dex2oat64 dex2oat); [ -n "$p" ] && { renice -n 19 -p $p; ionice -c 3 -p $p; } >/dev/null 2>&1; sleep 5; done; }     # secondary to cpu.shares; ionice idle: dex2oat writes hundreds of MB
psi() { echo "shares=$(cat $C/cpu.shares 2>/dev/null) psi: $(head -n1 /proc/pressure/cpu 2>/dev/null)"; }
# cleanup puts back the cpu.shares value that was there before the pass (read, not assumed) and stops the helpers; it runs on a normal end and on TERM, INT and HUP
# (those turn into exit, so the EXIT trap runs). SIGKILL cannot be caught: the value then stays 2 until the next boot, when init recreates the group.
cleanup() { [ -n "$r" ] && kill $r 2>/dev/null; [ -n "$w" ] && kill $w 2>/dev/null; r=; w=; [ -n "$prev" ] && echo $prev > $C/cpu.shares; prev=; }
trap cleanup EXIT; trap 'exit 143' TERM INT HUP
pass() {
  [ -w $C/cpu.shares ] && { prev=$(cat $C/cpu.shares); echo 2 > $C/cpu.shares; }
  echo "$(date) pass start, was $prev, now $(psi)" >> $D/dexopt.log
  lowprio & r=$!
  sh $A >> $D/dexopt.log 2>&1 & w=$!; wait $w      # not in the foreground: a trap only runs when the shell is not waiting for a child
  echo "$(date) pass end $(psi)" >> $D/dexopt.log
  cleanup
}
echo "$(date) firstboot dexopt waiting for setup" >> $D/dexopt.log
i=0; while [ $i -lt ${SETUP_WAIT_STEPS:-120} ] && [ "$(settings get secure user_setup_complete 2>/dev/null)" != 1 ]; do sleep 10; i=$((i + 1)); done
echo "$(date) firstboot dexopt pass 1 (setup wait steps: $i)" >> $D/dexopt.log
pass
sleep 2700
echo "$(date) firstboot dexopt pass 2" >> $D/dexopt.log
pass
touch $M
