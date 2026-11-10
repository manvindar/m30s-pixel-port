# Experimental Android 17 Pixel port for Galaxy M30s (SM-M307F)

Public GitHub Actions build of the Pixel source, with raw system/vendor/boot/vbmeta images, asset and raw-image SHA256 checksums, a build receipt and installation guide. This is an experimental prerelease. **This exact CI build has not been flashed or boot-tested.** Do not use on other models.

The build includes the committed Pixel layer, fingerprint bridge, gesture/launcher compatibility patches, sensor-hog and face-feature corrections, 5 GHz hotspot overlay, health/audio compatibility layers, and the baseline 4.14.113 Android 17 kernel. HDR kernel variants are excluded because they caused black video.

Historical SM-M307F testing on November 7–8, 2026 verified boot, Wi-Fi, fingerprint unlock and a rear-camera photo. Front-camera streaming was observed; front still photos, ultrawide, video and flash are not verified. Hotspot starts with Wi-Fi off or a 2.4 GHz client connection; a 5 GHz DFS client connection can prevent hotspot startup. Bluetooth pairing/audio, speaker/mic/jack, GPS fix, fast charging and haptics require further testing.

**Known limits:** calls/SMS/mobile data untested; no Samsung IMS implementation, so no VoLTE/VoWiFi; standard proximity missing; no ambient light sensor or NFC on the tested model; no FM implementation. UI jank remains. SELinux is permissive and userdata encryption is unsupported. First installation from encrypted stock requires formatting data and erases internal storage. Back up off-device first.

This is the Pixel port. The separate One UI port and its recent wallpaper/drawer repairs are not included.

Source: https://github.com/manvindar/m30s-pixel-port
Kernel source: https://github.com/manvindar/m30s-kernel (currently private; baseline binary is hash-pinned).
See FLASH.md for prerequisites, checksum verification, installation and rollback requirements. Detailed historical status: docs/FEATURES.md and docs/PERF.md in source.
