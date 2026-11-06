# Plan: Pixel design on the Galaxy M30s (SM-M307F)

Written 2026-11-06 after Phase 0 (`docs/phase0/PHASE0.md`). Labels: VERIFIED = read from the phone; RELAYED = from Pam's desk review or a web source nobody here could open (the XDA page returned 403 to this agent); UNVERIFIED = expectation, test before relying on it.

## 1. Verdict
**Feasible, with one gate the user controls: the bootloader unlock.** The phone is A-only with Treble, plain partitions (no `super`), a 4.7 GiB `system`, 5.5 GiB RAM, arm64, Android 11 vendor (VNDK 30), HIDL-only HALs. That is the same shape as the TB-X606V, which already runs a GSI plus a Pixel layer. The tablet toolchain (GSI image edit, Pixel Launcher rebuild, privapp allowlist check, boot diagnostics) carries over. Nothing on this phone has been unlocked; the unlock wipes data, trips Knox permanently and voids the warranty, and the device contains personal data. So: **nothing destructive starts without the user's explicit OK and a verified backup.**

What is real risk and not paper risk:
- **Phone functions.** Calls, mobile data, VoLTE/IMS, camera, fingerprint, audio and NFC go through Samsung vendor HALs (`vendor.samsung.hardware.*`, Shannon modem, `libsec-ril`). A GSI boots, but these are the parts that break first. RELAYED: the XDA Android 14 build for the M307F boots on the stock kernel; which of these work is not known to us.
- **VINTF level 3.** The vendor manifest says `target-level="3"` (Android 9), although the vendor is built as Android 11. A newer GSI's framework compatibility matrix may refuse it. GSI maintainers normally bypass this, and the XDA build is evidence that one does for A14. UNVERIFIED for A15 and newer.
- **No way back without a stock firmware tar.** Samsung has no fastboot and has anti-rollback ("S4" in `M307FXXS4CWC2` is the bootloader binary revision). Only firmware with binary 4 or higher can be flashed back.

