# Android 17 Pixel port for Galaxy M30s (SM-M307F)

Public GitHub Actions build of the Pixel source, with raw system/vendor/boot/vbmeta images, asset and raw-image SHA256 checksums, a build receipt and installation guide. **v0.6 was flashed and boot-verified on SM-M307F on November 10, 2026.** Do not use on other models.

The build includes the committed Pixel layer, fingerprint bridge, gesture/launcher compatibility patches, sensor-hog and face-feature corrections, 5 GHz hotspot overlay, health/audio compatibility layers, and the dated baseline kernel `4.14.113-perf-20261110`. The reviewed profile1 kernel enables compiler -O2, LZ4 availability, BBR with Fair Queue network defaults, reduced debug instrumentation and a 150 ms touch minimum-frequency boost. Maximum clocks, thermal controls and module CRC validation are preserved. Speed and battery gains have not been measured. The ROM keeps zstd zram; Android may override network defaults. BFQ/storage queue changes and HDR are excluded. HDR variants caused black video.

This release adds a one-boolean SystemUI overlay to exclude the crashing back-gesture model, a narrow SafetyCenter configuration overlay for the matching Pixel AdvancedProtection sources, and startup helpers that avoid init shell-variable expansion and automatic UI restarts during compilation. Host signing, compiled resources and final image checks are included. The gesture overlay is enabled and its model resource resolves to false; three-button navigation is retained and swipe gestures have not been retested. The Safety Center overlay is enabled but the running service configuration still lacks the added AdvancedProtection sources after the upgrade; that correction is not confirmed. Details: docs/PIXEL-COMPAT-FIXES.md in source.

Historical SM-M307F testing on November 7–8, 2026 verified boot, Wi-Fi, fingerprint unlock and a rear-camera photo. Front-camera streaming was observed; front still photos, ultrawide, video and flash are not verified. Hotspot starts with Wi-Fi off or a 2.4 GHz client connection; a 5 GHz DFS client connection can prevent hotspot startup. Bluetooth pairing/audio, speaker/mic/jack, GPS fix, fast charging and haptics require further testing.

**Known limits:** calls/SMS/mobile data untested; no Samsung IMS implementation, so no VoLTE/VoWiFi; standard proximity missing; no ambient light sensor or NFC on the tested model; no FM implementation. SELinux is permissive and userdata encryption is unsupported. First installation from encrypted stock requires formatting data and erases internal storage. Back up off-device first.

This is the Pixel port. The separate One UI port and its recent wallpaper/drawer repairs are not included.

Source: https://github.com/manvindar/m30s-pixel-port
Kernel source, port patches/build scripts and exact configuration: `m30s-kernel-a17-source.tar` in https://github.com/manvindar/m30s-pixel-port/releases/tag/build-inputs-a17 (SHA256 `a36cac0bd4e3e51343f38f686375106d0b00cf55104f1d2ca0aabef780998f91`). The baseline binary is hash-pinned.
See FLASH.md for prerequisites, checksum verification, installation and rollback requirements. Detailed historical status: docs/FEATURES.md and docs/PERF.md in source.

For v0.6-pixel-perf, the system/vendor assets are reused byte-for-byte from the successful compatibility image build at source `938a0a04c19eba3e46adbe74bd64544f523a5521`, Actions run https://github.com/manvindar/m30s-pixel-port/actions/runs/42898023503. The boot image is replaced by the independently verified performance build at kernel source `0d82b075ad8cf16d340bb2f3b787af46e2993f41`, Actions run https://github.com/manvindar/m30s-kernel/actions/runs/42899549058. The release includes both component records, exact checksums and all 19 raw system readback hashes. An upgrade on the existing test phone writes system and boot only and preserves userdata/media.

### Device verification — November 10, 2026

System and Boot were upgraded without a data wipe. All 19 system windows and the full boot readback matched the published images. Media, settings, Vendor, Recovery and VBMETA matched before/after flash. One reboot completed Android startup with actual kernel `4.14.113-perf-20261110`, dated November 10. system_server, SystemUI and Play services remained running across two startup checks; the crash buffer was empty. `/proc/modules` was empty.

This verifies the upgrade and startup, not the untested hardware checklist or performance/battery gains. Three-button navigation remains active. The Safety Center service configuration limitation above remains open.
