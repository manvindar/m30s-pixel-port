# Galaxy M30s Android 17 QPR3 Beta 4: full TWRP release

Only Samsung Galaxy M30s **SM-M307F**, unlocked bootloader, compatible TWRP and Android 11 Samsung firmware. Experimental Android 17 DP11.261030.003 / SDK 37 with Pixel components. The battery reporting fix and both M30s ROM Tuner interfaces are built into System. The supplied `boot-acpm-fixed.img` is the exact boot previously readback-verified on the maintained phone; it includes ACPM sleep repair and the retained CPU/Mali/input-boost performance changes. No performance improvement is claimed without measurements.

## Existing Pixel port: dirty upgrade

Back up System and personal files to a computer first; keep stock firmware and your established recovery route. Keep the verified ACPM-fixed Boot, compatible Vendor, VBMETA, Recovery, EFS/modem and all data. Do not wipe or format data. Unmount System in TWRP before installing.

If upgrading from v0.6 or another older boot, back up Boot, then install the supplied `boot-acpm-fixed.img` through **TWRP Install → Install Image → Boot** before the System upgrade. This preparatory Boot update does not require Format Data. The system-only ZIP itself retains Boot and will reject an older/unverified one. If the supplied fixed Boot is already installed, keep it.

1. Download the complete `M30s-A17-TWRP-system-upgrade.zip`, `SHA256SUMS` and the release instructions. Each download is a single complete file. Verify the ZIP against its entry in `SHA256SUMS`, then copy it to recovery-readable storage with enough space. Keep existing files and data.
2. TWRP **Install → select ZIP → Swipe to confirm**. This ZIP writes **System only**. It requires a recovery xz decoder (xz or busybox xzcat), verifies the full decompressed system before writing, checks 5033164800-byte geometry, writes, checks complete System readback and compares Boot/Vendor before/after. It never wipes data or reboots automatically. Allow time for two decompressions and full readback; keep a reliable cable and power.
3. On success, choose **Reboot → System**. On a write/readback error, remain in recovery; restore your verified backup or retry the complete verified image. Never reboot a partially written System.

The ZIP installer itself has host validation but has **not** been exercised on the phone. The previously tested device route wrote the complete raw System image and verified full readback. For recovery without xz support, use the raw image route below.

## Raw System route in TWRP

Download the complete `system-a17-pixel.img.xz` and checksum files. Verify its compressed SHA-256 before extraction. On a computer:

```sh
xz -t system-a17-pixel.img.xz
xz -dc system-a17-pixel.img.xz > system-a17-pixel.img
xz -dc vendor-a17.img.xz > vendor-a17.img
sha256sum -c IMAGE-SHA256SUMS
```

On macOS use `shasum -a 256 -c`. Verify the files you plan to use; the complete checksum command requires all four raw image files. System must be exactly **5033164800 bytes**; Vendor **629145600 bytes**. Never flash a compressed `.xz` directly. TWRP **Install → Install Image → system-a17-pixel.img → System Image**. For an existing compatible installation, this is the only partition to write.

## First installation from stock

Back up everything off the phone, including EFS. Only SM-M307F is tested; bootloader unlock/Format Data erase user data, and the port does not support encrypted userdata. Follow the existing full [FLASH.md](FLASH.md) preparation guide. First installation uses the supplied raw System, Vendor and **boot-acpm-fixed.img**, plus disabled VBMETA. TWRP Install Image supports System, Vendor and Boot on compatible recovery. The retained M30s recovery fstab does not expose a VBMETA GUI target; use the documented Download mode/Heimdall VBMETA route, not a guessed TWRP target. Never overwrite recovery/modem/EFS/bootloader. Format Data is for first installation from encrypted stock, never an existing Pixel dirty upgrade.

## Known issues and evidence limits

The exact rebuilt System and new ZIP installer have not been device-tested. A prior System candidate booted and passed Home, Settings scrolling, browser and validated Wi-Fi smoke checks; the battery fix and both tuner apps were then installed and checked individually. One initial Package Manager system-server crash recovered; it remains unfixed. Later camera-provider aborts appeared in logs; preview smoke is not reliable photo/video acceptance. Calls/mobile data, audible audio, Bluetooth pairing, real battery discharge and long stability are unverified. Permissive SELinux and unsupported userdata encryption remain. Graphics caller review is incomplete: acceptance=false is retained in the bundled receipts; successful image/mechanical checks do not establish complete ABI/runtime compatibility.