## 2. Which GSI
Recommendation: **Android 14 (LineageOS 21 / AndyYan `arm64_bgN` family, or Google's own GSI), vndk 30 compatible.**
- RELAYED: Pam's XDA link, an unofficial A14 build "NEXT OS" on LineageOS 21 with stock kernel and TWRP for the M307F (https://xdaforums.com/t/rom-unofficial-14-m307f-next-os-lineageos-21-0-with-gapps-for-galaxy-m30s.4800022/). It is the one proven point; read its bug list before Phase 3 (a browser or the user can open it).
- Our own tablet history says the same: Android 14 (Lineage 21 GSI) was the stable baseline on a 4.9 kernel; 15 never booted usably there; 16 and 17 needed binary patches (`libhwui` seal patch, `netd` close_range patch, BPF XADD rewrite).
- Kernel here is 4.14.113 (better than the tablet's 4.9). Android 16+ still needs the same class of patches (missing `F_SEAL_FUTURE_WRITE`, `close_range`, BPF atomics: UNVERIFIED, tested only by running code on the phone). Newer GSIs also assume more of the kernel (see PSI below).
- **Order of attempts:** A14 first (target of this plan), then A15 only if the A14 base is solid. Do not start at A16/A17: a phone with a bad radio stack is much less forgiving than a tablet.
- Open check that needs no phone access: compare the A14 GSI's `system/etc/vintf/compatibility_matrix*.xml` against `docs/phase0/vendor-vintf-manifest.xml` by hand (Android has `checkvintf`; none is installed on the Mac).
- `CONFIG_PSI` is absent from the kernel config. Android 12+ lmkd prefers pressure stall information and falls back to the legacy path; low-memory killing may be poor on 5.5 GiB. UNVERIFIED, measure in Phase 3 (the tablet's 4.9 kernel ran A14 to A17; whether it has PSI was not checked).

## 3. Layers: phone, not tablet
| Layer | Use here? | Notes |
|---|---|---|
| Pixel **Launcher (phone)**, Wallpapers & style, Pixel fonts, themes, Material You | Yes. This is the goal | Take the launcher APK from the Pixel phone image of the **same generation as the GSI** (A14 build) so most of `tools/pixel/build_pixel_launcher.sh` is not needed. That script exists because the tablet's Pixel Launcher 17 was newer than its GSI. |
| Pixel **Tablet** layer (SystemUITitan taskbar, two-pane Settings, Hub mode, `stage_pixel_tablet.py`) | **No** | Tablet-only. A 6.4 inch 1080x2340 phone wants phone SystemUI and no taskbar. Leave those scripts untouched. |
| Pixel SystemUI / Settings (phone, `SystemUIGoogle`) | Later, optional | The biggest gain in look and the biggest boot risk (privapp allowlists, resource id remaps, `package_cache` clearing: all documented in `tb-x606v-android17/docs/PIXEL.md`). Only after the plain GSI plus Pixel Launcher is stable. |
| GApps | MindTheGapps (matching Android version) | As on the tablet. |
| Pixel setup wizard fix (delete `Provision`), `wizard_lock_skip.sh` | Reuse if the Pixel wizard is staged | `tools/pixel/`. |
| privapp allowlist rule | **Mandatory** | `/vendor/build.prop` on a Samsung vendor may or may not enforce; assume it does. A priv-app that asks for an unlisted privileged permission makes system_server abort and the phone sits on the boot logo. Run `check_privapp.py` / `check_privapp_offline.py` before every priv-app. A boot hang has no adb: recovery is Download mode (or TWRP once installed). |
| Magisk module approach, root daemon (ROM Tuner idea) | Reuse the approach only | MediaTek PPM/GPU/power-HAL nodes, codec XML and the compass shim are irrelevant on Exynos. |
| Samsung-only pieces (One UI, Samsung Pay, Secure Folder, Dual Messenger, Knox) | Lost | Say so to the user before the unlock. Dual Messenger user 95 and the Secure Folder data are in `userdata` and are wiped. |

## 4. Flashing route (nothing here has been run)
Samsung has no fastboot. Download mode is Vol Down + Vol Up held while connecting USB (model dependent, UNVERIFIED for this unit).
1. **Unlock bootloader** (user decision): Developer options > OEM unlocking. Today `sys.oem_unlock_allowed=0` (the toggle is off), and `ro.oem_unlock_supported=1`. On some firmware the toggle appears only after the phone has been online about 7 days (VaultKeeper; the vendor manifest has `vaultkeeper_manifest.xml`). Then Download mode, long press Vol Up to confirm. **Wipes `userdata`, trips Knox permanently** (`ro.boot.warranty_bit` is 0 today).
2. **Flash tool on the Mac:** Heimdall is **not installed** (`which heimdall` empty). Odin is Windows only. Options, in the order to try: Heimdall (brew), JOdin3 (a Java front end that drives Heimdall), Odin in a Windows PC or VM. Heimdall is known to fail on newer Samsung protocols (UNVERIFIED for this unit): test with a read-only command (`heimdall print-pit` needs the phone in Download mode, which means a reboot, so it needs the user's OK) before the unlock day.
3. **What gets flashed** (AP tar, vbmeta first): `vbmeta` flashed as a **disabled** image (`avbtool make_vbmeta_image --flags 2 --padding_size 4096`, UNVERIFIED for AVB 1.1 here), a recovery (TWRP for the M307F, RELAYED), `boot` (stock or Magisk patched) and the GSI `system`. `vendor` and `product` stay stock Samsung unless a fix needs them. `recovery` is the only recovery slot on an A-only device, so flashing TWRP replaces Samsung's recovery: keep its image.
4. After the GSI: format `userdata` (encryption keys differ), `cache`. Same wipe discipline as the tablet's CLAUDE.md.
5. Boot problems: Download mode (always reachable if the bootloader is intact) and, once TWRP is there, TWRP with adb. Pull `/sys/fs/pstore/console-ramoops` and `/cache/bootdiag` as on the tablet.

## 5. Backup and recovery plan (before step 4.1)
User side (cannot be done by an agent):
- Photos and files: internal storage contains personal data. Copy to the Mac; the 64 GB SD card is not touched by the unlock but make a copy of anything irreplaceable.
- Apps and settings: Samsung Smart Switch (Mac version) to the Mac, Google backup. WhatsApp/Authenticator/banking apps need their own export. Two-factor apps tied to the device must be moved first.
- Samsung account and Find My Mobile: remove the FRP-related locks decision (a Google account re-login is needed after the wipe).
Agent side (needs a root-capable boot after the unlock, i.e. TWRP; read-only until then):
- `dd` every partition to the Mac, in this order of importance: `efs`, `sec_efs`, `cpefs`, `persistent`, `radio`, `param`, `up_param`, `keystorage`, `keydata`, `keyrefuge`, `boot`, `recovery`, `dtbo`, `dtb`, `vbmeta`, `system`, `vendor`, `product`, `misc`, bootloader parts `bota0..3`. The `efs` set holds IMEI and radio calibration; losing it means a dead modem.
- Download the matching stock firmware for restore (model SM-M307F, CSC INS, `M307FXXS4CWC2` or newer) with a firmware downloader, verify it, keep the tar. This is the real undo button.
- Backups and dumps stay on the Mac, never in git (`.gitignore` covers `work/`).

## 6. Phases
| # | Phase | Needs | Gate |
|---|---|---|---|
| 0 | Read-only inspection, repo, plan | adb | **Done** (`docs/phase0`) |
| 1 | Desk work: GSI download and vintf comparison, Pixel APK sourcing, privapp check offline, Heimdall/Odin tooling check without the phone in Download mode, firmware download for restore. No device access beyond what Phase 0 did | nothing | none |
| 2 | **Backup** (user data, then partitions) and the Download-mode transport test | the user, a reboot of the phone (`adb reboot download`) | user's explicit OK |
| 3 | Unlock, vbmeta disabled, TWRP, plain A14 GSI, first boot diagnostics, radio/camera/audio/fingerprint triage | user's explicit OK to wipe, trip Knox, void warranty | **explicit, written** |
| 4 | Pixel Launcher + Wallpapers & style + fonts + GApps, privapp allowlists | stable phase 3 | none |
| 5 | Optional: phone SystemUI/Settings from a Pixel phone image, Material You theming, boot animation | stable phase 4 | none |
| 6 | Optional newer GSI (A15, then later) and the same kernel patch class as the tablet | stable phase 4 | none |
| 7 | Reproducible build and docs (as `tb-x606v-android16-port` does with `build_image.py`) | any | none |

Done criteria for phase 3: Wi-Fi, mobile data on both SIMs, calls with audio, SMS, camera, fingerprint, speaker, Bluetooth, charging and a 24 hour battery check, or an explicit list of what is lost.

## 7. Risk register
| Risk | Impact | Mitigation |
|---|---|---|
| Unlock wipes `userdata`, trips Knox, voids warranty, kills Samsung Pay/Secure Folder | irreversible | user decision, full backup first |
| `efs`/IMEI lost or overwritten | no cellular, can be permanent | dump `efs`, `sec_efs`, `cpefs`, `persistent`, `radio` before flashing; never `format` them |
| Heimdall does not talk to this phone | no flashing route on the Mac | check early (phase 1/2), fall back to Odin on Windows |
| GSI boots but radio, IMS or camera is broken | phone unusable as a phone | A14 route known to boot (RELAYED); keep stock firmware tar; do not do this on a phone that is the only way to receive calls |
| vbmeta/dm-verity prevents boot | boot loop | vbmeta disabled at the same time as the first flash; Download mode stays reachable |
| Priv-app permission abort | boot logo forever | `check_privapp_offline.py` on every priv-app (see PIXEL.md "Boot hang rule") |
| Anti-rollback | cannot flash older firmware | only binary 4+ ("S4") firmware; check before any restore |
| `/system` 98% full on stock, GSI plus Pixel apps bigger | partition overflow | 4800 MiB is enough for GSI plus Pixel (the tablet needed 3.8 GiB); size check in phase 1 |
| PSI missing, lmkd path | RAM pressure behaviour | measure in phase 3 |
| Battery at 14% at inspection time | n/a | check charge before any reboot or flash |

## 8. What the agent needs from the user
1. Is this phone the daily driver? If yes, the plan stops after phase 1 until a spare is available or a backup is done.
2. Explicit OK, in writing, to reboot the phone into Download mode (phase 2 transport test) and later to unlock the bootloader (wipe, Knox, warranty).
3. A Windows machine or VM if Heimdall does not work on the Mac.
4. A copy of anything irreplaceable (photos, authenticator apps, banking) taken by the user.

## 9. Phase 1 findings (desk only; phone and tablet not touched)
Recovered from the Phase 1 agent's report (2026-11-06). The agent's own clone, `docs/phase1/` evidence dumps and `tools/probe/kprobe.c` were lost when its temp folder was torn down; only the conclusions below survive. Re-derive the evidence if a claim is relied on.

1. **GSI vs vendor 30.** A14 GSI (UQ1A.231205.015) ships VNDK v30 and SELinux mapping 30.0: no donor needed, named fallback (only generation with evidence on this phone, RELAYED from XDA). A17 GSI (DP11.261016.003) ships VNDK v31-v34 and mapping 31.0+ only, framework matrices 7+ (phone declares level 3). A17 needs a VNDK v30 APEX and mapping 30.0 from a donor (the A14 GSI works; its v30 APEX has the same public key as A17's own v31), the tablet's `Build.isBuildConsistent` patch, and the A16 audio stack (vendor audio is HIDL 5.0).
2. **Tablet patches.** All 23 (`check_patches.py`) apply to this exact A17 build, plus the netd `close_range` patch. A17 libhwui no longer uses `F_SEAL_FUTURE_WRITE` (disassembled), so no libhwui patch on A17. BPF: same netbpfload/netd.o patches; kernel 4.14 is a superset of the tablet's 4.9.
3. **New work the tablet does not cover.** A17 lmkd is PSI-only and this kernel has no PSI and no in-kernel LMK, so the tablet's lmkd shim does not carry over. The phone has no `/metadata` partition (A17 init expects it; idea: bind a `/cache` dir over it). Health/lights/vibrator AIDL shims need Samsung sysfs nodes. Telephony features carry over but Samsung IMS is lost, so a VoLTE-only SIM (e.g. Jio) would not get calls.
4. **Pixel layer.** The Pixel 9a (tegu) factory image of the same build exists (`dl.google.com/.../tegu_beta-dp11.261016.003-factory-50ec463b.zip`, 4.0 GiB); SystemUIGoogle, SettingsGoogle, NexusLauncherRelease etc. are present. Not downloaded now (the ~15 GB of GSI and factory downloads were deleted).
5. **Restore and flash.** Stock firmware M307FXXS4CWC2 (INS, Android 11) on samfw/SamMobile behind a captcha (samloader needs the IMEI). Official TWRP m30s 3.7.0_9-0 at dl.twrp.me (flash vbmeta-disabled first). Heimdall is not installed and is known to fail on newer Samsung bootloaders (one operation per Download-mode session; a fork has a USB-reset fix; Odin on Windows is the safe fallback).
6. **Prepared, not run.** A static arm64 kernel probe (seals, clone3, close_range, BPF, PSI, memcg) pushes one file to `/data/local/tmp`, so it needs the user's OK. Source lost; rewrite if wanted.

Open decisions for the user: OK for phase 2a read-only probes (probe binary, `/vendor/etc/vintf/manifest`, media_codecs xml, sysfs nodes; no reboot, no setting change); who downloads the stock firmware tar; which carriers the two SIMs are on; later, OK for Download mode plus a Heimdall test.

## 10. Phase 2a results (read-only probes, 2026-11-06; details in `docs/phase2a/PHASE2A.md`)
Run with the user's yes (assumed from "yes"): one static arm64 probe pushed to `/data/local/tmp`, plus reads. No reboot, no setting change. VERIFIED on the phone:
1. Kernel 4.14.113 lacks `F_SEAL_FUTURE_WRITE`, `close_range`, `clone3`, `openat2`, `faccessat2`, `pidfd_*`, `userfaultfd`, `io_uring`, `rseq`, PSI. Binder protocol is 8. BPF cannot be tested as `shell` (SELinux denies even a trivial program); atomics are absent by kernel version.
2. **Corrects 9.3:** the kernel *does* have the in-kernel low-memory killer (`/sys/module/lowmemorykiller`) and memcg v1 `memory.pressure_level`; stock lmkd is Samsung SLMK (`ro.slmk.*`). The tablet's `lmkd_inkernel.c` approach carries over; PSI-only lmkd is still the problem.
3. **Corrects 9.3 (health/lights/vibrator):** lights is already AIDL in the vendor (no shim). Health is HIDL 2.1 with a real gauge (`sm5713-fuelgauge`), vibrator is HIDL 1.3 on `timed_output/vibrator/enable` (root-only), so A17 needs an AIDL health shim and a vibrator shim that forwards to the vendor HAL.
4. `/metadata`: no partition (`by-name`), a directory exists on the rootfs. Stand-in needed for A17, probably not for A14 (UNVERIFIED).
5. The MP2 trap exists as a `Type` of `OMX.SEC.mp3.dec` in `media_codecs_sec_primary.xml`; VP9 decode is an Exynos codec here (no tablet-style removal planned).
6. Filesystems: no erofs/overlayfs/incremental-fs; sdcardfs + fuse present.
Build plan and the OKs needed: `docs/PHASE2B-3-DRAFT.md`.

## 11. Stock firmware and TWRP image (2026-11-06)
- **Restore firmware:** `M307FXXS4CWC2` is archived on samfw (premium only). Any **INS build with binary 4 or higher** restores the phone (anti-rollback only blocks older binaries); the user downloads the latest free INS build (samfw, or Frija/samloader with the IMEI). Before any Download mode or unlock, check the tar's bootloader binary number ("S" digit in the AP file name, `XXS4` = 4 or higher). A newer build may carry a different `vendor`/`product` image than the one inspected here, so Phases 0 to 2a describe **this phone's installed CWC2 firmware only**; do not extend those findings to the new tar. Re-read the phone itself for any build decision. Firmware is needed only before Download mode or unlock (supersedes the exact-CWC2 wording in sections 5 and 9.5).
- **TWRP image (staged, not flashed):** `~/Aistuff/m30s-pixel-port/twrp-3.7.0_9-0-m30s.img` (repo root, 41.7 MB, SHA-256 `d67a081233cc98578f9fd3d5c0a761ada53b6dc516fe064b10cd6e9261a41b93`, Android boot image, kernel at 0x10008000, `buildvariant=eng`). Not tracked: `.gitignore` already has `*.img` (`git status` clean). The Download-mode/unlock gate still stands; flashing TWRP replaces Samsung's `recovery`, so keep the stock `recovery.img` from the firmware tar.

## 12. Stock images checked (2026-11-06; `docs/phase3prep/STOCK-IMAGES.md`)
All seven images, sizes and SHA-256 are listed there. The user's `system`, `vendor`, `product` are **the same firmware as the phone (M307FXXS4CWC2)**: build props equal, vendor `manifest.xml` byte-identical. Findings that change the plan: `boot.img` has **no ramdisk and an empty cmdline**; the kernel has no built-in `root=`; `root=/dev/dm-0` lives only in the vbmeta cmdline descriptor (flags 1), which a disabled vbmeta may drop, so the vbmeta-disabled step in section 4 needs a root-device fix (boot-image cmdline) tested first; Magisk on a ramdisk-less system-as-root boot image needs its own route.
