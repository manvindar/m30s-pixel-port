# Upgrade the installed Pixel ROM in TWRP

For **Galaxy M30s SM-M307F already running this Pixel port**, with TWRP installed. Coming from encrypted stock is a first installation: use [the full guide](FLASH.md).

1. Back up your important files off the phone. Download `system-a17-pixel.img.xz.part-00`, `boot-a17.img`, `SHA256SUMS` and `IMAGE-SHA256SUMS` from [v0.6-pixel-perf](https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.6-pixel-perf). Check the two downloaded image files against `SHA256SUMS`.
2. Extract the system image on your computer. The `.xz.part-00` file is compressed; do not flash it directly. This release has one system part:

   ```sh
   xz -dc system-a17-pixel.img.xz.part-00 > system-a17-pixel.img
   ```

   Check the extracted image against `IMAGE-SHA256SUMS`. It must be **5033164800 bytes**. On macOS use `shasum -a 256 FILE`; on Linux use `sha256sum FILE` and compare the full result with the matching checksum line. Stop if either checksum differs.
3. Copy `system-a17-pixel.img` and `boot-a17.img` to storage TWRP can read, then reboot into TWRP. A microSD card must use a filesystem that supports files larger than 4 GB.
4. Tap **Install → Install Image**, select `system-a17-pixel.img`, choose **System Image** (sometimes labelled **System**), and swipe to flash.
5. Tap **Install Image** again, select `boot-a17.img`, choose **Boot**, and swipe to flash.
6. Tap **Reboot → System**. Allow several minutes for app compilation. Keep three-button navigation until gesture behavior has been checked on your installation.

This upgrade writes **System and Boot only**. **Do not Format Data or wipe Data/Internal Storage.** Keep Vendor, Recovery, VBMETA, EFS and modem partitions unchanged. Apps, accounts and personal files are intended to stay in place; retain your external backup.
