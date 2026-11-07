# Milestone 2: donor framework vs the M30s Android 11 vendor (desk analysis, 2026-11-07)

Method: `tools/oneui/vintf_gap.py` reads the donor system image (EROFS) and the stock M30s vendor (`vendor.img` of M307FXXS4CWC2, manifest + fragments) and compares the HAL client libraries the donor ships with what the vendor serves. **Nothing here is boot-tested**; "ok" means the client library exists in the donor and the interface version is served by the vendor. The donor's `compatibility_matrix.device.xml` is the A26's own device matrix (105 required HALs, 73 absent on the M30s); it is only enforced at OTA time and not at boot, so it is not used as the gap list.

Finding that changes the plan: **the One UI 9 framework still ships HIDL clients for graphics (allocator 2.0/3.0/4.0, mapper 2.0-4.0, composer 2.1-2.4), camera provider 2.4-2.6 + Samsung 4.0, radio 1.0-1.4, keymaster 3.0-4.1, health, gnss, drm, media c2/omx.** AOSP A17 dropped those, which is why the Pixel image needs libui and graphics shims. The Samsung framework should need fewer shims for graphics, camera and radio. Where it will need work is audio, VNDK, SELinux, init and the kernel-facing network code.

### Samsung HIDL client libs in the donor vs the M30s vendor

| package | donor client versions | M30s vendor serves | verdict |
|---|---|---|---|
| vendor.samsung.hardware.audio | 1.0 | 1.0 | ok |
| vendor.samsung.hardware.biometrics.face | 2.0, 3.0 | - | MISSING (no such HAL in vendor) |
| vendor.samsung.hardware.camera.device | 5.0 | - | MISSING (no such HAL in vendor) |
| vendor.samsung.hardware.camera.provider | 4.0 | 4.0 | ok |
| vendor.samsung.hardware.gnss | 2.0, 2.1 | 2.0 | ok |
| vendor.samsung.hardware.miscpower | 2.0 | 2.0 | ok |
| vendor.samsung.hardware.radio.bridge | 2.0, 2.1 | 2.0 | ok |
| vendor.samsung.hardware.tlc.hdm | 1.0, 1.1, 1.2 | - | MISSING (no such HAL in vendor) |
| vendor.samsung.hardware.tlc.mpos_tui | 1.0 | - | MISSING (no such HAL in vendor) |
| vendor.samsung_slsi.hardware.ExynosHWCServiceTW | 1.0 | 1.0 | ok |
| vendor.samsung_slsi.hardware.eden_runtime | 1.0 | - | MISSING (no such HAL in vendor) |
| vendor.samsung_slsi.hardware.enn_aux | 1.0 | - | MISSING (no such HAL in vendor) |
| vendor.samsung_slsi.hardware.ofi | 2.0, 2.1 | 1.0 | VERSION GAP |

### Samsung AIDL client libs in the donor (the A11 vendor has no AIDL HALs at all)

vendor.samsung.frameworks.security.dsms V1, vendor.samsung.hardware.audio V1, vendor.samsung.hardware.biometrics.face V3, vendor.samsung.hardware.camera.device V1, vendor.samsung.hardware.camera.provider V1, vendor.samsung.hardware.hyper V2, vendor.samsung.hardware.keymint V5, vendor.samsung.hardware.media.converter V2, vendor.samsung.hardware.media.mpp V5, vendor.samsung.hardware.mpos V1, vendor.samsung.hardware.radio V1, vendor.samsung.hardware.radio.bridge V1, vendor.samsung.hardware.security.engmode V1, vendor.samsung.hardware.security.fkeymaster V1, vendor.samsung.hardware.security.hdcp.wifidisplay V2, vendor.samsung.hardware.security.hermes V1, vendor.samsung.hardware.security.rtts V1, vendor.samsung.hardware.security.sem V1, vendor.samsung.hardware.security.skpm V1, vendor.samsung.hardware.security.vaultkeeper V1, vendor.samsung.hardware.security.widevine.keyprov V2, vendor.samsung.hardware.security.wsm.service V1, vendor.samsung.hardware.snap V3, vendor.samsung.hardware.tlc.iccc V3, vendor.samsung.hardware.tlc.kg V2, vendor.samsung.hardware.tlc.payment V1, vendor.samsung.hardware.tlc.ucm V1, vendor.samsung.hardware.vibrator V5, vendor.samsung_slsi.hardware.eden_runtime_aidl V1, vendor.samsung_slsi.hardware.enn_aux_aidl V1, vendor.samsung_slsi.hardware.graphics.extension.composer3 V5

### AOSP HIDL packages: donor client libs vs vendor

