# Experimental Android 17 Pixel port for Galaxy M30s (SM-M307F)

Public GitHub Actions build of the Pixel source, with raw system/vendor/boot/vbmeta images, asset and raw-image SHA256 checksums, a build receipt and installation guide. This is an experimental prerelease. **This exact CI build has not been flashed or boot-tested.** Do not use on other models.

The build includes the committed Pixel layer, fingerprint bridge, gesture/launcher compatibility patches, sensor-hog and face-feature corrections, 5 GHz hotspot overlay, health/audio compatibility layers, and the dated baseline kernel `4.14.113-perf-20261110`. The version suffix and build date change; the existing functional kernel configuration is preserved. Experimental performance/boost/HDR settings are excluded. HDR variants caused black video.

This release adds a one-boolean SystemUI overlay to exclude the crashing back-gesture model, a narrow SafetyCenter configuration overlay for the matching Pixel AdvancedProtection sources, and startup helpers that avoid init shell-variable expansion and automatic UI restarts during compilation. Host signing, compiled resources and final image checks are included. Android overlay admission and runtime behavior still require testing; these are source/build corrections, not a completed device acceptance claim. Details: docs/PIXEL-COMPAT-FIXES.md in source.

Historical SM-M307F testing on November 7–8, 2026 verified boot, Wi-Fi, fingerprint unlock and a rear-camera photo. Front-camera streaming was observed; front still photos, ultrawide, video and flash are not verified. Hotspot starts with Wi-Fi off or a 2.4 GHz client connection; a 5 GHz DFS client connection can prevent hotspot startup. Bluetooth pairing/audio, speaker/mic/jack, GPS fix, fast charging and haptics require further testing.

**Known limits:** calls/SMS/mobile data untested; no Samsung IMS implementation, so no VoLTE/VoWiFi; standard proximity missing; no ambient light sensor or NFC on the tested model; no FM implementation. SELinux is permissive and userdata encryption is unsupported. First installation from encrypted stock requires formatting data and erases internal storage. Back up off-device first.

This is the Pixel port. The separate One UI port and its recent wallpaper/drawer repairs are not included.

Source: https://github.com/manvindar/m30s-pixel-port
Kernel source, port patches/build scripts and exact configuration: `m30s-kernel-a17-source.tar` in https://github.com/manvindar/m30s-pixel-port/releases/tag/build-inputs-a17 (SHA256 `a36cac0bd4e3e51343f38f686375106d0b00cf55104f1d2ca0aabef780998f91`). The baseline binary is hash-pinned.
See FLASH.md for prerequisites, checksum verification, installation and rollback requirements. Detailed historical status: docs/FEATURES.md and docs/PERF.md in source.
