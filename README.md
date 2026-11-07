# m30s-pixel-port

Pixel design (Pixel Launcher, Google look and feel) on a Samsung Galaxy M30s (SM-M307F, Exynos 9611), by putting a prebuilt Android GSI into `system` and layering Pixel apps on top. Sister project of the Lenovo TB-X606V port (`~/Aistuff/tb-x606v-android17`, `~/Aistuff/android-aosp`); its tooling is reused, not rewritten.

Status (2026-11-07): **Android 17 (Google GSI DP11.261016.003) with the Pixel 9a app layer boots on the phone** (flashed through TWRP; the bootloader is unlocked). Pixel Launcher, Pixel SystemUI and Settings, Pixel setup wizard, Dialer, Messages, Photos, Gboard, Chrome with its WebView, Play Store and GMS work. A custom kernel (`boot-a17-psi.img`: PSI, BPF JIT, userfaultfd, SELinux permissive) is flashed; the fallback is Android 14 (`work/a14/system-a14.img`). Gaps: camera, vibrator, Pixel utility apps (Recorder, Tips, accessibility, Maps and the other Google apps), `power.stats` HAL. Details: `docs/phase3prep/A17-BUILD.md`.

Kernel variants of `manvindar/m30s-kernel` (2026-11-07): `a17` is the baseline CI uses; `a17-boost` (perf + touch boost, no HDR patch) is what the phone runs. **Do not use `a17-hdr` and `a17-hdr-r2`**: they make the HWC report HDR10, SurfaceFlinger then sends HDR layers to the Exynos DPP HDR path, which was never set up for this SDR panel, so HDR video (YouTube) plays black and the HDR option stays offered. Flash order and rollback: `docs/FLASH.md`.

- `docs/PLAN.md`: feasibility verdict, GSI choice, layer design, flashing route, risks, phases.
- `docs/phase0/PHASE0.md`: what was read from the device, with the raw dumps next to it.
- `docs/phase3prep/A17-BUILD.md`: the Android 17 image, boot findings, Pixel layer, kernel, rebuild and flash recipe.
- `docs/phase2a/PHASE2A.md`: kernel capability probe (`tools/probe`), VINTF, codecs, Samsung sysfs.

Rules for anything done here
- Always `adb -s DEVICE_SERIAL`. Never touch the Lenovo tablet (OTHER_DEVICE_SERIAL / 192.0.2.71:5555) or its recovery.
- Never delete anything on /sdcard or the SD card. Logs the user copies in TWRP are in `/data/media/0`.
- The bootloader is unlocked (Knox tripped). Flash `system` only through TWRP; keep `recovery` untouched.
- Everything not read from the device is marked UNVERIFIED.