| package | donor | vendor | note |
|---|---|---|---|
| android.hardware.audio | 6.0 | 5.0 | donor wants newer |
| android.hardware.audio.effect | 6.0 | 5.0 | donor wants newer |
| android.hardware.camera.provider | 2.4, 2.5, 2.6 | 2.6 | ok |
| android.hardware.cas | 1.0 | 1.2 | ok |
| android.hardware.drm | 1.0, 1.1, 1.2, 1.3, 1.4 | 1.3 | ok |
| android.hardware.gatekeeper | 1.0 | 1.0 | ok |
| android.hardware.gnss | 1.0, 1.1, 2.0, 2.1 | 1.1, 2.1 | ok |
| android.hardware.graphics.allocator | 2.0, 3.0, 4.0 | 2.0 | ok |
| android.hardware.graphics.composer | 2.1, 2.2, 2.3, 2.4 | 2.1 | ok |
| android.hardware.graphics.mapper | 2.0, 2.1, 3.0, 4.0 | 2.1 | ok |
| android.hardware.health | 1.0, 2.0, 2.1 | 2.0, 2.1 | ok |
| android.hardware.keymaster | 3.0, 4.0, 4.1 | 4.0 | ok |
| android.hardware.media.c2 | 1.0, 1.1, 1.2 | 1.0, 1.1 | ok |
| android.hardware.media.omx | 1.0 | 1.0 | ok |
| android.hardware.power | 1.0, 1.1, 1.2, 1.3 | IPower/default | donor wants newer |
| android.hardware.radio | 1.0, 1.1, 1.2, 1.3, 1.4 | 1.2, 1.4 | ok |
| android.hardware.radio.config | 1.0 | 1.1 | ok |

## Gap list, ordered by what stops the boot first

| # | Gap | Evidence | Handling (owner) |
|---|---|---|---|
| 1 | **VNDK**: the donor carries `com.android.vndk.v33` only; the M30s vendor is VNDK 30 | `/system/system_ext/apex/com.android.vndk.v33.apex`; no v30 | add `com.android.vndk.v30.apex` + `30.0.cil`/`30.0.compat.cil` mapping from the Android 14 GSI, as `build_a17.py` step 4 does (image builder) |
| 2 | **Audio**: donor has libaudiohal 6.0/7.0/7.1/aidl, **no 5.0**; the vendor serves audio 5.0 + effects 5.0 + Samsung `ISehDevicesFactory` 1.0 | lib64 listing | needs a libaudiohal@5.0 client (and its closure) for the donor's audioserver; Pixel step 7 did the same with a private Android 16 audioserver. Likely the hardest port item after the kernel; sound is not needed for first boot (audioserver may crash-loop without blocking boot) |
| 3 | **Samsung radio is AIDL in the donor** (`vendor.samsung.hardware.radio` V1, `radio.bridge` V1, `radio.data/messaging/network/sim` in the A26 matrix); the M30s vendor serves HIDL `ISehRadio` 2.1, `ISehBridge` 2.0, `ISehChannel` 2.0 and AOSP radio 1.2/1.4 | vintf_gap output | AOSP-level calls/SMS/data can bind the HIDL radio 1.4 like the Pixel image does. Samsung extras and IMS/VoLTE need an AIDL-to-HIDL bridge or a framework patch: later, not a boot blocker |
| 4 | **Missing Samsung HALs**: `biometrics.face`, `tlc.hdm`, `tlc.mpos_tui`, `eden_runtime`/`enn_aux` (NPU), `ofi` 2.x (vendor 1.0), AIDL `keymint` V5, `fkeymaster`, `hermes`, `rtts`, `skpm`, `vaultkeeper`, `wsm`, `snap` V3 (vendor 1.2), `vibrator` V5 (vendor 2.1) | vintf_gap | Knox/TEE clients will log failures; expected non-fatal when the services are optional. Keymaster stays the AOSP HIDL 4.0 path (the donor ships keymaster clients 3.0-4.1). Camera NPU features off. A per-service crash list comes from the first boot log |
| 5 | **Init and SELinux**: Samsung init and `dpolicy_system`, `sepolicy_version`, Knox/defex hooks; vendor policy v30 | root listing of the donor | make init permissive (pattern patch as in `build_a17.py` step 2, must be re-found in Samsung's init); verify `precompiled_sepolicy` is skipped or compiles with mapping 30.0. Kernel side: no allow-all patch (that is item 6 of god's list, shared) |
| 6 | **Kernel-facing**: the donor's Connectivity/Tethering APEX, `netbpfload`, `netd` expect BPF features of 4.19+/5.4+ (LPM trie ops, newer helpers); `uname` check | A50 One UI 8.5 notes in `docs/ONEUI-PORT.md`; Pixel image patches netd/bpf instead of spoofing | kernel milestone 3 (m30s-kernel): LPM trie backport, decide spoof vs patch; both only through CI |
| 7 | **init rc / property gaps**: Samsung services whose vendor half is missing will restart-loop | not measurable at the desk | after the first boot: a restart-loop list from `logcat`/`init: Service ... exited`, disable the services in an rc overlay (`tools/img/rc/` style) |
| 8 | **Graphics, camera provider, gnss, keymaster, health**: donor clients match the vendor | table above | expected to work without shims; first boot decides |

## What this means for the work order
1. Image builder: `build_oneui` profile = donor ext4 (M1) + VNDK 30 + mapping 30.0 + permissive init + `build.prop` identity (fingerprint of the phone stays Samsung's own) + the Pixel rc overlays that are kernel-related (lmkd, cgroups). Everything not listed stays donor.
2. Kernel milestone 3 in parallel (mine, CI): version-string decision, LPM trie, config for Samsung needs (check `CONFIG_*` the donor's init/services use).
3. First boot attempt needs a phone slot from god. Expected first failure: init (SELinux or the A14-first-stage question) before anything of One UI starts.
