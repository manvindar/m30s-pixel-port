# Full stock firmware, ingested and catalogued (2026-11-06)

Source: `~/Aistuff/m30s-pixel-port/SamFOTA.com_SM-M307F_2_20230427160910_hmjyjlzw7c_fac.zip` (4,388,968,423 bytes), SHA-256 `6d4eef6d5f614a3985b4c1a8e7b850900ab96ee4cb68981ee090ce7f91c197b4`. Read-only access worked (no sandbox change). Untracked (`.gitignore`: `*.zip`, `*.tar*`, `*.lz4`, `*.img`, `*.bin`, `*.pit`, `fw/`). Extracted to `/home/developer/HarnessAgents/hive/agents/worker-m30s-lead/fw/img/{AP,BL,CP,CSC,HOME_CSC}/` (lz4 as shipped) and `fw/img/raw/` (small partitions decompressed). That folder is deleted at my teardown; the user's zip is the permanent copy. Tar files were removed after extraction to save disk (hashes below).

## 1. Tars inside (each is `.tar.md5`: tar plus a trailing md5 line; all 5 md5 trailers verified)
| Tar | File size | tar md5 (verified) |
|---|---|---|
| `AP_M307FXXS4CWC2_CL22430363_QB64571728_REV00_user_low_ship_meta_RKEY_OS11` | 4,738,908,355 | `64eb279101884b0ef4aaa56f21557820` |
| `BL_M307FXXS4CWC2_CL22430363_QB64571728_REV00_user_low_ship` | 3,512,497 | `076a66a752cc0fcab079c7f28671dfad` |
| `CP_M307FXXS4CWC1_CP24044316_CL22430363_QB64072228_REV00_user_low_ship` | 26,665,149 | `4b442e7b422f0b2e91c9c5888b7608e6` |
| `CSC_OMC_ODM_M307FODM4CWC2_CL22430363_QB64571707_REV00_user_low_ship` | 203,305,148 | `2f4bcc58b5df127bd439d8b0a355abbb` |
| `HOME_CSC_OMC_ODM_M307FODM4CWC2_CL22430363_QB64571707_REV00_user_low_ship` | 203,284,673 | `a7ff1eac3dd67e01d7ba27160fc7bebc` |

