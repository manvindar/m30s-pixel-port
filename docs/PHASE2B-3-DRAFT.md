# Draft: Phase 2b / 3 build plan (written 2026-11-06, after Phase 2a)

Nothing here has been run. Every step that touches the phone is behind a gate (see "OKs needed"). Base evidence: `docs/phase2a/PHASE2A.md`.

## Decision: which GSI first
Two tracks, in this order:
1. **A14 (Lineage 21 / AndyYan arm64_bgN, UQ1A.231205.015)**: VNDK v30 and sepolicy mapping 30.0 inside, the only generation with evidence on this phone (RELAYED, XDA). Goal: prove flashing, vendor edits, radio, camera, audio with the least invention. Fixes expected: MP2 `Type` removal, vbmeta disabled, `/metadata` stand-in (maybe), netd `close_range` patch (A14 netd probably already falls back; test).
2. **A17 (DP11.261016.003) with the Pixel layer**, built from `tb-x606v-android17` tooling, only after track 1 shows a working phone. It needs the new work below.

## What A17 needs that the phone lacks (Phase 3, track 2)
| Piece | Plan | Reuse |
|---|---|---|
| **VNDK v30 donor** | Take `com.android.vndk.v30` APEX (flattened or ext4-image form) from the A14 GSI into A17 `/system/apex`; same public key as A17's own v31 (RELAYED). The stock phone already mounts it from `/system` (verified in `/proc/mounts`), so the vendor's expectation is `libs from vndk.v30` | `tools/apex` (repack runtime/virt APEXes) |
| **SELinux mapping 30.0** | Copy `mapping/30.0.cil` and `30.0.compat.cil` (+ `plat_pub_versioned.cil` consistent with the A17 platform) from the A14 GSI into A17 `/system/system_ext/etc/selinux/mapping/` (A17 only ships 31+; RELAYED). Vendor is cil-split: must compile with `secilc`, test offline before flashing | none, new |
| **VINTF level** | `target-level="3"` vs A17 framework matrices 7+: the tablet already lies the same way (RELAYED: `Build.isBuildConsistent` patch); confirm the same patch applies here (Phase 1 says all 23 apply) | `tools/framework` |
| **lmkd** | Phone has the in-kernel LMK and memcg v1 `memory.pressure_level` (verified), no PSI. Reuse `tools/lmkd/lmkd_inkernel.c` (it already drives `lowmemorykiller` minfree/adj sysfs). **Samsung SLMK caveat**: current `minfree` reads 0s, so the vendor tunes it elsewhere (`ro.slmk.*` props, a Samsung lmkd). Plan: read `/proc/lowmemorykiller` style stats as root before/after, choose minfree for 5.5 GiB by hand | `tools/lmkd` |
| **`/metadata`** | No partition. Options: (a) fstab line pointing a `/metadata` ext4 loop or a **bind of a `/cache` dir** (idea from Phase 1; `/cache` is 300 MB ext4, mounted at first stage?); (b) shrink `userdata` and add a 16 MB partition: **no**, would need PIT work. Pick (a); check what A17 init needs `/metadata` for (checkpoint, gsid, ota_metadata, `metadata_encryption`): non-FBE-metadata devices boot with an empty dir. Add `formattable` handling like the tablet | `tools/twrp/vendor_edits.sh` pattern |
| **Audio donor** | Vendor audio HAL is HIDL 5.0 (+ `ISehDevicesFactory`). A17 dropped HIDL audio < 7.0 from the framework matrix. The tablet uses the **A16 audio stack** (`tools/audio`): donor libs from the A16 GSI (audioflinger/policy side + HIDL 5.0 client). Same donor here; re-test with Samsung `audio.sec_primary` and Dolby absent | `tools/audio` |
| **Health / vibrator shims** | Vendor has HIDL health 2.1 and HIDL vibrator 1.3; A17 wants AIDL. Health: tablet shim `tools/health` reading `power_supply/battery` (gauge is real here, keep the plain path first). Vibrator: write a shim that forwards AIDL calls to the vendor HIDL `IVibrator@1.3` (or at least `timed_output/vibrator/enable`). Lights: vendor already AIDL, verify version only | `tools/health`, `tools/vibrator` |
| **Samsung radio** | HIDL radio 1.4 x2 (`slot1`,`slot2`); tablet fix: declare `android.hardware.telephony.radio.access`, `calling`, `data`, `messaging` (`tools/telephony`). Samsung IMS (`vendor.samsung.hardware.radio`) has no AOSP path: **no VoLTE**, so a VoLTE-only SIM would get no voice calls. Carrier details omitted; verify CSFB and VoLTE on the target device (see PLAN s14) | `tools/telephony` |
| **Kernel gaps** | no `close_range` (netd patch), no `F_SEAL_FUTURE_WRITE` (check libhwui of the chosen build at disassembly time), BPF patches (netbpfload, netd.o: Phase 1 says they apply), no PSI, cgroup v1 task_profiles | `tools/libc`, `tools/bpf` |
| **Samsung services under a GSI** | `argos`, `cass`, `emservice`, `teegris`, `vaultkeeper`, `hqm`, `ofi`, `snap`: expect SELinux denials; plan: boot permissive (A17 init patch exists), then tighten | `patches/` init permissive |
| **Pixel layer** | Phone variant only (no tablet layer): Pixel Launcher, Wallpapers & style, fonts, then SystemUIGoogle/Settings later. Source the Pixel 9a (tegu) factory images already named in PLAN s9.4. Privapp allowlist check mandatory before every priv-app | `tools/pixel` |

