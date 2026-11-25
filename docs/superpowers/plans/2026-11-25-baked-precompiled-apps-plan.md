# Baked precompiled apps: implementation plan

Spec: `docs/superpowers/specs/2026-11-25-baked-precompiled-apps-design.md` (approved by the owner; the one-app test result is at its end).
Owner rules that apply: no push or release without the owner's go-ahead; a full on-phone compile (about 45 min, CPU loaded) needs a heads-up first; flashes follow Pam's verified procedure (TWRP dd, 256 MiB window readback, never reboot on a mismatch); no partition backups before flashing.

## Done (local, tested)
1. `tools/img/make_baked_seed.py`: compile on the phone, pull `dalvik-cache` output into `DIR/<app dir>/oat/arm64/X.{odex,vdex}` + `manifest.json` (sha256, sizes).
2. `tools/img/verify_baked_oat.py` + `test_verify_baked_oat.py`: manifest hashes, APK dex CRCs vs vdex, boot class path CRCs vs the image's boot vdex. Test passes on synthetic files (altered APK, other boot image, damaged and missing file fail; the matching seed passes). Run against the real v0.8 system image (APFS clone) with the real Settings seed: passes.
3. `build_a17.py --baked-oat DIR [--baked-oat-budget-mb 200]`: writes the files (root:root 644, `system_file` label), fails over budget, runs the verifier on the finished image. Exercised on a clone of the v0.8 image: e2fsck clean, files and labels as expected.
4. `tools/img/scripts/odex_bind.sh`: skips apps that carry `oat/arm64/*.odex` (test in `test_startup_scripts.py`); wired in `build_a17.py` and `make_build_a17.py`.
5. Workflow: `BAKED_OAT_URL` / `BAKED_OAT_SHA256` (empty = off), download with `verified_input.py`, untar, pass `--baked-oat`; the SHA is part of the built-image cache key; the new test runs in the test step. Not run in CI (no push).

## To do
A. **Seed (needs the phone, owner heads-up):** `make_baked_seed.py` for SystemUI, Pixel Launcher (`com.google.android.apps.nexuslauncher`), Setup Wizard (`com.google.android.setupwizard`, `...pixel.setupwizard` if present), WebView, Settings; read sizes; trim to 200 MB. SystemUI compile may blink the screen. Store as `baked-oat-DP11.261030.003.tar.zst` + SHA256.
B. **Build:** run the pipeline (publish=false) with the seed to make a candidate image; the verifier is part of the build.
C. **Flash and measure** (owner go-ahead for the flash): on a fresh flash check `cmd package dump` shows `status=speed` for the baked apps without any on-phone compile; time to home screen and to the setup wizard vs v0.8, same procedure. This also settles the open point: the baked files survive the `boot-after-ota` first boot.
D. **Release:** asset upload, pinned SHA256 in the workflow, release notes. Owner decides; nothing is pushed before that.

## Known limits
- Seed is per base build: a new GSI/ART/framework build needs a new seed; the verifier stops the build instead of shipping a stale one.
- Verifier supports oat 291 / vdex 027 (Android 17 ART) and compares boot CRC sets, not their order.
- Settings costs 75 MB for little first-boot gain; consider leaving it out.
