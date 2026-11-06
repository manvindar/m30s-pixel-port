# First-flash checklist (draft for the user to review; nothing has been run)

Every command is for the Mac, serial `DEVICE_SERIAL` (`A=~/Library/Android/sdk/platform-tools/adb -s DEVICE_SERIAL`). Expected output is what I expect, not what was seen: anything marked (?) has not been verified on this phone. Gates need the user's written OK each; do not start the next gate without it. Never touch the Lenovo tablet.

## Rules that apply to every step
- **SD card and `/sdcard`: never delete, overwrite, move or format anything** (user rule). No `rm`, no wipe, no format on `/sdcard`, `/storage/*` or the card. Reads and `adb pull` are fine. Scratch files go to `/data/local/tmp` (for the phone: ask god first). TWRP: never use its wipe/format on "Micro SDCard"; never "Format Data" before Gate B has happened (see warning).
- **The SD card is physically removed (after Settings > Storage > unmount) and kept out from Gate A to Gate C; put it back only after Android has booted.** Step 0 below checks it is portable.
- **Warning, internal storage:** `/sdcard` on the phone (`/storage/emulated`, ~10 GB of files) lives in `userdata`. **The bootloader unlock (Gate B) wipes it.** That is the phone's doing, not a deletion by us, and it is why step 0 requires the user's own copy first. Only the removable card survives.
- Battery above 50% before every reboot or flash; USB cable straight into the Mac (no hub).

## Step 0: before any gate (no gate needed, read-only)
| # | Command / action | Expected |
|---|---|---|
| 0.1 | `$A shell 'sm list-volumes all'` | a line `public:179,1 mounted 0000-0000` = **portable** card (checked 2026-11-06: portable, exFAT). If a line says `private:179,...` the card is **adopted**: stop and tell god |
| 0.2 | User unmounts the card (Settings > Battery and device care > Storage > SD card > Unmount), removes it, keeps it away from the phone and from this process | `$A shell 'sm list-volumes all'` no longer shows `public:` |
| 0.3 | User copies/exports their data (BACKUP-PLAN s3); optional, on their go only: `adb pull /sdcard/ <dir>` and the card content from a card reader (copy only) | files on the Mac, sizes match |
| 0.4 | `$A shell dumpsys battery \| grep level` | `level: 50` or more |
| 0.5 | User notes IMEI (`*#06#`), serial, Wi-Fi MAC | written down |
| 0.6 | `brew install heimdall` (the Mac, network, no phone) then `heimdall version` | a version string; if the formula is missing/broken, build from source or use Odin on Windows (blocker for Gate A) |
| 0.6a | **Result 2026-11-06:** there is no `heimdall` formula (only `heimdal`, a different tool; the `heimdall-suite` cask is disabled). Built v1.4.2 from `Benjamin-Dobell/Heimdall` master tarball: `cmake .. -DDISABLE_FRONTEND=ON -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXE_LINKER_FLAGS="-framework IOKit -framework CoreFoundation -framework Security"` (libusb 1.0.30 and cmake from brew), binary `work/heimdall-src/build/bin/heimdall`, `heimdall version` = `v1.4.2`. Use that path wherever the checklist says `heimdall`. | built |

## Gate A: Download-mode transport test (reboots the phone, changes nothing)
Risk: low. Abort at any step: hold Volume Down + Power about 10 s, the phone reboots into Android.
| # | Command / action | Expected |
|---|---|---|
| A1 | `$A reboot download` | screen shows a Samsung warning page ("Do you want to continue? Volume up: continue, down: cancel") (?) |
| A2 | Volume Up | blue "Downloading... Do not turn off target" screen, no progress bar |
| A3 | `heimdall detect` | `Device detected` |
| A4 | `heimdall print-pit --no-reboot > pit-device.txt` | a PIT dump with 42 entries; compare with the PIT from the firmware (`M30S_SWA_OPEN.pit`). **Known risk:** newer Samsung bootloaders often make Heimdall fail ("Failed to receive PIT file size", "Protocol initialisation failed"): that is a result, not damage; it means use Odin on a Windows PC |
| A5 | Hold Volume Down + Power about 10 s | phone reboots to Android; `$A devices` lists it within 2 minutes |
**Result 2026-11-06:** A1 `adb reboot download` ok; the user pressed Volume Up at the warning; the phone enumerates as USB "Gadget Serial"; `heimdall detect` = `Device detected`; `heimdall print-pit --no-reboot` worked (42 entries, SYSTEM/VBMETA/RECOVERY/BOOT/VENDOR/PRODUCT/USERDATA present; dump in `work/pit-device.txt`). **Heimdall works on this bootloader.** Two practical notes: (1) Heimdall must run **outside the agent sandbox** (the sandbox blocks USB: `Failed to detect compatible download-mode device`); (2) after `--no-reboot` the session stays open and a second `heimdall` call fails with `Protocol initialisation failed`: either do all steps in one call or leave with Volume Down + Power (about 10 s). Not yet compared against `M30S_SWA_OPEN.pit` byte for byte.
Result recorded in PLAN.md: Heimdall works / does not.

