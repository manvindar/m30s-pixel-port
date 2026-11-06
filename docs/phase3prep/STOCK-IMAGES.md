# Stock images supplied by the user (checked 2026-11-06)

Location (untracked, `*.img` is gitignored): `~/Aistuff/m30s-pixel-port/`. Read-only checks only; raw ext4 copies were made in my own `work/stock/` (not committed) with `tools/img/sparse2raw.py` (Android sparse -> raw, no `simg2img` on the Mac).

| File | Bytes | Format | SHA-256 |
|---|---|---|---|
| `system.img` | 4,811,637,772 | sparse ext4 (raw = 5,033,164,800 = exactly 4800 MiB, the partition size) | `d30d75015d760d0021fa71edc9a39b9dc4481f8de5cb58fa5c31767e7bd400b6` |
| `vendor.img` | 462,840,040 | sparse ext4 (raw 600 MiB) | `acc46f9d4ceb57e4847b6cafb235c68c8b9fb378c664fb4823b9a47faa7d61f7` |
| `product.img` | 243,589,316 | sparse ext4 (raw 296 MiB) | `7a6e796b21015044120447388fdb1696155b01cc23d296e3ce8cb49ddb59804c` |
| `boot.img` | 57,671,680 | Android boot image v1, AVB footer | `d788f41397481fd7990ece136460edc1b62bac35c73bc4eda1593bdb50704c65` |
| `recovery(Stock).img` | 67,633,152 | Android boot image v1, AVB footer | `d0bbfc4c281726ac1aa9f1e6d9f64b4100ca7b0f3e0018427fd0220555939ede` |
| `vbmeta.img` | 8,656 | AVB 1.0, algorithm SHA256_RSA4096 | `7828ef715f26bd2fc688dd06e13cc7bc162480a1dc82f5c768fb2caf0fc9faf9` |
| `twrp-3.7.0_9-0-m30s.img` | 43,700,224 | boot image v1, `buildvariant=eng` | `d67a081233cc98578f9fd3d5c0a761ada53b6dc516fe064b10cd6e9261a41b93` |

## Same firmware as the phone? Yes (CWC2)
- `vendor` and `system` build props: `ro.build.display.id=RP1A.200720.012.M307FXXS4CWC2`, vendor fingerprint `samsung/m30sdd/m30s:11/RP1A.200720.012/M307FXXS4CWC2:user/release-keys`, security patch 2023-04-01: identical to the phone (Phase 0).
- `vendor/etc/vintf/manifest.xml`: **byte-identical** to the file read from the phone (14,841 bytes, `cmp`). The 21 manifest fragments in `vendor/etc/vintf/manifest/` match the phone's list. `vendor/etc/fstab.exynos9611` identical to Phase 0.
- So the Phase 0 to 2a findings about the vendor hold for these images. Not proven bit for bit (the phone's block devices cannot be hashed without root), but every file compared matches. These are the restore source for `system`, `vendor`, `product`, `boot`, `recovery`, `vbmeta`; a full restore also needs `dtb`, `dtbo`, `cache` and the firmware's BL/CP/CSC parts, which are not here (ask whether the full tar is coming).

## vbmeta
AVB 1.0 header, `avbtool 1.1.0`, rollback index 0, **flags 0** (verification on), algorithm SHA256_RSA4096, public key sha1 `8655147bde065e35bfbd9eec8c3480556f2bf78f`. Descriptors: chain partitions `recovery` (rollback location 2), `dtb` (3), `dtbo` (4), `product` (7), all with that same key; props `os_version 11`, `security_patch 2023-04-01`; and a **kernel cmdline descriptor with flags 1** that carries `root=/dev/dm-0` and the whole system dm-verity table (`dm="1 vroot none ro 1,0 9675136 verity 1 PARTUUID=$(ANDROID_SYSTEM_PARTUUID) ... sha256 ... fec_roots 2 ..."`).

## boot.img: no ramdisk, empty cmdline (important)
- `boot.img` header: kernel 27,176,972 bytes (uncompressed arm64 `Image`), **ramdisk size 0**, **cmdline empty**, header v1, page 2048. It is a kernel-only image. The recovery image has the ramdisk (gzip, 10.6 MB) and also an empty cmdline; TWRP has the cmdline `buildvariant=eng` and a 16 MB gzip ramdisk.
- The kernel has `CONFIG_CMDLINE=""` and no built-in `root=`. The only place `root=/dev/dm-0` comes from is the **vbmeta cmdline descriptor** (the bootloader appends it) or the device tree `/chosen/bootargs` (unreadable as `shell`, not in the files here).
- Consequence 1, **vbmeta disabled can remove the root device** (UNVERIFIED, from libavb as I remember it, check the source before relying on it): the descriptor's flags value 1 is `AVB_KERNEL_CMDLINE_FLAGS_USE_ONLY_IF_HASHTREE_NOT_DISABLED`, so a libavb-based bootloader skips that cmdline when vbmeta flags say hashtree disabled (flags 2). PLAN section 4.3 flashes exactly such a vbmeta. Then the kernel would get no `root=` and panic at the root mount, unless the dtb `/chosen/bootargs` carries one (not readable as `shell`; the tablet needed a dtb bootargs patch for a similar reason, `tb-x606v-android17/tools/porting` area `patch_dtb_bootargs.py`). Simplest mitigation: put `root=/dev/sda25 rootwait ro` (system is `sda25`, Phase 0) in the cmdline of a rebuilt boot image. Whether the Samsung bootloader honours the header cmdline is also untested. Decide and test before the first flash. A wrong guess ends in a non-booting phone that can still enter Download mode (bootloader is separate), not in a brick.
- Consequence 2, **Magisk**: the boot image has no ramdisk, so Magisk's patch of `boot.img` has nothing to attach to; on system-as-root devices of this kind Magisk is installed into the **recovery** image and entered with the recovery key combination (the Magisk docs call this the "recovery mode" install). With TWRP in `recovery` that route is lost (TWRP and Magisk would share it). Plan: for a GSI with root, use a **boot image with a ramdisk we add** (Magisk can create one: `magiskboot` repack with `--rootfs`?) or install Magisk through TWRP flashable zip (writes a ramdisk into the boot image when absent). UNVERIFIED either way: needs a small offline experiment with `magiskboot` (from the Magisk APK in `~/Aistuff/android-aosp/work/magisk`).
- AVB footer: `boot.img`, `recovery(Stock).img` both end with an AVB hash footer, so a modified boot image needs its footer rebuilt or vbmeta verification off (see Consequence 1).
