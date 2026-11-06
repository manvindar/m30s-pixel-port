# Phase 0: read-only inspection (2026-11-06)

Method: `adb -s DEVICE_SERIAL shell ...` as the `shell` user (not root, SELinux Enforcing). Only reads. USB debugging was enabled by the user between the first desk review and this run, and the Mac is authorised.
Raw files: `getprop-ro-scrubbed.txt` (ro.* and a few others; serial, IMEI-like, sales and SIM props removed), `partitions.txt`, `vendor-fstab.txt`, `vendor-vintf-manifest.xml`, `kernel-config.txt` (`/proc/config.gz`), `mount-df.txt`.
Not readable as `shell`: `/proc/cmdline`, `/apex`, `/system` contents beyond listing. Root would be needed; not obtained.

## Identity (all VERIFIED from the device)
| Item | Value |
|---|---|
| Model / device / product | SM-M307F / m30s / m30sdd |
| SoC / board | Exynos 9611 (`universal9611`, `ro.hardware=exynos9611`), 8 cores, Mali-G72 (GLES 3.2, `ro.opengles.version=196610`) |
| RAM | 5.5 GiB (MemTotal 5742128 kB), zram 3 GiB |
| Display | 1080x2340, density 420 (user override 375) |
| Storage | 128 GB UFS (`sda`, 124944384 kB) plus 64 GB exFAT SD card (`mmcblk0`) |
| Firmware | `M307FXXS4CWC2`, Android 11 (SDK 30), security patch 2023-04-01, build `RP1A.200720.012`, user/release-keys |
| Bootloader string | `M307FXXS4CWC2`; modem `M307FXXS4CWC1`; CSC INS (India), DSDS, Samsung RIL v4.0 (`libsec-ril`, Shannon 337 modem) |
| First API level | 28 (launched with Android 9) |
| ABI | `arm64-v8a`, `armeabi-v7a`, `armeabi` (zygote 64 + 32) |
| Kernel | `4.14.113-22430363`, built 2023-04-24, clang 6.0.1 |

## The answers Pam asked for
| Question | Answer | State |
|---|---|---|
| `ro.treble.enabled` | `true` | VERIFIED |
| `ro.boot.slot_suffix` | absent. **A-only.** No `bota`/`_a`/`_b` pairs for system, vendor, boot | VERIFIED |
| Dynamic partitions (super) | **No.** No `super` partition, no `ro.boot.dynamic_partitions`; `system`, `vendor`, `product` are plain partitions | VERIFIED |
| System-as-root | yes (`ro.build.system_root_image=true`, `/dev/root` is `/system`, 4.5 GB, 98% full) | VERIFIED |
| Vendor VNDK level | `ro.vndk.version=30`, `ro.vendor.build.version.sdk=30` (Android 11 vendor) | VERIFIED |
| VINTF device manifest `target-level` | **3** (Android 9 / P), with HIDL HALs only (audio 5.0, fingerprint 2.1, camera provider, radio). No AIDL HALs | VERIFIED; what a GSI does with level 3 is the main open question |
| `ro.product.cpu.abi` | `arm64-v8a` | VERIFIED |
| Verified boot | `ro.boot.verifiedbootstate=green`, `vbmeta.device_state=locked`, AVB 1.1, `ro.boot.veritymode=enforcing`, `vbmeta` partition 64 KB | VERIFIED |
| Bootloader lock / unlock state | `ro.boot.flash.locked=1`, `ro.boot.warranty_bit=0` (Knox not tripped), `ro.boot.em.status=0x0`, `ro.oem_unlock_supported=1`, **`sys.oem_unlock_allowed=0`** (the Developer options "OEM unlocking" toggle is off) | VERIFIED |
| Encryption | file based (`ro.crypto.type=file`), f2fs `/data` with `fileencryption=ice` | VERIFIED |

