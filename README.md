<div align="center">

# Galaxy M30s · Android 17 Pixel port

**Android 17 QPR3 Beta 4 · Pixel 9a components · SM-M307F**

[![Release](https://img.shields.io/github/v/release/manvindar/m30s-pixel-port)](https://github.com/manvindar/m30s-pixel-port/releases/latest)
![Device](https://img.shields.io/badge/device-SM--M307F-blue)
![Status](https://img.shields.io/badge/status-experimental-orange)

[**Download**](https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.7-a17-qpr3-beta4-twrp) · [**Install guide**](docs/TWRP-RELEASE.md) · [**Changelog**](CHANGELOG.md) · [**XDA discussion**](https://xdaforums.com/t/rom-17-qpr3-beta-4-unofficial-gsi-sm-m307f-experimental-pixel-port-dp11-261030-003.4808164/)

</div>

> [!WARNING]
> Experimental ROM for **Samsung Galaxy M30s SM-M307F (Exynos 9611) only**. The exact latest System image and TWRP ZIP installer have not been tested on the phone. SELinux is permissive; encrypted userdata is unsupported. Back up off-device and retain matching stock firmware.

## Current release

| Component | Included |
| :--- | :--- |
| Android | **17 QPR3 Beta 4**, `DP11.261030.003`, SDK 37 |
| Pixel layer | Pixel 9a components from the matching build |
| Battery | Samsung kernel capacity reporting fix integrated into System |
| ROM Tuner | Tablet interface and compact M30s app with an Exynos backend |
| Boot | ACPM-fixed kernel with retained CPU, Mali and input-boost changes |
| Distribution | Complete System archive, System-only TWRP ZIP and first-install images |

The tuner supports CPU caps/governors, touch boost, swappiness and animation controls; GPU readings use Mali. No overclock or thermal override is enabled. Performance and battery-life gains have not been measured. The separate One UI port is not included.

## Downloads

Get these from the [v0.7 full release](https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.7-a17-qpr3-beta4-twrp). **Every download is one complete file; there are no split parts.**

| File | Purpose |
| :--- | :--- |
| `M30s-A17-TWRP-system-upgrade.zip` | Guarded System-only upgrade for a compatible existing installation |
| `system-a17-pixel.img.xz` | Complete compressed System image for the raw-image route |
| `vendor-a17.img.xz` | Vendor image for first installation |
| `boot-acpm-fixed.img` | Fixed Boot; also required before upgrading an older boot |
| `vbmeta-disabled.img` | First-install verified-boot configuration |
| `SHA256SUMS` / `IMAGE-SHA256SUMS` | Compressed download and extracted image checksums |
| `TWRP-INSTALL.md` | Installation instructions accompanying the release |
| Kernel source, configuration and provenance | Corresponding source and build information for the supplied Boot |

The extracted System image must be **5,033,164,800 bytes**. Verify checksums before installation; never flash an `.xz` file directly as an image.

## Installation

### Existing compatible Pixel installation

Follow the [dirty-upgrade guide](docs/TWRP-RELEASE.md#existing-pixel-port-dirty-upgrade). The ZIP writes **System only** and preserves data. It requires the exact ACPM-fixed Boot, compatible Vendor and a recovery xz decoder. If upgrading from an older boot, back up Boot and install the supplied fixed Boot first as described in the guide. **Do not format or wipe data for this upgrade.**

The installer verifies the decompressed image before writing and checks full System readback. Its validation is host-only so far. Recovery without xz support can use the [raw System route](docs/TWRP-RELEASE.md#raw-system-route-in-twrp).

### First installation from stock

Read the [first-install instructions](docs/TWRP-RELEASE.md#first-installation-from-stock) and [preparation guide](docs/FLASH.md). Unlocking the bootloader and formatting encrypted stock userdata erase personal data. First installation needs System, Vendor, fixed Boot and disabled VBMETA. VBMETA uses the documented Download mode route; do not guess a TWRP image target.

## What has been checked?

| Area | Evidence and limits |
| :--- | :--- |
| Latest downloads | Full System size/hash, ZIP contents and compressed archives verified; public asset digests checked |
| Earlier System candidate | Boot, Home, Settings, Chrome and Wi-Fi smoke checks passed |
| Battery and tuner fixes | Tested separately on the maintained phone; exact rebuilt release remains untested |
| ACPM-fixed Boot | Full device readback matched; one natural sleep observed, not long-term stability |
| Historical hardware | Earlier boot, fingerprint and rear-photo checks; these do not establish latest-release acceptance |

## Known issues

- An initial Package Manager startup crash recovered but remains unfixed; later camera-provider aborts leave camera reliability unresolved.
- No Samsung IMS implementation: **VoLTE and VoWiFi are unavailable**. Calls, SMS and mobile data remain unverified.
- Audio quality, Bluetooth pairing, a real battery discharge cycle and long-term stability remain unverified.
- SELinux is permissive, userdata encryption is unsupported and standard proximity is missing.
- HDR variants are excluded because they caused black video. Graphics compatibility review remains incomplete.

See the [current release notes](docs/A17-TWRP-RELEASE-NOTES.md) for scope and limitations. [Hardware status](docs/FEATURES.md) and [performance notes](docs/PERF.md) contain dated historical evidence, not acceptance of this release.

## Build and source

[GitHub Actions](https://github.com/manvindar/m30s-pixel-port/actions) builds from [pinned upstream inputs](docs/A17-UPSTREAM.json). The [image workflow](.github/workflows/build-image.yml) builds the images; the [release workflow](.github/workflows/publish-twrp-release.yml) packages and verifies complete downloads. Passing a build does not establish device compatibility.

The release includes corresponding ACPM-fixed kernel source, configuration, provenance and build instructions. See [public source notes](docs/PUBLIC-SOURCE.md) for repository scope. Keep Recovery, EFS/modem, personal files and unrelated partitions intact during development.
