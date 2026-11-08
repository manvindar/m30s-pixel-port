# One UI 9 image: pre-flash checklist (desk, 2026-11-08)

Image: `fw-oneui9/work/out/system-oneui9-port.img` (built by `tools/oneui/build_oneui_port.py`, 5 s; rebuild it right before flashing, then take the sha256). Not flashed; the user said "not yet". Nothing here is run without god relaying the user's go.

## What is in v1 (all unproven on the phone)
Donor A266B One UI 9 /system trimmed to 4106 MiB of 4800, ext4. Init made permissive, a14 first-stage launcher, VNDK 30 + SELinux mapping 30.0, bionic/linker/libui/libbinder/libmeminfo patches, `services.jar` patch (HintManager without an AIDL power HAL, `isBuildConsistent`), `netbpfload` and `libnetd_updatable` kernel-version gates patched and bind-mounted, system_ext policy deduped against the stock vendor policy (compiles offline with a host `secilc`), Android 16 audioserver + library closure (`--audio-closure`), bootdiag, adb root without authorisation (`ro.adb.secure=0`). **Google layer (`--google-stage`, public sources only):** WebView (TrichromeLibrary + WebViewGoogle, multiArch unset, + GoogleWebViewOverlay) from Google's Pixel 9a factory image, Play services, Play Store, Services Framework, Partner Setup, Calendar/Contacts sync (MindTheGapps 16.0.0-arm64-20261023), all under `/product` (GSF under `/system/system_ext`). The privileged-permission allowlists cover every priv-app (offline check against the donor framework-res: 0 violations). Rebuild: `python3 -I tools/oneui/fetch_factory_product.py <FACTORY_URL> fw-oneui9/work/gl/product.img` (streams product.img only, 4.6 GiB peak, delete it after staging), `python3 -I tools/oneui/stage_google.py product.img MindTheGapps.zip fw-oneui9/work/gl/stage --keys <dir with platform.pk8/.x509.pem> --build-tools <BT>`.
**Fingerprint (`--fphal`, needs a JDK 17 `javac` on PATH):** the Pixel image's AIDL `IFingerprint/default` shim over the vendor HIDL 2.1 (`tools/fphal`; Samsung's framework `ISession` is plain AOSP, no sem* methods, and services.jar carries the HIDL `ISehBiometricsFingerprint@3.0` client for the Seh calls). The face feature xml is removed (no face HAL on the vendor).
**Not in it:** Samsung CSC/optics content, the proximity fix, Samsung radio/IMS verification (see below).
**Image fit:** 4681 of 4800 MiB used, e2fsck clean.

## Data: the wipe must be selective
On this phone `/sdcard` is `/data/media` on the same f2fs partition (sda32). TWRP "Format Data" or "Wipe Data" **deletes the user's /sdcard** and is forbidden. The Pixel userdata cannot be reused as is (A17 Pixel app data, package state), so before the first One UI boot remove everything in `/data` **except `/data/media`** (and `lost+found`):
```
adb shell 'cd /data && for d in * .[!.]*; do case "$d" in media|lost+found) ;; *) rm -rf "$d";; esac; done'
```
Then `ls /data` must show only `media` (plus `lost+found`) and `ls /data/media/0 | head` must still list the user's files. The userdata fstab line has no `fileencryption=ice` already (the Pixel line removed it), so no format is needed. This loses the Pixel setup, installed apps and the enrolled fingerprint (fingerprint templates live in /data/vendor_de or /data/vendor/biometrics: re-enrol later); it keeps photos and files.

## Flash (TWRP over adb, same as FLASH.md, nothing needs buttons: `adb reboot recovery` works)
1. Rebuild and hash: `python3 -I tools/oneui/build_oneui_port.py --base ... --out ... --audio-closure fw-oneui9/work/lineage16/closure` (the closure dir: `python3 tools/audio/a16_closure.py LineageOS-23.2-...img DIR` from the tablet repo, public GSI).
2. `adb reboot recovery`; `cat system-oneui9-port.img | adb exec-in 'dd of=/dev/block/by-name/system bs=1048576'`; the image is 4800 MiB.
3. Verify in 19 windows of 256 MiB against the image (as in FLASH.md).
4. Keep the current `vendor-a17` and `boot-a17` (v0.3e or v0.3f): the One UI image was built against exactly that vendor.
5. Selective /data wipe (above); `rm -rf /data/system/package_cache /data/dalvik-cache` is covered by it.
6. `adb reboot`.

## First boot: what to read, in order
`adb` should appear within ~60 s if init gets that far (adb root, no authorisation). If not, `adb reboot recovery` (Volume Up + Volume Down from a hung boot) and read from TWRP:
- `/data/local/tmp/bootdiag/{logcat.txt,kmsg.txt,props.txt,ps.txt}` and `/cache/bootdiag/marker_*` (marker_postfsdata = init reached post-fs-data, marker_boot_completed = framework up), `/sys/fs/pstore/console-ramoops`.
Expected failure order and what each means:
1. No marker, kernel log ends in `init`: the first-stage launcher or SELinux compile (`selinux_setup`): check the secilc lines in kmsg. Policy compiled offline with `-c 30` after the system_ext fix, so a failure here points at the Samsung `precompiled`/hash logic or genfs files.
2. Markers but `adb devices` empty: usb config / init rc fault; read `ps.txt`.
3. `system_server` loops: `logcat.txt` crash lines. Known candidates: Samsung services needing missing HALs (`vendor.samsung.hardware.*` AIDL), `libservice-connectivity` (`BpfRingbuf init failed`, kernel 4.14 has no ringbuf: needs a patch), `libandroid_runtime` budget watchers (apps only).
4. UI up but black/blank: SystemUI vs the gralloc/HWC HAL; compare with `dumpsys SurfaceFlinger`.
5. Services restart-looping (`init: Service ... exited`): list them and disable in an rc overlay (`tools/img/rc/` style).

## Rollback (the Pixel line, same vendor and boot)
Release `v0.3e-img` (or `v0.3f-img` once built): its `system-a17-pixel.img.xz.part-00` flashed to `system` exactly as in FLASH.md section 2 (windows verified), vendor and boot unchanged. Because the One UI first boot rewrites `/data`, a rollback also needs the same selective /data wipe (remove everything but `/data/media`, then Pixel first boot re-runs setup). Keep `v0.3d-img` as the second fallback. `recovery`, modem and bootloader partitions are never touched.

## Radio: no bridge needed on paper
Donor `telephony-common.jar` still carries HIDL clients for `android.hardware.radio` 1.0-1.4, radio config 1.0-1.3 and Samsung `ISehRadio` V2_0/V2_1/V2_2 (plus AIDL `ISehRadioSim` with V2_0 types), next to `getRadioProxy: mSehRadioProxy` fallbacks; the M30s vendor serves radio 1.2/1.4 and `ISehRadio` 2.1. So Samsung's RIL should bind the vendor HIDL services directly. Unproven until a first boot with a SIM: watch `logcat -b radio` for `getRadioProxy` and `HalVersion`.

## Open desk items (not blocking a first boot)
Proximity sensor type, `libservice-connectivity` ringbuf, CSC/optics, Samsung services that need HALs the A11 vendor lacks, IMS (`imsservice`/`imsd` vs the vendor's IMS).
