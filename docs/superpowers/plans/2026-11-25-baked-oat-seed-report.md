# Baked oat seed for DP11.261030.003 (v0.8 image): measured, 2026-11-25

Made on SM-M307F RZ8M9187SXD running v0.8-a17-mint-kernel (`ro.system.build.fingerprint` Android/generic_system/generic:17/DP11.261030.003/16847878:user/release-keys), `make_baked_seed.py`, `-m speed -f`.
Seed file (not in git, 68.6 MB): `baked-oat-DP11.261030.003.tar.zst`, SHA-256 `a63aa7c35ed207183001816f8566011b2bd71a210e8e4f9ed569bc89ff1d85ff` (contains `manifest.json` and `system/...`). Untar into a directory and pass it as `--baked-oat`.

## Included (164.6 MB of the 200 MB budget)
| App | APK in image | odex MB | vdex MB |
|---|---|---|---|
| SystemUI | /system/system_ext/priv-app/SystemUI | 74.4 | 1.0 |
| Pixel Launcher | /system/system_ext/priv-app/NexusLauncherRelease | 30.8 | 0.3 |
| Setup Wizard (Google) | /system/product/priv-app/SetupWizardPrebuilt | 34.0 | 0.3 |
| Setup Wizard (Pixel) | /system/system_ext/priv-app/SetupWizardPixelPrebuilt | 15.4 | 0.1 |
| WebView (Google) | /system/product/app/WebViewGoogle | 8.1 | 0.1 |
All five pass `verify_baked_oat.py` against a clone of the real v0.8 `system.img` (APK dex CRCs and the 53 boot class path CRCs); `build_a17.py --baked-oat` code path run on that clone: e2fsck clean, 165 MB written.

## Excluded, and why
| App | Reason |
|---|---|
| Settings (measured 75.4 MB odex) | Does not fit: 164.6 + 72.7 MB > 200 MB. First to drop; it is in `work/seed/real` if the budget changes. |
| Dialer, Messages, Gboard, Play Store, Google app, Play services, Chrome | **Installed updates, not image versions.** On this phone Play replaced them with `/data/app` copies (e.g. gms 187 MB, Chrome 225 MB base APK). ART ignores image artifacts for an updated app, so compiled code for the image copies (`/system/product/priv-app/{GmsCore,Phonesky,Velvet,Dialer}`, `.../app/{Chrome,LatinIME,messaging}`) could only help before the first Play update, and they cannot be compiled from this phone without removing the updates (a device change not approved). Not baked; compiled by the first-boot job as before. If wanted: compile on a freshly flashed phone before signing in. |
| Remaining /system apps (~270 packages) | Unchanged: first-boot job. |

## On-device changes made by this work, and how to undo them
- `/system/system_ext/priv-app/Settings/oat/arm64/Settings.odex` and `.vdex` (really `/data/odex/system_ext_priv-app_Settings/arm64/`, the bind-mounted dir): copied there by hand for the acceptance test. Undo: `rm -r /data/odex/system_ext_priv-app_Settings/arm64; cmd package compile --reset com.android.settings`.
- `/data/dalvik-cache/arm64/*@classes.{dex,vdex}` for SystemUI, Pixel Launcher, both Setup Wizards, WebView, replaced by the speed-compiled copies (Settings' was deleted by the test). Undo: `cmd package compile --reset <package>` (or any flash/wipe).
- No setting, property, partition or boot change; no reboot; nothing pushed or flashed. A reboot is not needed for either undo.

## Unproven (explicitly)
- Acceptance across a real fingerprint-change boot (fresh flash, `boot-after-ota`). The in-place test (`compile -r boot-after-ota` leaves baked files alone) is the only evidence so far.
- SELinux labeling at runtime. The builder writes `u:object_r:system_file:s0` (files and the new `arm64` dir) and a read-back on a clone of the v0.8 image shows that label, but the in-place phone test used the `/data/odex` bind dir (`system_data_file`) and the ROM boots with SELinux permissive, so a label denial would not have shown. Not checked on a flashed baked image.
- First-boot time gain: not measured.
