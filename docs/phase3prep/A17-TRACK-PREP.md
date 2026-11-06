# Android 17 track: what `build_image17.py` needs changed for the M30s (desk review, 2026-11-06)

Source of the recipe: `~/Aistuff/tb-x606v-android17/build/build_image17.py` (10 steps). Nothing built, nothing downloaded for this track yet. Phase 0 to 2a facts: `docs/phase2a/PHASE2A.md`; A14 image first (`A14-IMAGE-BUILD.md`).

| Tablet step | Carries over to the M30s? | Change needed |
|---|---|---|
| 1 grow to the partition, drop `shared_blocks` | yes | partition is 4800 MiB (1,228,800 blocks) not 0xf3800000; `tools/img/build_a14.sh` already does this order (grow first, then unshare) |
| 2 init permissive, debuggable props | yes | tablet patches init binary; here try the boot cmdline `androidboot.selinux=permissive` first (needs a debuggable build: the A17 GSI is a *user* build, so the init patch is needed after all) |
| 3 libc/linkers (MADV_WIPEONFORK), `libprocessgroup_setup`, `libui`, `libmeminfo`, `libbinder`, `libandroid_runtime` | mostly | kernel 4.14 is a superset of 4.9; keep, check each patch with `check_patches.py` against the chosen GSI. Phase 1 says all 23 apply to DP11.261016.003 |
| 4 VNDK v29 + mapping 29.0 | **replace by v30 + 30.0** | donor: the A14 GSI already has `com.android.vndk.v30` and `mapping/30.0.cil` (both verified on crDroid 10.13, `A14-GSI-CHECK.md`); the LineageOS 23.2 donor may or may not carry v30 (check). Vendor says `plat_sepolicy_vers 30.0`, VNDK 30 |
| 5 virt APEX EROFS -> ext4 | yes | the kernel has no erofs either (`/proc/filesystems`, verified) |
| 6 `services.jar`, `service-connectivity.jar`, BPF/netd.o/netbpfload patches, tethering APEX | yes | BPF atomics are absent by kernel version (4.14); `netd` `close_range` patch needed (`kprobe`: `close_range` ENOSYS) |
| 7 A16 audio stack closure | yes, but verify | vendor audio is HIDL 5.0 + `ISehDevicesFactory` + `audio.sec_primary`; the donor must be an Android 16 GSI (Lineage 23.2). Expect Samsung-specific effects libs to need `audio_effects` trimming |
| 8 lmkd replacement, lights, vibrator, health shims | lmkd and health yes; lights **not needed**; vibrator **rewrite** | lmkd: the in-kernel LMK and memcg v1 exist (`lmkd_inkernel.c` works, but re-derive minfree; Samsung SLMK `ro.slmk.*` was in charge). Lights: vendor is already AIDL. Vibrator: vendor HAL is HIDL 1.3, node `timed_output/vibrator/enable` (root-only), so the shim forwards to the HIDL HAL or writes that node. Health: shim reads `power_supply/battery` (a real gauge here; skip the ratio workaround, test) |
| 9 ROM Tuner app + daemon | **no** | MediaTek PPM/GPU/power nodes do not exist on Exynos 9611; use `--no-tuner` |
| 10 MindTheGapps | yes | MindTheGapps for the matching Android (17 does not exist yet; the tablet used the 16 zip) |
| vendor edits (`apply_vendor_a17.sh`: fstab flags, `/metadata` line, ueventd `/dev/ion`, seccomp syscalls, MP2/VP9 codecs, AIDL lights decl) | partly | Samsung fstab is different (`fstab.exynos9611`: only cache/userdata/efs/cpefs/misc); `/metadata` has no partition: stand-in needed (idea in PHASE2B-3-DRAFT.md); MP2 is `OMX.SEC.mp3.dec` `audio/mpeg-L2`; VP9: no removal planned; seccomp: re-check which new syscalls the A17 filter needs |
| Pixel layer | phone variant only | `stage_pixel.py` (phone Pixel Launcher/Wallpapers) not the Tablet layer; source: Pixel 9a (`tegu`) factory image of the same build (4 GB); privapp allowlist check mandatory (`check_privapp_offline.py`) |
| Telephony | yes | declare `radio.access/calling/data/messaging` (`tools/telephony`); Samsung IMS lost; Vi CSFB question (PLAN s14) |
| Bluetooth | check | tablet has MTK-specific `libbluetooth_jni` opcode patch (0xc5a); Exynos BT will not need it, but test; vendor BT is HIDL 1.0 + `ISehBluetooth` |
| Samsung services (argos, cass, emservice, teegris, vaultkeeper, hqm, ofi, snap) | n/a | stock vendor starts them: expect SELinux denials, boot permissive, check `logcat`/`dmesg` after boot |

## Inputs to fetch (not yet; ~10 to 12 GB)
Google A17 GSI (`aosp_arm64`, DP11.261016.003 or newer, from ci.android.com, about 1.2 GB zip), LineageOS 23.2 GSI donor (GitHub, about 1.3 GB xz), MindTheGapps 16 (GitHub, 0.4 GB), Pixel 9a factory zip (dl.google.com, 4 GB), the tablet repo (read-only reference). Disk: about 15 GB free on the Mac after the A14 files, so downloads must be sequential with cleanup, or wait until the A14 track is decided.

## Order
1. A14 first boot on the phone (Gate C). 2. If good: A17 base (steps 1 to 8 + vendor edits, no Pixel layer, no tuner), flash through TWRP like Gate C. 3. Pixel layer. Each flash is its own written OK; the A14 TWRP backup stays the way back.
