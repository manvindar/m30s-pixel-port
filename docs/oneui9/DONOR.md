# One UI 9 donor: A266BXXUCDZJ6 (Galaxy A26 5G, SM-A266B, INS), what is in it

Downloaded 2026-11-07 from the SamFw free server (no login, headless browser; only the AP file, 7.98 GB zip, BL/CP/CSC/HOME_CSC untouched). Lives in `fw-oneui9/` (gitignored). Unpacked with `tools/oneui/unpack_donor.py` (needs `brew install lz4 erofs-utils`).

AP tar members: boot, init_boot, vendor_boot, dtbo, recovery, `super.img.lz4` (7.0 GiB), userdata, vbmeta. `super` (10.4 GiB raw, sparse) holds **system 7323 MiB, product 2332 MiB, vendor 1044 MiB, odm 1 MiB**; no system_ext partition (`/system/system_ext` is inside system). All EROFS.

## Layer 1: product (result: nothing One UI in it)
`product` is 291 files, 2295 MiB of **Google apps only**: Velvet 311 MiB, Chrome 291, WebViewGoogle 227, Gmail 221, Messages 163, Maps 160, YouTube 158, Duo 153, Phonesky 97, SpeechServices 72, SystemIntelligence 66, GmsCore 28 (plus apex 147 MiB, overlays 1.5 MiB). The Pixel layer already ships the Google equivalents. **There is no One UI look in the product partition, so this layer adds nothing and was not built.**

## Where One UI actually is
`/system` (7.3 GiB): `framework/framework.jar` with the Samsung additions (`sec_platform_library.jar`, `com.samsung.android.*.jar`, `semwifi-service.jar`, `secinputdev-service.jar`), `services.jar`, `system_ext` with SystemUI/launcher, 208 `priv-app` packages (SecSettings, SecSetupWizard, SecTelephonyProvider, SettingsProvider, KnoxZtFramework, PaymentFramework, SecureFolder, ...). Samsung's SystemUI and launcher call `com.samsung.android.*` and `Sem*` APIs that exist only in Samsung's framework.jar/services.jar, so they cannot run on the Google GSI framework: **layer 2 (SystemUI alone on the A17 base) cannot boot; it needs the donor framework and services as well, which is the whole-system port (stage 4/5 of docs/ONEUI-PORT.md), not a layer.**

## Open for god
Decision needed: stop at the finding, or go for the whole-system port (donor system trimmed from 7.3 GiB to under 4800 MiB, A11 vendor from the M30s, Samsung services against vendor-30 HALs). Estimated 3-5 weeks, boot not guaranteed. Meanwhile the work continues on fingerprint/jank/SELinux on the Pixel A17 image.
