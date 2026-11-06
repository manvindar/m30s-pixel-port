# Offline check of the Android 14 candidate GSI (2026-11-06)

Candidate: `naz664/crDroid_gsi` release `v2025.03.08`, `crDroid-10.13-arm64_bgN-slim-Unofficial.img.xz` (1,139.5 MiB), SHA-256 `0a403c4de120adbb15e7219f7c2acc59337e6d7fc995eaf4ace7e9267e25a0dc` (GitHub release asset, no published checksum: this is the hash of what was downloaded). Raw image 3,477,872,640 bytes. Same family the tablet ran (bgN = arm64, GApps-capable, A/B-less "A-only" friendly). Kept untracked in `work/gsi14-crdroid/`. Read with debugfs only.

| Check | Result |
|---|---|
| Build | `google/treble_arm64_bgN/tdgsi_arm64_ab:14/AP2A.240905.003/eng.nobody.20250307.133324:userdebug`, Android 14, SDK 34, patch 2025-02-01 (not the UQ1A.231205.015 named in PLAN s9.1; that was the Phase 1 agent's build, a different GSI) |
| Fits the phone | ext4, 835,671 blocks of 4 KiB (3.2 GiB), 8,230 free: fits the 4800 MiB `system` with about 1.5 GiB for the Pixel layer and growth after `resize2fs` |
| ext4 features | has `shared_blocks` (read-only until removed): `e2fsck -fy -E unshare_blocks` then resize, as the tablet notes for Lineage; not yet done |
| VNDK v30 | present: `/system/system_ext/apex/com.android.vndk.v28..v34.apex` (v30 included). The stock phone mounts `com.android.vndk.v30` from its own system, so the vendor's expectation is met without a donor |
| SELinux mapping 30.0 | present (`/system/etc/selinux/mapping/30.0.cil`, `30.0.compat.cil`; also in `system_ext` as `30.0.compat.cil`), plus 28.0 to 34.0 |
| Framework compatibility matrices | `compatibility_matrix.{5,6,7,8,202404,device}.xml`; level 5 (Android 11) is the lowest. All 67 HAL entries in matrix 5 are `optional="true"`, so a vendor missing a HAL does not fail it. The phone's manifest says `target-level="3"`, **lower than any matrix shipped**; what libvintf does with that is UNVERIFIED (no `checkvintf` on the Mac); the tablet booted A14 to A17 GSIs with a similar old vendor, so I expect it not to be fatal at boot |
| Framework manifest | `manifest.xml` has HIDL entries with `max-level` 5 to 8 (legacy HALs the GSI still offers) |

Not checked yet: SELinux policy compile against the stock vendor cil (`secilc`), libhwui for `F_SEAL_FUTURE_WRITE` use (A14 should not seal), bionic fallbacks for missing syscalls, the init rc files that need Samsung services, and the GSI's `product`/`system_ext` content (what to strip for size).
