# Baked precompiled app code (.odex/.vdex) for the M30s image

Status: design approved by the owner 2026-11-25; spec awaiting review.

## Problem
Every fresh install runs `firstboot_dexopt.sh`: pass 1 about 60 s after boot, pass 2 about 45 minutes later. Until it ends the phone is slow and the CPU is saturated. Compiled code cannot be produced by the offline image builder (`tools/img/build_a17.py`), because it depends on the exact framework and ART build.

## Constraints (measured 2026-11-25 on SM-M307F, v0.8)
- `/system` is 95% full: about 248 MB free of 4.9 GB, so compiled code for all apps cannot go into the system image.
- On the v0.8 boot SystemUI is `status=verify`, `reason=boot-after-ota`, location `/data/dalvik-cache/arm64/...@classes.dex`; `/data/odex` is empty (146 empty folders) and nothing is bind-mounted from it. Where `cmd package compile` writes its output was settled by the one-app test below.

## Decision
Compile on the phone, then bake the result of a chosen set of apps into the next system image. Budget: 200 MB.

Apps (owner choice "shell plus Google apps"): SystemUI, Settings, Pixel Launcher, setup wizard, Dialer, Messages, Gboard, Play Store, Google app, Google Play services, Chrome and WebView. If the total exceeds 200 MB, drop the largest Google apps first (Play services is the likely one).

Rejected: a seed tarball unpacked into `/data` (owner chose baking), and an emulated arm64 `dex2oat` in CI (fragile, not reproducible without the phone's ART).

## Design
1. **Seed (manual, on the phone, per base build).** `cmd package compile -m speed -f <pkg>` for each chosen package, then pull the output files. Record sizes; trim to the budget; store as `baked-oat-<ANDROID_BUILD>.tar.zst` with a SHA256.
2. **Builder.** `build_a17.py --baked-oat DIR` copies each app's files to `<app dir>/oat/arm64/` in the image with the owner/mode/SELinux label the other oat folders use.
3. **odex_bind.** `odex_bind.sh` skips apps that have baked files; otherwise the bind mount over `oat/` would hide them.
4. **CI.** The workflow downloads the seed from a release asset with a pinned SHA256 and passes it to the builder. A new check (`tools/img/verify_baked_oat.py`) fails the build when, for any baked app, the recorded dex checksum differs from the APK in the image, or the recorded boot image checksum differs from the image's own. A stale seed must stop the build, not be ignored by the phone.
5. **First-boot job.** Unchanged for all other apps; it skips apps already compiled.

## Success criteria
- On a flashed image the baked apps show `status=speed` in `cmd package dump` without any on-phone compile.
- Time to the home screen and to the setup wizard on first boot is measured and compared with v0.8 (same phone, same procedure).
- The new check fails on a deliberately altered APK and passes on the real one (a runnable test, not only the CI run).

## Risks
- The seed must be remade for every new base build; the check is what makes this safe.
- Step 1 needs the phone connected and busy; compiling SystemUI restarts it and the screen blinks.
- Baked files for large apps (Chrome, WebView, Play services) may not fit; the trim rule decides.
- Still to show on a flashed image: that the first boot after a fresh flash (`boot-after-ota`) keeps the baked files. The one-app test below shows ART Service accepts them in place and `compile -r boot-after-ota` leaves them alone.

## One-app test result (2026-11-25, Settings, v0.8, wireless adb, no reboot, no flash)
- `cmd package compile -m speed -f com.android.settings` (2m29s): status=speed, output in **`/data/dalvik-cache/arm64/<apk path with @>@classes.dex` and `.vdex`**, not in `oat/arm64` (the `/data/odex` bind mount stayed empty). Sizes: odex 75.4 MB + vdex 0.8 MB.
- Copied as `<app dir>/oat/arm64/Settings.odex` + `.vdex` (the layout of a baked image), deleted the dalvik-cache copy, ran `compile -m verify` and `compile -r boot-after-ota` without `-f`: `cmd package dump` stays status=speed, location `/system/.../oat/arm64/Settings.odex`, and the restarted Settings process maps both files. **ART Service accepts image-placed oat/vdex and does not recompile it.**
- The files are tied to the boot class path: the odex key/value store records 53 boot class path dex CRCs; they equal the image's `/system/framework/boot*.vdex` checksums with the low bit flipped (`verify_baked_oat.py` checks exactly this, plus the APK dex CRCs in the vdex). The boot image is part of the GSI, so it does not change at first boot.
- Sizes of the others (speed, measured): Pixel Launcher 35.6 MB, Setup Wizard 32.3 MB, WebView 8.5 MB; SystemUI about 100 MB (script comment, not measured). With Settings that is about 250 MB, over the 200 MB budget.

## Amendments to the app list (found by the test)
- On a phone with Play, Dialer, Messages, Gboard, Play Store, Google app, Play services and Chrome are **updated copies in /data/app**; the image only holds old versions (`/system/product/priv-app/{GmsCore,Phonesky,Velvet,Dialer}`, `.../app/{Chrome,LatinIME}`). ART ignores image artifacts for an updated app, and a fresh device updates them within minutes of sign-in. Baking them only covers the window before the update, so they come last.
- Bake order: SystemUI, Pixel Launcher, Setup Wizard (both), WebView, Settings (largest per app: drop first), then the Google apps if budget remains.
