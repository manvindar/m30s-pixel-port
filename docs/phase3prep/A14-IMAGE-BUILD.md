# Android 14 test image: built offline (2026-11-06; nothing flashed, nothing written to the phone)

Scripts (committed): `tools/img/build_a14.sh GSI_RAW OUT_DIR [VENDOR_RAW]`, `tools/img/boot_cmdline.py`, `tools/policy/check_sepolicy.sh` (+ `build_secilc.sh`), `tools/img/sparse2raw.py`. Outputs live untracked in `work/a14/` (my worktree; regenerate with the scripts, inputs are the crDroid GSI and `fw-extracted/` vendor).

| Output | What | SHA-256 |
|---|---|---|
| `system-a14.img` | crDroid 10.13 A14 GSI (`AP2A.240905.003`), ext4 grown to exactly 4800 MiB (1,228,800 blocks = the `system` partition), `shared_blocks` removed (`e2fsck -E unshare_blocks` after the grow), `e2fsck -fn` clean, 378,264 blocks (1.44 GiB) free | `9a3351708301666f3ffe2050eb25b90418def310095d1422fe777099962ad24b` |
| `vendor-mp2.img` | stock `vendor` (CWC2) with the `audio/mpeg-L2` `<Type>` removed from `OMX.SEC.mp3.dec` (`media_codecs_sec_primary.xml`); file keeps inode, mode 0644, owner 0:0 and label `u:object_r:vendor_configs_file:s0`; XML parses; `e2fsck -fn` clean. **Optional**: only if the first boot aborts on `audio/mpeg-L2` like the tablet (not yet known here) | `285a28cc6785a25eb208d98ed9d387b2f345597c46e92403f42cbdf25dc113f9` |
| `boot-a14-permissive.img` | stock `boot.img` with cmdline `androidboot.selinux=permissive` (30 changed bytes, header only). Needs a debuggable build: the GSI is `userdebug`, so init should honour it (UNVERIFIED) | `d37067a47fd77d384404e0b6f873b660a967686605b3b3e5cbece8a9e623feff` |
| `boot-a14-permissive-root.img` | same plus `skip_initramfs rootwait ro init=/init root=/dev/sda25`: the fallback if `sboot` stops adding `root=` when vbmeta is disabled (see `FIRMWARE-TAR.md` s6). `sda25` is `system` (PIT id 25, Phase 0) | `b096a904457f460abbf032368da3b5e7ce38787d89b4ac6c0cfbfe2743693e9b` |

## What was checked on the image (read-only)
- SELinux: compiles with the stock vendor policy (details and the one upstream-secilc conflict in `A14-GSI-CHECK.md`).
- VNDK v30 APEX and mapping 30.0 present (same file).
- Fits: the image is exactly the partition size.
- Both boot images differ from the stock one only in the header cmdline (`cmp`: 30 bytes), AVB footer left stale on purpose (vbmeta disabled is part of the plan; with verification on they would not boot).

## What is NOT done
- GApps: MindTheGapps zip is a TWRP-flashable package; installing needs TWRP (or extracting its `system`/`product` payload into the image offline, 411 MB zip, about 1 GB installed; there is 1.44 GiB free: tight). Decide after the first boot.
- A vbmeta image for flashing: use a disabled one (`avbtool make_vbmeta_image --flags 2 --padding_size 4096`, UNVERIFIED for this bootloader; a disabled vbmeta is only needed once the system is replaced). `tools/apex/avbtool.py` from the tablet repo does it.
- The flash commands (Heimdall/Odin) and their order are gated: see PHASE2B-3-DRAFT.md and BACKUP-PLAN.md.
- Boot behaviour is entirely untested: no ramdisk-less boot with this kernel and a GSI has been tried; the tablet's experience is the only precedent.
