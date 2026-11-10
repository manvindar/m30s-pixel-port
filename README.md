# Galaxy M30s Android 17 Pixel port

Experimental Android 17 Google GSI with a Pixel 9a app layer for **Samsung Galaxy M30s SM-M307F (Exynos 9611)**. Other models have not been tested.

[Public releases](https://github.com/manvindar/m30s-pixel-port/releases) contain raw system, vendor, boot and disabled-vbmeta images built by GitHub Actions, checksums and a flashing guide. A new CI build is not device-verified merely because compilation passes.

Historical testing on November 7–8, 2026 verified boot, Wi-Fi, fingerprint unlock and a rear-camera photo. Calls/SMS/data remain untested; VoLTE/VoWiFi, userdata encryption and standard proximity are unsupported. The baseline kernel uses permissive SELinux. Camera gaps remain. See [release notes](docs/RELEASE-NOTES.md), [hardware status](docs/FEATURES.md) and [performance](docs/PERF.md).

## Install and build

Read [FLASH.md](docs/FLASH.md) before installing. First installation from encrypted stock firmware requires formatting data and erases internal storage. Back up off-device and keep matching stock firmware. These images are not a recovery-installable ZIP or an Odin TAR.

Run the **Build image** GitHub Actions workflow to reproduce a release using pinned generic inputs and public upstream donors. Keep the baseline `kernel-4.14.113-a17`; HDR variants caused black video. The public tablet patch library supplies shared tooling.

[XDA development thread](https://xdaforums.com/t/rom-17-unofficial-gsi-sm-m307f-android-17-pixel-port-experimental.4808164/) — release discussion and bug reports.

## Development

Use an explicitly selected device for device tools. Preserve recovery, EFS, personal files and unrelated partitions. Report whether a result was measured or remains unverified.

Source history was sanitized before publication. Private device records and original history remain separate; see [PUBLIC-SOURCE.md](docs/PUBLIC-SOURCE.md). The One UI port is a separate project, and its fixes are not part of this Pixel release.

For an existing Pixel installation with TWRP: [simple upgrade steps](docs/TWRP-UPGRADE.md).