## 2. Version vs the phone, and anti-rollback
Phone (Phase 0): bootloader `M307FXXS4CWC2`, modem `M307FXXS4CWC1`, CSC `INS`/`ODM4CWC2`-class, Android 11, patch 2023-04-01. File names: AP and BL `M307FXXS4CWC2` (**binary revision 4**, the "S4"), CP `M307FXXS4CWC1`, CSC `M307FODM4CWC2`. Same as the phone, so the binary revision is equal (anti-rollback needs equal or newer: **OK**). Strings inside the images agree: `sboot.bin`, `dt.img`, `dtbo.img`, `cm.bin` contain `M307FXXS4CWC2`; `modem.bin` contains `M307FXXS4CWC1`. Not decoded: the numeric bit/binary counter in the Samsung bootloader (the name's "S4" is the convention the plan used). The build is the stock firmware the phone currently runs (Phase 3-prep `STOCK-IMAGES.md`).

## 3. Match with the user's earlier images (SHA-256 of the decompressed sparse/raw image)
| Image | In tar | User's file | Result |
|---|---|---|---|
| system | AP `system.img.lz4` | `system.img` `d30d7501...bd400b6` | **identical** |
| vendor | AP `vendor.img.lz4` | `vendor.img` `acc46f9d...d61f7` (full hash in STOCK-IMAGES.md) | **identical** |
| product | CSC and HOME_CSC `product.img.lz4` | `product.img` `7a6e796b...59804c` | **identical** (both CSC tars carry the same product) |
| boot | AP | `boot.img` | **identical** (`cmp`) |
| recovery | AP | `recovery(Stock).img` | **identical** (`cmp`) |
| vbmeta | AP | `vbmeta.img` | **identical** (`cmp`) |

## 4. Partition inventory (PIT `M30S_SWA_OPEN.pit`, 42 entries, matches Phase 0 sizes)
In the tars (file : partition : decompressed size):
- **AP:** `boot.img` BOOT 55 MiB (57,671,680 B); `recovery.img` RECOVERY 64.5 MiB; `dt.img` DTB 8 MiB (8,388,608); `dtbo.img` DTBO 8 MiB; `vbmeta.img` VBMETA (8,656 B in 64 KiB partition); `system.img` SYSTEM 4800 MiB; `vendor.img` VENDOR 600 MiB; `userdata.img` USERDATA (sparse, 1.37 GB decoded); `meta-data/fota.zip`. Flashing the AP tar **writes userdata.img**: this wipes user data (fine after an unlock, not for a plain restore).
- **BL:** `sboot.bin` BOOTLOADER (3.1 MiB); `param.bin` PARAM; `up_param.bin` UP_PARAM; `cm.bin` CM; `keystorage.bin` KEYSTORAGE; `uh.bin` UH.
- **CP:** `modem.bin` RADIO (41 MiB); `modem_debug.bin` CP_DEBUG (5 MiB).
- **CSC / HOME_CSC:** `cache.img` CACHE (300 MiB partition, tiny image); `omr.img` OMR (CSC only); `product.img` PRODUCT 296 MiB; `M30S_SWA_OPEN.pit` (CSC only). HOME_CSC is the variant that does not carry the PIT or omr; Odin treats it as "keep data".
- **Not in any tar** (so not restorable from this firmware, back them up from the phone with root/TWRP before an unlock): `efs`, `sec_efs`, `cpefs`, `persistent`, `keyrefuge`, `keydata`, `steady`, `uhcfg`, `nad_refer`, `nad_fw`, `dqmdbg`, `misc`, `bota0..3`, `ect`, `acpm`, `ul_keys`. The IMEI/radio calibration partitions `efs`, `sec_efs`, `cpefs` are the ones that matter.
PIT numbers (start, blocks in 4 KiB units): SYSTEM 83968/1228800, VENDOR 1312768/153600, PRODUCT 1466368/75776, CACHE 1542144/76800, BOOT 27264/14080, RECOVERY 41344/16512, DTB 23168/2048, DTBO 25216/2048, VBMETA 83584/16: same as the sizes read from the phone.

## 5. SHA-256 of the decompressed small partitions (`fw/img/raw/`)
| File | SHA-256 |
|---|---|
| boot.img | `d788f41397481fd7990ece136460edc1b62bac35c73bc4eda1593bdb50704c65` |
| cache.img | `367a3dbaa9ad71056fb83621f94f08ac75f6caa757c407d4baaf57ba1ec6442d` |
| cm.bin | `18632b8b57d56f103845b67e28ffb67c0cd6315a7a9912ce05a594ecd63965be` |
| dt.img | `30c19e6a80c095bf60f60f8239a74f25b3a2a10dd885453276e80a13b7ae7b32` |
| dtbo.img | `f313d3b55131a7a34f41e1ca2ff54d1fc632438aaa6de1ba7b21621913f46247` |
| keystorage.bin | `57720098ddcc6e5fcd178763e677eaddb925361ac10cc18aaddae17319c9dc84` |
| modem_debug.bin | `d409f675980421304bb1b8630c4a905e32192a9a3adf9c73a84bbf2daf1a169e` |
| modem.bin | `7fdc84661e12abfbc2f7e69e3b5a81f2058745a531fba7b001ee7a64c1eac66b` |
| omr.img | `004056860b131b4c30efd57bb2c987891521320d27b39c793ab3753f76ff75f9` |
| param.bin | `63785d3e0b74b7bebb13ff4232649c0345601dc343b51df83a3fdc70581a3d35` |
| recovery.img | `d0bbfc4c281726ac1aa9f1e6d9f64b4100ca7b0f3e0018427fd0220555939ede` |
| sboot.bin | `1f60af5e9ff15bea4368ae7bd6d61097ee4166b3937650df4fb66a778a5beea2` |
| uh.bin | `5d328bee3ca07bc216a8a273bcaa5940ff4671564e760f6867bce891d7cbee1d` |
| up_param.bin | `b31a0c18f964ef4cea6199add3908cb25015536b5ae724117353859c135c9243` |
| vbmeta.img | `7828ef715f26bd2fc688dd06e13cc7bc162480a1dc82f5c768fb2caf0fc9faf9` |

The lz4 files as shipped (what an Odin flash reads): `fw/img/lz4-sha256.txt` in the same folder; the sums for the big ones: system `fe86fce9ddbc12a01b6014d5df36620cbf3d2e0041444aa7602046c906073fcb`, vendor `20b2663333b5f5ffeb453eacdb407ef4bc3a5812c28dba9928ae7d8af4f29ae9`, userdata `0cbfe9e5d29243bad45206b08a150bcf3dba55de0b5f6afb3595d1214d899797`, dt `e5cf0df70b01ac4fd967308f0d1b6add038b17d26ce0288fefad01a3e84beb64`, dtbo `8128a6a037ae1f28c1c2bdbe01e7a861ab9f74d4fc1809eba8dad23a3abeebf2`.

## 6. The root-device question, answered mostly (from `sboot.bin`)
`sboot.bin` (the Samsung bootloader) contains the literal command line fragment `skip_initramfs rootwait ro init=/init root=/dev/sda%d` (offset 0x14a220), plus the libavb string `root=PARTUUID=$(ANDROID_SYSTEM_PARTUUID)`. So the bootloader itself builds the default `root=/dev/sdaN` (N from the system partition) for a ramdisk-less system-as-root boot image; the vbmeta descriptor's `root=/dev/dm-0` plus verity table is appended afterwards and wins when verification is on. **This lowers the risk in `STOCK-IMAGES.md` ("vbmeta disabled drops root="): with verification off the bootloader's own `root=/dev/sda25` should remain.** Still UNVERIFIED on hardware (a disassembly or a test boot is needed to confirm N and that the builder runs when vbmeta is disabled); a header cmdline in a rebuilt boot image is the fallback. `dt.img` has a `bootargs` node but no `root=` string.

## 7. Restore path
With these files plus a root backup of the partitions listed under "Not in any tar", the phone can be returned to stock from Download mode (Odin on Windows or Heimdall, one operation per session): BL + AP + CP + CSC. Flashing AP wipes userdata. The PIT lets a full re-partition be restored. Nothing here was flashed.