## Gate B: unlock, vbmeta-disabled, TWRP, partition dump
**Prerequisites:** Gate A result known; step 0 complete; stock firmware zip and `recovery(Stock).img` safe on the Mac (hashes in STOCK-IMAGES.md / FIRMWARE-TAR.md); user copy of data verified; SD card out. Irreversible parts: Knox fuse (`ro.boot.warranty_bit` becomes 1 and stays), warranty, Samsung Pay/Secure Folder/banking-app bindings, **internal storage wiped**.
| # | Command / action | Expected / abort |
|---|---|---|
| B1 | Settings > About phone > Software info: tap Build number 7 times; Developer options > **OEM unlocking** on | the toggle must exist and be switchable. Today `sys.oem_unlock_allowed=0` (toggle off). If it is missing or greyed (VaultKeeper timer, often about 7 days online) **stop; the plan waits** (this is the most likely schedule blocker). Abort here costs nothing |
| B2 | `$A reboot download`, Volume Up at the warning, then long-press Volume Up for the unlock option, Volume Up again to confirm | "Unlock bootloader?" then the phone wipes itself and reboots. **Point of no return**. Abort before confirming: Volume Down |
| B3 | Setup wizard, skip all; enable Developer options and USB debugging again; `$A shell getprop ro.boot.flash.locked` | `0`; `$A shell getprop ro.boot.warranty_bit` gives `1` (?) |
| B4 | `$A reboot download`, Volume Up, then `heimdall flash --VBMETA work/a14/vbmeta-disabled.img --RECOVERY twrp-3.7.0_9-0-m30s.img --no-reboot` (flash both in one session; names are the PIT names `VBMETA`, `RECOVERY`) | `Uploading VBMETA ... RECOVERY successful`, ends `Ending session` (?). Failure with "Custom binary blocked by OEM lock" means the unlock did not stick: recheck B3 |
| B5 | Do not let it boot Android first: hold Volume Down + Power until the screen is off, then **immediately** Volume Up + Power (cable out) | TWRP main screen (build `buildvariant=eng`). If Samsung's stock recovery or Android appears the stock recovery may have been restored: repeat B4. TWRP does not boot at all: Download mode, `heimdall flash --RECOVERY "recovery(Stock).img"` and think |
| B6 | `$A devices` ; `$A shell id -u` | `recovery` state, `0` |
| B7 | **Partition dump before anything is flashed:** `tools/backup/dump_partitions.sh ~/phone-backup small` then `... big` | `OK <name> <bytes> <sha256>` per partition, every one `OK` (a `DIFF` means retry); `SHA256SUMS` written; `boot`, `recovery`, `vbmeta` hashes will differ from the firmware (vbmeta/recovery now ours), `system`/`vendor`/`product` should equal the firmware images' hashes (proves stock) |
| B8 | Copy `~/phone-backup` to a second disk; record the sums in PLAN.md | three copies (Mac, second disk, cloud/USB) |
Rollback of Gate B: the partition dump plus the firmware restores stock software; the Knox fuse and the wiped storage cannot be undone. Re-locking exists in Download mode (long-press Volume Down) and wipes again.

## Gate C: first A14 image (TWRP route, no Download mode needed)
**Prerequisites:** B7 verified, B8 done, user's written OK for this image, `work/a14/` images present (rebuild with `tools/img/build_a14.sh`, hashes in A14-IMAGE-BUILD.md).
| # | Command / action | Expected / abort |
|---|---|---|
| C1 | In TWRP: Wipe > **Format Data** (internal data only, never the SD card) | "Format complete" (this is the encryption reset Android 14 needs) |
| C2 | `$A shell mkdir -p /data/local/tmp`; `$A push work/a14/system-a14.img /data/local/tmp/` (4.8 GB, 3 to 5 min) | `1 file pushed` |
| C3 | `$A shell 'dd if=/data/local/tmp/system-a14.img of=/dev/block/by-name/system bs=4M && sync'` | `1200+0 records` in and out, no error |
| C4 | `$A shell 'dd if=/dev/block/by-name/system bs=4M \| sha256sum'` | equals `9a3351708301666f3ffe2050eb25b90418def310095d1422fe777099962ad24b` (image size is exactly the partition size). Mismatch: repeat C3 |
| C5 | `$A push work/a14/boot-a14-permissive.img /data/local/tmp/` then `dd ... of=/dev/block/by-name/boot` and the same hash check | boot partition holds our boot image (55 MiB, the stock image has the same size) |
| C6 | `$A shell rm /data/local/tmp/*.img` (internal data only; not the SD card) ; `$A reboot` | boot logo, then the crDroid animation, first boot 3 to 10 minutes |
| C7 | After boot: `$A shell getprop ro.build.fingerprint`; `getenforce` | `google/treble_arm64_bgN/...14/AP2A.240905.003...`; `Permissive` (?) |
**Abort / rollback:** no boot after about 10 minutes: Volume Up + Volume Down into TWRP (this combo is TWRP's, as on the tablet; if not, Download mode), read `/sys/fs/pstore/console-ramoops`, then restore from the B7 dump: `dd if=~/phone-backup/system.img` back to `system` and `boot.img` to `boot`, or flash the stock firmware (BL/AP/CP/CSC) with Heimdall/Odin. Fallbacks if the kernel panics for lack of a root device: flash `boot-a14-permissive-root.img` instead (adds `root=/dev/sda25`; sboot should already add it, see BOOTLOADER-CMDLINE.md).
After Android boots: **only then reinsert the SD card.** Copy GApps (MindTheGapps, TWRP zip) is a separate step.