## Phase 3 sequence (all after gates)
0. Prereqs without the phone: stock firmware tar in hand (user), A14 GSI + MindTheGapps + TWRP m30s 3.7.0_9-0 downloaded and checksummed (needs `allowed_domains` per download), A14 image prepared offline in `work/` (ext4 resize to 4800 MiB, `shared_blocks` check, vendor edits as a patch script applied in TWRP, never on the live vendor first). Offline `secilc` and `checkvintf`-equivalent checks.
1. Backup (root needed: TWRP or unlocked): `efs`, `sec_efs`, `cpefs`, `persistent`, `radio`, `param`, `up_param`, `keystorage`, `keydata`, `keyrefuge`, `boot`, `recovery`, `dtbo`, `dtb`, `vbmeta`, `system`, `vendor`, `product`, `misc`, `bota0..3` to the Mac, SHA-256 each. Back up personal data first.
2. Download-mode transport test (Heimdall `print-pit`).
3. Unlock (wipe, Knox), flash vbmeta-disabled + TWRP + boot, flash A14 system, vendor edits from TWRP, format userdata, boot, triage (radio, camera, audio, fingerprint, charging, 24 h battery).
4. Track 2 as an image build (`build_image.py` style), flashed only from a good TWRP backup of track 1.

## OKs needed (each one goes god -> user)
1. **Written OK** for the unlock chain: wipe, Knox trip, warranty void, loss of Samsung Pay/Secure Folder/Dual Messenger. Not asked yet: not approved.
2. OK to put the phone in Download mode once (`adb reboot download`), only after the user has the stock tar and a copy of their data, battery above 50%.
3. Stock firmware tar M307FXXS4CWC2 (or newer with binary 4) on the Mac: user downloads; the agent verifies SHA/size and unpacks with `lz4`/`tar` only, no flashing.
4. Windows machine/VM or a Heimdall result: decided after the transport test.
5. Carrier information is private; test calls on the first working build (PLAN s14).
6. Network `allowed_domains` for downloads (GSI, MindTheGapps, TWRP, Pixel factory zip) when Phase 3 prep starts.
7. Permission to run a root probe later: only after unlock (TWRP) or Magisk equivalent; shell cannot test BPF or read LMK state.
