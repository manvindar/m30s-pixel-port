# A14 first boot on the M30s (2026-11-06)

**Result: Android 14 (crDroid 10.13 GSI, SDK 34) booted to the setup wizard on the first try**, with `boot-a14-permissive.img` (sboot adds `root=/dev/sda25`, the `-root` variant was not needed). Boot took about 3 minutes (`up 3 min`, load average 23 from first-boot dexopt).

## What was done (Gate C, TWRP 3.7.0_9-0)
1. `twrp format data` (f2fs userdata recreated; internal /sdcard was already copied to the Mac; the SD card was out).
2. `system-a14.img` streamed to `/dev/block/by-name/system`: `cat image | adb shell 'dd of=... bs=4194304'` (4 min, 20 MB/s). **TWRP's dd rejects `bs=4M`; use a number.** Read back with `sha256sum` in TWRP = `9a3351708301666f3ffe2050eb25b90418def310095d1422fe777099962ad24b`, equal to the image.
3. `boot-a14-permissive.img` the same way (bs=1048576); read-back hash `d37067a4...feff` = image.
4. `adb reboot`; no vendor change (vendor-mp2 not needed so far).

## Observed after boot (adb shell, uid 2000)
- `ro.build.version.release=14`, `ro.build.version.sdk=34`, `getenforce=Enforcing` (the permissive boot image did not make it permissive, nor was it needed), `init.svc.zygote=running`, `system_server` alive, focus = `com.google.android.setupwizard` WelcomeActivity.
- `ro.build.fingerprint` still shows the vendor's stock fingerprint (`samsung/m30sdd/...:11`), as expected for a GSI.
- `ro.boot.flash.locked=1` again (it was `0` in the stock Android after the unlock; value comes from the bootloader cmdline; fact, not chased). `ro.boot.warranty_bit=0` throughout.
- `gsm.sim.state=ABSENT,ABSENT` at the wizard stage (telephony **untested**; Samsung IMS is not expected on a GSI), `wlan0` DOWN at the wizard (Wi-Fi **untested**), baseband `M307FXXS4CWC1`.
- adb works without authorisation prompt (GSI userdebug-like defaults).

## Practical notes
- **adb after a `kill-server` inside the agent sandbox cannot see USB**; start the server outside the sandbox (`dangerouslyDisableSandbox`) once, then clients inside work. `heimdall` also needs the sandbox off.
- The SD card can go back in now (Android has booted).
- Rollback material: `work/partition-dump/` (+ copy in `~/Aistuff/m30s-pixel-port/partition-dump/`) and the stock firmware in `fw-extracted/`.

## Health check after the wizard (2026-11-06, read-only, adb over USB as uid 2000)
- User finished the wizard and enabled rooted debugging; **`adb root` made the USB link drop** (phone left USB; it came back only after a phone restart plus cable/File-transfer toggling). Wireless debugging pairing worked but the connect port was never obtained. Lesson: after enabling rooted debugging expect a USB re-enumeration; keep the phone in File transfer mode.
- Wi-Fi works: `wlan0` UP with an address on the user's LAN.
- Telephony: Samsung RIL v4.0 (`rild` x2 for dsds), `init.svc.ril-daemon{,1}=running`, `ril.halservice.registered.slot1/slot2=true`, `persist.radio.multisim.config=dsds`, baseband `M307FXXS4CWC1`; `com.android.phone` shows radio ON, `OUT_OF_SERVICE`, "Emergency calls only", network operator seen as MCC/MNC 302220 (Canada). `gsm.sim.state=ABSENT,ABSENT`, `ril.ICC_TYPE0/1=0` = **no SIM detected** (unknown whether the SIMs are in the trays; carrier details omitted). So the radio stack works; SIM and Vi CSFB/VoLTE remain untested.
- No crash entries in the crash log buffer; SELinux avc denials from `system_app` probing vendor radio HAL names (sprd/huawei) are noise.
- **Correction (user, same day): no SIM is inserted in the phone**, so `ABSENT,ABSENT` and "Emergency calls only" are correct, not a bug. The radio stack is healthy; SIM, calls, SMS and data stay untested until a SIM goes in.
