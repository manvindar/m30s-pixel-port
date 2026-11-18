# Changelog

Release changes and verification limits for the Galaxy M30s **SM-M307F** Pixel port. Distribution checks and device testing are recorded separately.

## 2026-11-18 · Full-download and publication fixes

Updates to [v0.7-a17-qpr3-beta4-twrp](https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.7-a17-qpr3-beta4-twrp); no new ROM runtime changes.

- Renamed the complete System download to `system-a17-pixel.img.xz`. The previous `.part-00` file already contained the entire stream; no missing image part was found.
- Verified the archive and the TWRP ZIP's embedded System stream: **5,033,164,800 bytes**, matching the published raw-image checksum.
- Removed download splitting. Packaging now rejects incomplete or oversized streams instead of publishing parts.
- Added embedded ZIP stream verification and remote release name, size and SHA-256 checks.
- Limited public assets to installation files, checksums and corresponding kernel source/build information; removed forum drafts and internal reports.
- Refreshed the README and added this changelog.

These checks do not explain the reported short extraction on a user's computer and do not constitute a phone installation test.

## 2026-11-16 · v0.7 full TWRP release

[Full release](https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.7-a17-qpr3-beta4-twrp) · [Battery/tuner integration release](https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.7-a17-m30s-fixes-20261116)

- Updated the Google ARM64 base and matching Pixel 9a layer to Android 17 QPR3 Beta 4, `DP11.261030.003`.
- Integrated Samsung battery-capacity reporting and both ROM Tuner interfaces with the M30s Exynos backend.
- Supplied the ACPM-fixed Boot and corresponding kernel source, configuration and provenance.
- Added a guarded System-only TWRP upgrade ZIP, full System archive, first-install components and separate compressed/raw checksums.
- Documented dirty upgrades without a data wipe and the separate first-install path from encrypted stock.

**Verification:** an earlier System candidate booted and passed basic UI/browser/Wi-Fi checks; battery and tuner changes were tested separately. The exact rebuilt System and ZIP installer were not phone-tested. Camera reliability, startup crashes, telephony and long-term stability remain open. Performance gains are unmeasured.

## 2026-11-10 · v0.6 Pixel performance release

[Historical release](https://github.com/manvindar/m30s-pixel-port/releases/tag/v0.6-pixel-perf)

- Paired the compatibility System/Vendor images with kernel `4.14.113-perf-20261110`.
- Retained the reviewed profile's compiler, network-default and touch-boost changes without increasing maximum clocks or overriding thermal controls.
- Upgraded System and Boot on the maintained phone without a data wipe; System readback windows and full Boot readback matched.
- Verified Android startup and preservation of media, settings, Vendor, Recovery and VBMETA across that upgrade.

This evidence applies to v0.6. It does not validate v0.7, establish performance/battery gains or resolve the remaining hardware checklist. See [historical release notes](docs/RELEASE-NOTES.md) for detail.
