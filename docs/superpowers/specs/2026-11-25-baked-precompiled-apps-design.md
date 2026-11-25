# Baked precompiled app code (.odex/.vdex) for the M30s image

Status: design approved by the owner 2026-11-25; spec awaiting review.

## Problem
Every fresh install runs `firstboot_dexopt.sh`: pass 1 about 60 s after boot, pass 2 about 45 minutes later. Until it ends the phone is slow and the CPU is saturated. Compiled code cannot be produced by the offline image builder (`tools/img/build_a17.py`), because it depends on the exact framework and ART build.

## Constraints (measured 2026-11-25 on SM-M307F, v0.8)
- `/system` is 95% full: about 248 MB free of 4.9 GB, so compiled code for all apps cannot go into the system image.
- On the v0.8 boot SystemUI is `status=verify`, `reason=boot-after-ota`, location `/data/dalvik-cache/arm64/...@classes.dex`; `/data/odex` is empty (146 empty folders) and nothing is bind-mounted from it. Where `cmd package compile` writes its output on this ROM is **not yet known** and is the first thing the plan must settle with a one-app test.

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
- Not known yet: whether PackageManager, after a fingerprint change (`boot-after-ota`), accepts system-image oat for these apps without recompiling. The one-app test must show it before the builder work starts.
