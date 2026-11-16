[ROM][17][UNOFFICIAL][GSI][SM-M307F][EXPERIMENTAL] Android 17 Pixel port — QPR3 Beta 4

Full TWRP release: https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.7-a17-qpr3-beta4-twrp
Install instructions: https://github.com/manvindar/m30s-pixel-port/blob/main/docs/TWRP-RELEASE.md
Source: https://github.com/manvindar/m30s-pixel-port
Kernel corresponding source/config/build instructions: assets on the same release.

For Galaxy M30s SM-M307F only. Android 17 QPR3 Beta 4 DP11.261030.003 / SDK 37 with Pixel components. Requires unlocked bootloader, compatible TWRP and compatible Android 11 Samsung firmware.

New: complete System with Samsung battery-percentage fix, M30s support in the original tablet ROM Tuner UI, compact M30s tuner retained, and the verified ACPM-fixed boot with retained CPU/Mali/input-boost changes. Tuners support CPU caps/governors, touch duration, swappiness and animation scales; thermal safeguards remain unchanged. Performance gains are unmeasured.

Existing compatible Pixel install: back up externally, unmount System, install the system-only TWRP ZIP, wait for complete readback, then reboot. If downloads are split, reconstruct on a computer first. The ZIP needs xz/busybox xzcat; otherwise join/decompress the raw System and use TWRP Install Image → System. Keep an already installed ACPM-fixed Boot. Older v0.6 boots need a separate backed-up TWRP Install Image → Boot update to the supplied fixed Boot first; no data format. Preserve compatible Vendor/VBMETA/Recovery and data; never Format Data for this dirty upgrade. Keep a rollback backup.

First install from encrypted stock: follow the full guide; requires backup and Format Data, which erases internal storage/accounts/apps. Use the supplied raw System/Vendor/fixed Boot and documented Download mode VBMETA route. Do not write EFS/modem/recovery/bootloader. Checksums and exact image sizes are mandatory.

Experimental status: this exact rebuilt System and new ZIP installer are not phone-tested. The prior candidate booted after complete readback and passed Home/Settings/browser/Wi-Fi smoke; battery and both tuner apps were then checked individually. Image/mechanical checks are not full ABI/runtime acceptance; incomplete graphics reviews remain disclosed in receipts.

Known issues: permissive SELinux, unsupported userdata encryption, one recovered but unfixed Package Manager startup crash, later camera-provider aborts (camera reliability unresolved). Calls/mobile data, audio quality, Bluetooth pairing, real battery discharge and long stability remain unverified. Not a stable/daily-driver claim. Back up and retain stock firmware/Download mode recovery.
