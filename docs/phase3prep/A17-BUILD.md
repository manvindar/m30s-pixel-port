# A17 base image for the M30s (built offline 2026-11-07)

Builder: `tools/img/build_a17.py` (generated from the tablet's `build_image17.py` by `tools/img/make_build_a17.py`, 21 asserted text substitutions) + `tools/img/build_vendor_a17.py`. The tablet repo's `tools/` dir is the patch library (`A17_TOOLS`); because its health `build.sh` writes into `tools/health/out`, a copy lives in `work/a17/tools` (the repo is read-only for the agent sandbox).

## Inputs (all verified)
| Input | Source | SHA-256 |
|---|---|---|
| Google GSI `aosp_arm64-exp-DP11.261016.003-16708287-d735a3b1.zip` | dl.google.com/developers/android/cinnamonbun/images/gsi/ | d735a3b11fe1b76a736f325f5500f7211167642fe2ed39dae0cf530d1cf51436 (checked); `system.img` is raw ext4, 2119327744 bytes, `shared_blocks` set |
| LineageOS 23.2 GSI (A16 audio stack donor) `LineageOS-23.2-20260524-GAPPS-EXT4-GSI.7z` | SourceForge misterztr-gsi | 22b3c069445cc3d54819361a1636f7b27ff455dc547f300b868cecddb1b2e22d (checked, the tablet CI's pin); image 3446353920 bytes raw ext4 |
| VNDK v30 APEX + `30.0.cil` + `30.0.compat.cil` | the crDroid 10.13 A14 GSI (xz kept in `work/gsi14-crdroid/`), dumped with debugfs into `work/a17/vndk30/` | (not hashed) |
| stock vendor with MP2 removed | `work/a14/vendor-mp2.img` | 285a28cc...113f9 |

`check_patches.py` against the DP11.261016.003 system.img: **0 of 23 patches fail** (libc/linkers incl. inside the runtime APEX, libui, libmeminfo, libbinder, libandroid_runtime, services.jar, tethering/bluetooth/swcodec files, netd.o).

## What differs from the tablet recipe (M30s changes)
- partition 5033164800 bytes (4800 MiB), VNDK v30 + SELinux mapping 30.0 instead of v29/29.0 (donor: A14 GSI), `vndk-sp-30` links.
- identity props: real Samsung fingerprint `samsung/m30sdd/m30s:11/RP1A.200720.012/M307FXXS4CWC2:user/release-keys`, product props brand samsung / device m30s / model SM-M307F / name m30sdd; Bluetooth class of device 5a,02,0c (phone); MediaTek sharpening prop removed.
- no ROM Tuner (MediaTek only), no Pixel layer, no GApps, no Dolby in this first image; **no lights shim** (the Samsung vendor already declares AIDL `ILights/default`), **no vibrator shim** (vendor has HIDL 1.3 only; haptics missing until a shim is written), health shim kept.
- `zig` is not installed here: `work/bin/zig` is a shim that calls the NDK 26.1 clang (static bionic instead of musl) for the tracer and lmkd binaries. Python deps in `work/venv` (pyelftools, capstone). JAVA_HOME = temurin-17. `--build-tools` 35.0.0.

## Outputs
| File | Size | SHA-256 | Check |
|---|---|---|---|
| `work/a17/system-a17-m30s.img` | 5033164800 (= 1228800 blocks) | 27d97ac16ff0959d0c94143da5dab613259c268ba464c891db40fa43d08713be | `e2fsck -fn` clean, 554751 of 1228800 blocks used (2.1 GiB), `shared_blocks` gone |
| `work/a17/vendor-a17.img` | 629145600 | 1106357103fb35103d49d6682d0fbdd6d36fd9166dab14e213eb7fe3c6a3c6b1 | `e2fsck -fn` clean (done inside the script) |

Vendor edits (`build_vendor_a17.py`): tmpfs `/metadata` line in `fstab.exynos9611` (volatile stand-in; the phone has no metadata partition), `/vendor/etc/ueventd.rc` copied from `/vendor/ueventd.rc` (it already has `/dev/ion 0666`), 12 (3 for the c2 policy) syscalls appended to the configstore, mediacodec, mediaextractor_sec and samsung c2 seccomp policies, and the AIDL health manifest fragment. The Samsung fstab has none of the legacy flags A17 rejects (`forcefdeorfbe`, `resize`); `fileencryption=ice` and `reservedsize=128M` are untouched (they booted on A14).

## A14 stays restorable
`work/a14/system-a14.img` (sha256 9a3351708301666f3ffe2050eb25b90418def310095d1422fe777099962ad24b) and `boot-a14-permissive.img` are kept; they can be rebuilt with `tools/img/build_a14.sh` from the crDroid xz (kept) and `fw-extracted/`. Stock vendor for a full restore: `~/Aistuff/m30s-pixel-port/fw-extracted/img/vendor.img` (hash in FIRMWARE-TAR.md). Partition dump: `~/Aistuff/m30s-pixel-port/partition-dump/`.
