# Flashing the Android 17 Pixel image on the Galaxy M30s (SM-M307F)

Private build for one device (serial and partitions below are the M30s with an unlocked bootloader and TWRP). Built by GitHub Actions from `@COMMIT@` with the kernel release `@KERNEL_TAG@` of `manvindar/m30s-kernel`.
Files of this release: `system-a17-pixel.img.xz.part-*` (the system image, split because a release asset is limited to 2 GiB), `vendor-a17.img.xz`, `boot-a17.img`, `vbmeta-disabled.img`, `SHA256SUMS`.

Never touch `recovery`. Do not delete or overwrite anything under `/sdcard` or on the SD card.

## 1. Check and rejoin
```
sha256sum -c SHA256SUMS
cat system-a17-pixel.img.xz.part-* | xz -dc > system-a17-pixel.img     # 5033164800 bytes
xz -dc vendor-a17.img.xz > vendor-a17.img                               # 629145600 bytes
sha256sum system-a17-pixel.img vendor-a17.img                           # must equal the "image" lines in SHA256SUMS
```

## 2. System and vendor (TWRP, `adb reboot recovery`)
```
cat system-a17-pixel.img | adb exec-in 'dd of=/dev/block/by-name/system bs=1048576'
cat vendor-a17.img       | adb exec-in 'dd of=/dev/block/by-name/vendor bs=1048576'
# verify in windows: one long read through TWRP's shell is cut off after about 700 MiB, so hash 256 MiB at a time and compare with the same window of the image
for i in $(seq 0 18); do adb shell "dd if=/dev/block/by-name/system bs=1048576 skip=$((i*256)) count=256 2>/dev/null | sha256sum"; done    # last window is 192 MiB (count=192)
adb shell 'rm -rf /data/system/package_cache /data/dalvik-cache'
```
TWRP's `dd` rejects `bs=4M`: use bytes (`bs=1048576`). The vendor image only needs flashing when coming from the stock vendor or an older build of this repo.

## 3. Kernel (boot) and vbmeta
From TWRP: `cat boot-a17.img | adb exec-in 'dd of=/dev/block/by-name/boot bs=1048576'`.
From Download mode with Heimdall: `heimdall flash --BOOT boot-a17.img --VBMETA vbmeta-disabled.img`.
`boot-a17.img` is the stock Samsung boot image with the kernel Image of `@KERNEL_TAG@` swapped in (`scripts/repack_boot.py` of m30s-kernel; kernel Image sha256 in `SHA256SUMS`). Rollback: the stock `boot.img` of the firmware (sha256 in the repo docs).

## 4. First boot
Reboot to Android. The first boot builds the package cache (a few minutes) and then `firstboot_dexopt` compiles the apps (pass 1 about 60 s after boot, pass 2 about 45 min later; log `/data/local/tmp/dexopt.log`), so the phone is slow for a while. Swap (3 GB zram) is set up by `03_zram.rc`.
The userdata fstab line has no `fileencryption=ice`: when coming from a stock or encrypted userdata, format userdata once (this wipes the phone).

## Rollback
Android 14 system image and boot image: see `docs/phase3prep/A17-BUILD.md` (kept locally, not in this release).
