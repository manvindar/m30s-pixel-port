# Pixel compatibility fixes

The DP11 Pixel back-gesture model repeatedly crashes SystemUI with SIGILL on the Exynos 9611. `M30sGestureOverlay.apk` overrides only `config_useBackGestureML=false`. The exact Pixel SystemUI consumer checks that resource before DeviceConfig, leaving the existing plain back-gesture path unchanged. The original APK, model, native library and DEX are not patched. The donor DeviceConfig default is false; an explicit true value was observed on the phone.

Play services also reported `Unexpected safety source: AdvancedProtection`. `M30sSafetyOverlay.apk` targets only the AOSP SafetyCenter raw configuration. It inserts `AdvancedProtection` and `AdvancedProtectionIssueSource` from the same Pixel 9a DP11 factory resources (APK SHA256 `9454f28822b02c4f33a13e99f547d798e4fe0d0542bfc594fe4e33b0d5899d01`). Existing AOSP config bytes are preserved outside the two insertions. The six donor GMS certificate constraints and 93 title/summary locale variants are retained. Both observed GMS signing certificates belong to that allowlist. No Google permission APEX is substituted and no SafetyCenter validator is bypassed.

The installed permission module's managed reader passes its selected package Resources to the parser, which honors explicitly qualified string references. The overlay uses its own string package. Host SDK compilation verifies the raw mapping and all 186 compiled localized strings. Android native idmap admission and actual runtime resource resolution remain unverified until device testing.

The sensor helper's existing three commands are moved from an init argument into `nosensorhog.sh`, avoiding init expansion of `$c`. Automatic first-boot compilation no longer kills the visible interface. An explicit manual Precompile apps request retains its restart opt-in. These changes preserve the existing UID, domain, compilation and cache behavior.

## Signing and packaging

Both overlays are static, API37-only, installed under `/system/product/overlay`, and contain no executable code or new permissions. Gesture uses the existing AOSP platform test identity, DER certificate SHA256 `c8a2e9bccf597c2fb6dc66bee293fc13f2fc47ec77bc6b2b0d52c11f51192ab8`. Safety uses the distinct official public AOSP SafetyCenter resources test identity, DER certificate SHA256 `366f75e331af7cd858d44815dfc1e4f403b68093b7592ed71fd682b9f3af4cf7`. Public test keys do not provide production signing security.

The Safety identity is fetched from official Permission source commit `26231a7eac744c7d2a8fea4740926620f56b20c6`, path `SafetyCenter/Resources/`. PK8 SHA256 is `3b55e4facb4e57b742883a9a4b4adaea7920d3244d91cfc818628d301eefb2d7`; PEM SHA256 is `ad4b4e29c7cb4a86efe11da1e02bf57fad641de9192b66a362ab0a023dd2afda`. Packaging rejects different certificate identities before compiling either overlay. Private user keys, decoded APKs and auxiliary donor metadata are excluded from source publication.

`tools/img/verify_pixel_fixes.py` checks the final image's compiled overlays, both target signers, exact SafetyCenter resource target hash, and exact startup script/config bytes and modes. This is a read-only host check. It does not run Android init, OverlayManager or the SafetyCenter parser.

The generic builder generator's unrelated fingerprint/face-block drift predates these fixes. The checked-in blocks are preserved. Do not regenerate the entire builder blindly.

The new image has not yet been flashed or accepted on the phone. Existing three-button navigation is a temporary workaround. Gesture swipes, stability, resource selection, GMS behavior and persistence need device verification after a verified image flash. No userdata reset is part of these fixes.
