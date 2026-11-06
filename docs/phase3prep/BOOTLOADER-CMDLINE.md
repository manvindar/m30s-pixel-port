# Bootloader command line and the root device (disassembly of `sboot.bin`, 2026-11-06)

Question: with a disabled vbmeta, does the kernel still get a `root=`? Answer from `sboot.bin` (`M307FXXS4CWC2`, SHA-256 `1f60af5e9ff15bea4368ae7bd6d61097ee4166b3937650df4fb66a778a5beea2`, decompressed from `BL/sboot.bin.lz4`): **yes, the bootloader adds it itself, from the partition table, with no condition on vbmeta in that code path.** Static reading only; not run on the phone.

Method: `ADRP`+`ADD` string references resolve to file offsets directly (image mapped from file offset 0, 4 KiB aligned base); the string `skip_initramfs rootwait ro init=/init root=/dev/sda%d` (file offset 0x14a220) is referenced from the code at 0xae0f0 (capstone, arm64).

Excerpt (cmdline builder; `0x64944` is the cmdline append/printf helper, `0xa7698` looks up a PIT entry by name):
```
ae0d4: adrp x0, #0x13c000
ae0d8: add  x0, x0, #0xfe8      ; "SYSTEM"
ae0dc: bl   #0xa7698            ; find partition "SYSTEM" in the PIT, x0 = entry or NULL
ae0e0: mov  x2, x0
ae0e4: cbz  x0, #0xae110        ; no SYSTEM entry: skip
ae0e8: ldrb w1, [x0, #9] ; ldrb w4, [x0, #8] ; ldrb w3, [x2, #0xa] ; ldrb w2, [x2, #0xb]
ae0f8: add  x0, x0, #0x220      ; "skip_initramfs rootwait ro init=/init root=/dev/sda%d"
ae100..ae108: assemble the 32-bit entry id from bytes 8..11
ae10c: bl   #0x64944            ; append to the kernel cmdline
ae118: add  x0, x0, #0x258      ; "androidboot.dtbo_idx=%d"
```
Around it the same builder appends `androidboot.serialno`, `androidboot.ap_serial`, `androidboot.cp_reserved_mem`, `androidboot.em.model=SM-M307F`, `androidboot.em.status`, `androidboot.sb.debug0`... none of them gated by AVB. The three branches before the block (`b.eq` at 0xae09c, 0xae0b4, 0xae0d0) test the modem/boot-mode state (a magic `0x494d`, a flag word), not vbmeta, as far as the surrounding code shows; they jump to other blocks and I did not trace that they rejoin.

Conclusions
1. On this bootloader the kernel always receives `skip_initramfs rootwait ro init=/init root=/dev/sdaN`, with N the PIT id of `SYSTEM` (**25**, as in the PIT dump). That is exactly what a ramdisk-less system-as-root boot image needs; a disabled vbmeta only removes the later `root=/dev/dm-0` and verity table. **The risk raised in `STOCK-IMAGES.md` (no root device with a disabled vbmeta) is, in my reading, resolved.** The fallback `boot-a14-permissive-root.img` stays for completeness (duplicate `root=` is harmless: last wins).
2. Remaining unknowns: whether the builder runs when vbmeta is disabled and the device is unlocked (no reason to think otherwise), and what the `skip_initramfs` does on a kernel that is entered with `init=/init` from a ext4 GSI `system` (`/init` exists in the GSI root: A-only system-as-root GSIs have it; to be confirmed on the image).
3. `androidboot.dtbo_idx` and the `em.*` values show the bootloader also passes the board/dtbo selection: keep `dtbo` and `dtb` stock.

## A14 libcutils and `F_SEAL_FUTURE_WRITE` (kernel lacks it, `kprobe`)
The A14 GSI's `libcutils.so` has three `fcntl(fd, F_ADD_SEALS=0x409, ...)` sites; two use seals including `0x10` (`F_SEAL_FUTURE_WRITE`, at 0x15e10 with 0x11 and 0x1641c with 0x10) in the ashmem-over-memfd code, behind the memfd support check (cached bool). `libhwui` has one `F_ADD_SEALS` immediate without the 0x10 bit nearby. The tablet's kernel 4.9 also lacks the seal and ran A14 GSIs, so the fallback to `/dev/ashmem` (present on this phone) is expected; confirm at the first boot (`ls -l /proc/*/fd | grep memfd` or a crash in `ashmem`). UNVERIFIED.
