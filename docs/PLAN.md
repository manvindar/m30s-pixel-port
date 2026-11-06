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
