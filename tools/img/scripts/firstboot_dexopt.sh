#!/system/bin/sh
# Compiles the apps in speed mode by itself after a data wipe. Started once per boot by zz_firstboot_dexopt.rc; does nothing when $D/.dexopt_done exists.
# Pass 1 waits until the setup wizard is finished (Settings.Secure user_setup_complete=1; at most 20 minutes, then it starts anyway), so the wizard has the CPU
# (measured on a fresh-data boot: dex2oat at about 400% CPU and load average 25 to 57 while the wizard was open). Pass 2 runs 45 minutes after pass 1,
# after the Play Store has updated Play services, Maps and YouTube (an update resets them to interpreted code). Apps that are already compiled are skipped
# (DEXOPT_FORCE empty). While a pass runs, the dex2oat processes are reniced to 19: ART Service starts them itself, so nice on this shell would not reach them.
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
lowprio() { while :; do renice -n 19 -p $(pidof dex2oat32 dex2oat64 dex2oat) >/dev/null 2>&1; sleep 5; done; }
pass() { lowprio & r=$!; sh $A >> $D/dexopt.log 2>&1; kill $r; }
echo "$(date) firstboot dexopt waiting for setup" >> $D/dexopt.log
i=0; while [ $i -lt ${SETUP_WAIT_STEPS:-120} ] && [ "$(settings get secure user_setup_complete 2>/dev/null)" != 1 ]; do sleep 10; i=$((i + 1)); done
echo "$(date) firstboot dexopt pass 1 (setup wait steps: $i)" >> $D/dexopt.log
pass
sleep 2700
echo "$(date) firstboot dexopt pass 2" >> $D/dexopt.log
pass
touch $M