## Partition layout (from `/dev/block/by-name`, sizes from `/proc/partitions`)
All on UFS `sda`. Sizes in MiB.
- Boot chain and signing: `bota0` 4.5 (sda1), `bota1` 7.5 (sda2), `bota2` 8 (sda8), `bota3` 1.4 (sda24), `param` 8, `up_param` 8, `uh` 2, `uhcfg` 4, `steady` 4, `keystorage` 0.5, `keyrefuge` 16, `keydata` 16, `dqmdbg` 16, `vbmeta` 64 KB.
- Kernel: `boot` 55 (sda14), `recovery` 64.5 (sda15), `dtb` 8, `dtbo` 8.
- OS: `system` **4800 MiB** (sda25, 4915200 kB), `vendor` 600 (sda26), `product` 296 (sda27). No `odm`, no `system_ext` partition (it lives inside `/system/system_ext`). `/product` and `/vendor` are dm-verity (dm-1, dm-2).
- Data and misc: `userdata` 113 GB f2fs (sda32), `cache` 300 (sda28), `omr` 50, `misc` 1, `persistent` 0.5, `efs` 20 (sda3) and `sec_efs` 20 (sda7), `cpefs` 6 (sdd1), `radio` 50 (sda16), `nad_fw`, `nad_refer`, `cp_debug`.
- `efs`/`sec_efs`/`cpefs` hold IMEI and radio calibration. They must be backed up before any unlock or flash (Phase 1).

Fstab (`/vendor/etc/fstab.exynos9611`): only `cache`, `userdata`, `efs`, `cpefs`, `misc` are listed. `system`, `vendor`, `product` are mounted by early init (dm-verity, `first_stage_mount`) from the ramdisk's own fstab. The ramdisk fstab was not read (needs boot image extraction).

Fit check for a GSI: the `system` partition is 4800 MiB; a typical arm64 GSI system image is 2.5 to 3.5 GB plus Pixel layer, so size is fine (the tablet's was 3.8 GiB).

## Kernel (from `/proc/config.gz`)
Present: `CONFIG_BPF_SYSCALL`, `CGROUP_BPF`, `NETFILTER_XT_MATCH_BPF`, `ASHMEM`, binder with `binder,hwbinder,vndbinder`, `SECCOMP_FILTER`, `F2FS_FS_ENCRYPTION`, `SDCARD_FS`, `UID_SYS_STATS`, `ZRAM`, `DM_VERITY` (+FEC), `DM_CRYPT`, `SELINUX`, `FUSE_FS`.
Absent or off: `CONFIG_PSI` (no line at all: Android 12+ lmkd wants pressure stall information; see risks), `CONFIG_USERFAULTFD`, `CONFIG_KPROBES`, `CONFIG_BPF_JIT`, `CONFIG_ZRAM_WRITEBACK`.
Not testable read-only (need to run code on the phone): `F_SEAL_FUTURE_WRITE` (mainline 5.1; the TB-X606V kernel 4.9 lacks it, 4.14.113 probably too), `close_range` (mainline 5.9, so absent), BPF atomic fetch-add (absent in 4.14 by definition: the atomics came in 5.12).
`CONFIG_MEMFD*` is not listed, but `memfd_create` is a syscall in 4.14 (3.17+), not a config switch.

## Device state that matters for risk
- Personal usage, installed-app counts and storage consumption are omitted from public documentation.
- Samsung vendor HAL surface (from the VINTF manifest): `vendor.samsung.hardware.*` for audio, camera provider, fingerprint, GNSS, radio (3 flavours), bluetooth, wifi supplicant, vibrator, sysinput, snap, security drk and widevine keyprov, plus `vendor.samsung_slsi.hardware.*` (ExynosHWCServiceTW, configstore, radio). Standard HIDL: audio 5.0, camera provider, composer/mapper/allocator, keymaster, health 2.1, thermal, radio 1.x. `android.hardware.sensors@2.0-multihal`, `power-samsung`, `lights-default-sec`.

## Not done (needs the user or root)
- No backup of any partition, no root, no TWRP, no `/proc/cmdline`, no `dumpsys` beyond battery/users/packages count, no vendor `ls` of `/vendor/lib64` for vndk-sp or camera libs.
- Nothing was written to the phone.
