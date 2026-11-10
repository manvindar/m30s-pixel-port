# Galaxy M30s SM-M307F: experimental Android 17 Pixel images

Built by GitHub Actions from `@COMMIT@`, using baseline kernel `@KERNEL_TAG@`.
For the verified v0.6 upgrade result and remaining limits, see [RELEASE-NOTES.md](RELEASE-NOTES.md). Other generated builds need their own device acceptance.
These are raw partition images, not a recovery-installable ZIP or an Odin TAR.

## Already running the Pixel port?

Use the [short TWRP upgrade steps](TWRP-UPGRADE.md). Flash System and Boot only; keep userdata and the existing Vendor/Recovery/VBMETA. The first-install steps below apply when coming from stock.

## Before installing

Only SM-M307F has been tested. Do not use on another model. Requires an unlocked bootloader and working compatible TWRP recovery. Keep a complete backup, including EFS and personal files, plus your matching stock Samsung firmware and a working Download mode recovery route. Do not overwrite recovery, EFS, modem or unrelated partitions.

First installation from encrypted stock firmware requires TWRP **Format Data**: this erases internal storage, accounts and apps. Back up to a computer first. This port does not support userdata encryption and uses a permissive SELinux kernel. It is unsuitable for sensitive data or a primary phone. The v0.6 existing-Pixel upgrade was verified without formatting; use the short upgrade guide above.

## Download and verify

Download every system part, vendor image, boot, vbmeta, SHA256SUMS, IMAGE-SHA256SUMS and the release documentation into one directory.

```sh
sha256sum -c SHA256SUMS
cat system-a17-pixel.img.xz.part-* | xz -dc > system-a17-pixel.img
xz -dc vendor-a17.img.xz > vendor-a17.img
sha256sum -c IMAGE-SHA256SUMS
```

Raw system must be 5033164800 bytes; vendor must be 629145600 bytes. Stop on any checksum mismatch. On macOS use `shasum -a 256 -c` instead of `sha256sum -c`.

## Install

1. Confirm the device model, unlocked bootloader and backups. Boot compatible TWRP. Check that the system partition is at least 5033164800 bytes and vendor at least 629145600 bytes; stop if the layout differs.
2. For a first install from encrypted stock, use TWRP Format Data after copying the backup off the phone. Re-enter recovery afterward.
3. Transfer the decompressed system and vendor images. In TWRP choose **Install > Install Image**, select `system-a17-pixel.img` and the **System** partition, then `vendor-a17.img` and **Vendor**. Check each target before confirming. Do not choose recovery.
4. Install the supplied boot and disabled vbmeta in Download mode using Heimdall after confirming the PIT has BOOT and VBMETA partitions:

   ```sh
   heimdall print-pit --no-reboot
   heimdall flash --BOOT boot-a17.img --VBMETA vbmeta-disabled.img --no-reboot
   ```

   Stop if Heimdall fails or partition names differ. These files are not directly usable in Odin without correct TAR packaging. Return to recovery, then boot Android.
5. First boot and app compilation can take several minutes. Later background compilation may affect performance. Do not interpret the first minutes as steady-state performance.

For rollback, use matching stock Samsung firmware for SM-M307F through your established Download mode process. Stock firmware may require another data format; preserve your external backup. This release does not contain stock rollback firmware.
