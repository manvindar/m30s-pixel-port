# One UI port to the Galaxy M30s (SM-M307F): desk feasibility study

Written 2026-11-07 by temp `worker-oneui-research`. Desk research only: web sources and the existing `m30s-pixel-port` docs. The phone was not touched, no firmware was downloaded.
Labels: **SOURCE** = read on the cited page (web search result or fetched page, 2026-11-07); **PORT-DOCS** = from `~/Aistuff/m30s-pixel-port/docs`; **INFERENCE** / **UNVERIFIED** = my reasoning or not checked. Many XDA and GitHub pages returned 403 to direct fetch; XDA content was read through a text proxy (`r.jina.ai`) or search summaries, so details below are as good as that, and the XDA threads should be opened by a human before relying on a bug list.

## 0. Verdict

**GO for a staged port of One UI 8.5 (Android 16). NO-GO for One UI 9.0 (Android 17) as a first target.** Community ports of One UI 6.1 (on the M30s itself) and One UI 8.5 (on the A50/A51, the same SoC family) already exist, so this is not a research question about whether it can boot; it is an engineering question about doing it reproducibly on our kernel, with our tooling. The big wins over the current Pixel/A17 GSI: VoLTE/IMS, camera and fingerprint can work because the Samsung vendor stays and the Samsung framework talks to it. The big costs: a custom 4.14 kernel that lies about its version, SELinux permissive, a weak SoC running a flagship UI, Knox gone, and a 3-5 week effort. Details and numbers below.

## 1. What "latest One UI" is today (2026-11-07)

| One UI | Android | Release | SOURCE |
|---|---|---|---|
| 7.0 | 15 | 2025-01-22 | Wikipedia One UI |
| 8.0 | 16 | 2025-09-15 | Wikipedia One UI |
| 8.5 | 16 (QPR2) | 2026-02-25 (S26); rolled to older devices from 2026-05 (S25 on 05-06; A26/A17 late May) | Wikipedia, Sammy Fans |
| 9.0 | 17 | stable 2026-07-22 (Z Fold 8/Flip 8); S26 on 09-16; A36/A56/A54/A26/A35/A17 in Oct to Nov 2026 | Wikipedia, Sammy Fans, SamMobile, Android Central |
| 9.5 | 17 QPR2 | beta being made (2026-11-04 report), nothing official | Sammy Fans |

"Latest One UI" = **9.0 on Android 17**. A 9.5 beta exists for S26 only.

### Official firmware for M30s and Exynos 9611 siblings: none beyond old versions
All of the following are the final official major versions (end of support):

| Device | SoC | Last official | SOURCE |
|---|---|---|---|
| **M30s SM-M307F** | Exynos 9611 | Android 11 / One UI 3.x; no Android 12 planned. Newest builds seen: M307FXXS4CWC2 (2023-04-24, the user's), M307FNXXU4CWE3 (2023-05-30, FN variant) | SamFrew, SamMobile, Samsung Members |
| **A51 SM-A515F** | 9611 | Android 13 / One UI 5.1 (A515FXXU6HWC7, Feb 2023 patch, Europe 2023-04-04). Later builds only security patches (A515FXXU8HWK1, Nov 2023). The newest official software on this SoC | SamMobile, SamFrew |
| **M31 SM-M315F** | 9611 | Android 12 / One UI 4.1 (M315FXXU2CVCE, 2022); newest listed M315FXXU4CXJ6 (still A12 by the U4 revision, UNVERIFIED). No A13 evidence found | SamMobile, GetDroidTips |
| F41, M21, M21s, M31s (9611) | 9611 | not checked individually; same family, max A12 or A13 (UNVERIFIED) | |

Wikipedia: A51 "capped at One UI 5.1, Unsupported"; M31 capped at One UI Core 4.1.
**So no official firmware at One UI 6 or newer exists for any Exynos 9611 device.** Any One UI >= 6 on the M30s needs a donor from a different SoC (a "port"). Samsung's update policy (3-4 major versions for 2019/2020 mid-range) is why.

## 2. Donor candidates, ranked

A port takes the donor's `system`, `product`, `system_ext` (and some `odm` bits) and keeps the M30s `vendor`, `boot` kernel, modem. Donor choice therefore trades "newest" against "closest hardware".

| Rank | Donor | One UI | Why / evidence | Caveat |
|---|---|---|---|---|
| 1 | **Galaxy S25 FE (SM-S731B, Exynos 2400e)** | 8.5 (A16) | The base of the working A51 One UI 8.5 ports (Hydrate ROM Sakura; the A50 port is derived from it). Proven to boot on a 9611 vendor with a custom 4.14 kernel. SOURCE | Flagship framework, heavy; Galaxy AI limited by hardware; a 9 update may exist (UNVERIFIED) |
| 2 | **Galaxy A26 5G / A35 / A54 (Exynos 1380; A26 LATAM is 1280)** | 8.5 and 9.0 out (A26 8.5: A266MUBU9CZEA; 9.0 EU A266BXXUCDZJ5, Oct 2026 patch) | Newest official firmware on a mid-range Exynos with a **public**, free update; OTA about 3 GB. Closest in class to the M30s. Only choice for One UI 9. SOURCE (Sammy Fans, Nokiapoweruser) | No prior 9611 port found on these bases; A26/A54 have newer HAL stack (camera, display) that differs from S25 FE port path (INFERENCE) |
| 3 | **Galaxy S23 FE (Exynos 2200), S24-family** | 6.1 / 7.0 / 8.0 | X-ROM (A51), WROM (M31: S23 FE One UI 6.1.1 and S24 One UI 7) prove them. SOURCE | One UI 8.0 is the last before the bootloader-unlock removal; irrelevant here since our phone is already unlocked |
| 4 | **Galaxy M34 / A34 (Exynos 1280 / MTK)** | 6.1 (A14) | Donor of Incredible OS V3 on the **M30s itself**: One UI 6.1, stable, VoLTE works, only ultrawide bug. SOURCE | Not "latest"; safest fallback |
| 5 | **A51 SM-A515F** | 5.1 (A13) | Same SoC, official, no port needed, Incredible OS V2 (One UI 5.1) on M30s is built from it. SOURCE | Not newer than what exists |

Recommended: **rank 1 (S25 FE, One UI 8.5)** because the whole recipe is proven by others on a sibling; **rank 2 (A26/A35, One UI 9)** only after 8.5 boots.

### Firmware access (nothing downloaded)
- Samsung FOTA servers via `samloader` / Frija / SamFOTA-style downloaders, or SamFw / SamMobile mirrors. The user already used a SamFOTA zip for M307F (4185.6 MB: AP, BL, CP, CSC, HOME_CSC). PORT-DOCS.
- samfw.com returns 403 to this agent and "premium only" for some old builds (PORT-DOCS). `samloader` needs model + CSC + a valid IMEI of that donor model (UNVERIFIED for current servers); a user with a browser or a Windows box should do the download or run `samloader` themselves.
- Sizes: One UI 8.5/9 OTA packages for the A26/A17 are about 3 GB (SOURCE). A **full** firmware for S25 FE is not stated anywhere I found; a flagship AP tar is typically 8-12 GB (UNVERIFIED) plus 2-4 GB for BL/CP/CSC. Budget about 15 GB of free disk for one donor (the Mac had ~4.6 GB free earlier: PORT-DOCS section 19, so disk is a gate).
- Legality: downloading from Samsung's update servers is how the official updaters work. Ports shared on XDA are derivative works; several authors forbid re-upload. We would build locally from the user's own downloads and not redistribute the images.

### Partition layout vs the M30s
- **M30s (VERIFIED, PORT-DOCS phase0):** A-only, no `super`, no dynamic partitions. `system` 4800 MiB (sda25), `vendor` 600 MiB (sda26), `product` 296 MiB (sda27), `boot` (sda14), `recovery` (sda15), `vbmeta` (sda23), `dtb` (sda12), `dtbo` (sda13), `cache` (sda28), `omr` (sda29), `userdata` (sda32). **No `system_ext`, `odm` or `vendor_dlkm` partitions.**
- **Modern One UI donors:** dynamic partitions inside `super` (S25 FE and A26 are A/B-less virtual A/B or similar, UNVERIFIED), with EROFS `system`, `system_ext`, `product`, `odm`, `vendor`, `vendor_dlkm`, plus `optics` / `prism` (CSC) images. For One UI 8.x donors these EROFS images total roughly 5-7 GB (INFERENCE from the A50 port's 4.56 GB ZIP after debloat and stock partitions only).
- **Fit problem:** `system_ext` and the donor's `odm` bits must be merged into `system`/`product`/`vendor` (the existing ports do exactly that: the A50 port flashes only System, Vendor and Product and says "stock partition layout mandatory; repartitioning causes bootloop", SOURCE). With 4800+296 MiB for `system`+`product` and 4.56 GB for the finished A50 One UI 8.5 ZIP, it fits **only with heavy debloat** (INFERENCE; the A50's stock layout is the same 9610/9611-family layout and it works).
- **Filesystem:** the kernel has no EROFS driver (PORT-DOCS phase2a: no erofs, overlayfs, incremental-fs). Ports therefore repack the donor into **ext4** (X-ROM replies: "EROFS doesn't allow rw"; the A50 port needs `/data` as ext4, F2FS data bootloops). Our tools/img can already build 4800 MiB ext4 images with debugfs/`mke2fs -d` (PORT-DOCS).
- **The DragonFox wiki warns that AOSP ROMs use erofs + force-encryption vendors and "do not use TWRP"**; that is for their AOSP builds, not the One UI port route (TWRP 3.7.1_12 is what the A50 port requires). Our TWRP 3.7.0_9-0 flow is already proven (task).

## 3. Real blockers

### 3.1 Kernel: the main blocker, and it is solved only by lying
- **Official floor:** the supported kernels for **Android 16 upgrading devices start at android11-5.4** (4.14 and 4.19 are not on the list). Source: AOSP list quoted by Mishaal Rahman; kernel EOL dates 4.14 = 2024-01, 4.19 = 2024-12 (Google LPC 2024 slide). So One UI 8.5 on 4.14 is outside Google's matrix and nobody is obliged to keep it working.
- **What the working One UI 8.5 ports do (SOURCE, A50 v3 thread, 2026-07-01):** Mint kernel 4.14.194 (FreshROMs) with a **patched version string that reports 5.10.250** because "Android 16 refuses to start its network stack on kernels reporting less than 4.19"; **BPF LPM-trie map iteration/delete operations backported from 5.10** (missing ones caused boot failures); `netd` start, BPF init and network stats patched; KernelSU built in; SELinux permissive; ZRAM enabled early to survive first-boot dexopt; ADB drops intermittently. Hydrate ROM Sakura uses the Grass kernel (`Roynas-Android-Playground/kernel_samsung_universal9611`, archived) derived from the One UI 6.1 source. Whether the Grass source matches what is shipped is disputed on XDA (unverified, GPL complaint).
- **What we already know on this phone (PORT-DOCS):** kernel 4.14.113 lacks `F_SEAL_FUTURE_WRITE`, `close_range`, `clone3`, `openat2`, `faccessat2`, `pidfd_*`, `userfaultfd` (our patched kernel added userfaultfd), `io_uring`, `rseq`, PSI (our `boot-a17-psi.img` added PSI). We already boot an Android 17 GSI on this kernel with netd/BPF patches (the XADD rewrite, `close_range` fix); the same class of fixes applies to Samsung's Android 16 framework, because Samsung ships the same AOSP `netd`/`netbpfload`/Tethering/Connectivity module code.
- **Size of the kernel job (INFERENCE):** (1) uname version spoof, or per-feature fixes at the call sites; (2) backport the BPF map ops the 5.10 netd/bpf programs use (the A50 author lists LPM trie iteration/deletion); (3) keep Samsung drivers (sec_*, `uh`/RKP hooks, defex) built and harmless; (4) keep our PSI/userfaultfd/perf options. **Kernel changes go to Pam (`m30s-kernel`) per the standing rule**; Pam's a17 baseline is the 4.14.113 Samsung source, whereas the ports use Mint 4.14.194 from `FreshROMs/android_kernel_samsung_exynos9610_mint` and `sundrams-playground/kernel_samsung_m307f` ("Mint kernel for M30s and A50", Clang 13/LTO, WireGuard, supports M30s officially, SOURCE). Decision for Pam: rebase on Mint's M30s tree, or cherry-pick its fixes into our 4.14.113 tree. Mint's 4.14.194 includes more upstream stable fixes; our tree has the A17 patches already.
- **Other kernel-ish traps from the ports:** NFC "waits for the kernel" on One UI 8 (X-ROM thread: NFC is the only bug of One UI 7 and the developers say the kernel delays One UI 8 support, SOURCE); a KernelSU manager version mismatch on A50 (irrelevant if we use Magisk or none).

### 3.2 Vendor/framework interface (Android 11 vendor under a 16 framework)
- **Vendor is frozen at Android 11 (VNDK 30, VINTF `target-level=3`, HIDL-only HALs; PORT-DOCS).** Android 16's own framework matrix does not cover this; the GSI route and the One UI route both bypass VINTF checks. The One UI ports do this by **editing `manifest.xml` and `compatibility_matrix.xml`, patching Samsung services that expect newer hardware, and editing `floating_feature.xml` / CSC features** (XDA "OneUI Port Guide", SOURCE via proxy).
- **Samsung-specific pieces and what breaks (INFERENCE unless a port report is cited):**
  - *Samsung HALs* (`vendor.samsung.hardware.*`: radio/IMS, biometrics, camera, display, sehal-style vendor services, `power`, `thermal`): the Android 11 vendor exposes old HIDL versions. One UI's framework still ships the matching client code for old versions in most cases; the ports show this works for camera, VoLTE and fingerprint on 9611 siblings. Anything that moved to AIDL in newer Samsung services (new `vendor.samsung.hardware.*` AIDL, SemMdnie, new thermal/power AIDL) falls back or is missing. The A50 author had to restore camera sensor HAL, ISP firmware, TFA9872 amp firmware: i.e. vendor-side files from the device's own vendor, not the donor.
  - *Camera:* works on A51 (X-ROM "fully functional", Hydrate); A50 beta had it broken then fixed in V2/V3. M30s has different sensors from A51 (M30s: 48 MP main; UNVERIFIED which sensor modules), so the Samsung Camera app needs the M30s sensor setfiles from the M30s vendor, and One UI's camera app will expect hardware keys that `floating_feature` must declare. Incredible OS V3 (One UI 6.1, M30s): camera mostly OK, ultrawide mode broken (SOURCE). GCam impossible (Camera2 level 3 missing, DragonFox SOURCE).
  - *RIL / modem / IMS:* the CP (Shannon) and `libsec-ril` stay from the stock vendor/modem; **VoLTE works in Incredible OS V1-V3 on M30s (India: Jio, BSNL reported)** and on the A50 One UI 8.5 port (calls + VoLTE listed working). A51 X-ROM V16 lists VoLTE/VoWiFi fixed but users still report breakage (SOURCE, unfixed on some CSCs). This is the single biggest functional advantage over the GSI route, where Samsung IMS is lost and carrier voice compatibility is at risk (PORT-DOCS section 14).
  - *Wi-Fi/Bluetooth:* work in the reports. Bluetooth calls reported broken by some X-ROM users even with A2DP offload off. Hotspot client connectivity incomplete on A50 One UI 8.5 (server starts).
  - *Audio:* speaker amp firmware is vendor-side; A50 beta had a silent loudspeaker until the TFA9872 firmware was restored. Dolby/Atmos from One UI's own `SecAudio` stack is untested; our GSI Dolby attempt failed because the vendor lacked IDms (PORT-DOCS), but One UI ships its own audio effects.
  - *Display:* mdnie/`SemMdnie` is vendor-kernel driven; the A50 needed a corrected cutout overlay (S25 FE punch hole showed). M30s has a waterdrop notch (UNVERIFIED), so a custom overlay is required.
  - *Fingerprint:* sensor type not checked here (PORT-DOCS: vendor exposes HIDL IBiometricsFingerprint 2.1, handled with a Java shim on the GSI). X-ROM and Hydrate list FOD issues; A50 fingerprint working after fixes. Samsung's biometric stack in One UI 8.5 speaks to the vendor HIDL 2.1; risk medium.
  - *Knox / RKP / KDP / vaultkeeper / Defex:* the bootloader is unlocked and Knox tripped (PORT-DOCS). The `uh`/`uhcfg` partitions (H-Arx hypervisor) are still present. The ports run SELinux permissive and ship Knox patch modules (X-ROM: "Knox Patch with Secure Folder"; Incredible V2: Secure Folder crashes, KnoxPatch suggested). Samsung Pay/Wallet, Secure Folder, Samsung Health sensors check, SmartThings/"Find my" attestation do not work or need patches; Play Integrity fails with an unlocked bootloader. Vaultkeeper/`sboot` is untouched because we do not flash BL.
  - *Security:* SELinux permissive (user-accepted on the tablet; on the phone the A17 build already runs permissive, PORT-DOCS). Verified boot off (vbmeta disabled flashed first).
- **Bootloader and anti-rollback:** the M30s stays on binary 4 (`XXS4`); we never flash BL/AP from a One UI 8/9 donor. One UI 8 firmware removed the OEM-unlock toggle on newer devices (SammyGuru, SamMobile, Android Authority, July 2025), but **our phone is already unlocked and the donor's bootloader is not used**, so this is irrelevant to the plan and a reason not to flash donor BL parts. Rollback stays the stock firmware (M307FXXS4CWC2 tar, PORT-DOCS) and the v0.2-img Pixel image.
- **Disk/RAM/SoC:** Exynos 9611 (4x A73 + 4x A53, Mali-G72 MP3), 5.5 GiB RAM on this unit. XDA user "atrocious performance" with severe throttling after ~5 min on a One UI 7 port; WROM author says 9611 is weak for Galaxy AI; some report lag on first boots (SOURCE). Battery drain also reported for One UI 9 itself on several models (Sammy Fans). Expect a worse daily experience than the lean Pixel GSI. (INFERENCE: smaller One UI 6.1 builds are the stable ones.)

### 3.3 Known community ports for Exynos 9611 devices
| Port | Device | One UI / Android | Donor | State (SOURCE) |
|---|---|---|---|---|
| Incredible OS V1 | **M30s** | 4.1.1 / A12 | A51 firmware | stable; fingerprint lockscreen dim bug |
| Incredible OS V2 | M30s | 5.1 / A13 | A51 | stable; Secure Folder crashes |
| **Incredible OS V3** | **M30s** | **6.1 / A14** | **M34** (A34 in some posts) | stable, pre-rooted KSU-Next, VoLTE ok (Jio/BSNL), only ultrawide bug; Mint kernel for M30s; wipe system/vendor/product then flash zip |
| Incredible OS V4 | M30s | 7 / A15 | built on V3 | **experimental; thread closed ("do not download")**; author says his unit wipes unofficial images |
| X-ROM | A51 | 7 / A15 | S23 FE (+S25 FE update, A515FXXU8HWK1 vendor) | camera/VoLTE/VoWiFi mostly working, NFC only listed bug; Grass kernel, KSU-Next; A51 only |
| WROM | M31 (A51/M21/F41) | 6.1.1 and 7 | S23 FE / S24 | NFC bug, AI laggy |
| EDROM | M31 | 6.1 / A14 | A54/S21 FE/M34 | closed |
| Hydrate ROM Sakura | A51 | **8.5 / A16** | S25 FE | thread **closed**; FOD, lag, AI limited; A51 and other 9611 only |
| A50 port | A50 (9610) | **8.5 / A16**, v3 FINAL 2026-07-01 | from A51 8.5 base | camera, VoLTE, fingerprint, speaker, BT working; Mint 4.14.194 with spoofed 5.10 version string; 4.56 GB zip |
| Project Sakura (AOSP) | A51 | 16.3 | AOSP | IMS broken |
| LineageOS 21 (AOSP) | 9611 family | 14 | AOSP | IMS broken |

No One UI 9 (Android 17) port for 9611 was found (UNVERIFIED: absence from search, not proof).
Honest status: the One UI 8.5 ports are **closed and 4-6 months old forks of each other, produced by a handful of developers**, and the A50 v3 post is the best-documented one. I could not read the source repos (GitHub 403).

## 4. Go / no-go and staged plan

**GO: One UI 8.5 (Android 16) as target, S25 FE donor, our own CI-built image and Pam's kernel. NO-GO now: One UI 9.0; revisit after stage 5.** Keep the Pixel A17 image as the fallback and as the default CI target.

Reasons for GO: working One UI 6.1 on this exact phone; working One UI 8.5 (with VoLTE, camera, fingerprint, speaker) on the A50 sibling whose kernel is the same Mint tree that supports the M30s; our A17 work already solved the same kernel/netd/BPF class. Reasons for caution: dependence on closed/unverified community work, weak SoC, Knox/Pay loss, a 4.56 GB debloated image that must fit 4800+296 MiB.

### Stages (reuse: `tools/img` ext4 builder, `m30s-kernel` (Pam), CI `build-image.yml`)
| # | Stage | Needs | Est. | Gate |
|---|---|---|---|---|
| 0 | This study | none | done | |
| 1 | **Acquire:** S25 FE One UI 8.5 full firmware (and optionally M30s `FOTA` modem files); verify AP/CSC; keep out of git. Tool check: `lpunpack`, `fsck.erofs` (installed), `lz4`, `mke2fs -d`, `debugfs` | user (download or run `samloader` with the donor's IMEI), ~15 GB disk | 1 day + download | disk, IMEI |
| 2 | **Desk fit study (no phone):** unpack donor, size `system`+`system_ext`+`product`+`odm`; debloat plan to fit 4800 MiB system + 296 MiB product (or merge `product` into `system`); VINTF diff donor matrix vs `vendor-vintf-manifest.xml` (PORT-DOCS phase0); list Samsung services that call HIDL/AIDL interfaces missing in the vendor; `floating_feature` diff. Output: a patch list | agent | 3-5 days | image fits? |
| 3 | **Kernel:** Pam builds `a17-oneui` prerelease: version-string handling, BPF LPM-trie iterate/delete backports, keep PSI/userfaultfd/perf; decide Mint M30s tree vs ours; `--prerelease`, not `Latest` | Pam (m30s-kernel) | 3-7 days | Pam's gate |
| 4 | **Image build in CI:** extend `build_image.py` with a `--oneui` donor profile (ext4 repack, manifest edits, camera/audio/sensor files from the M30s vendor, overlay for the notch, permissive init, `/metadata` stand-in) | agent | 1 week | image builds |
| 5 | **First flash (user OK):** TWRP, `/data` ext4 (the A50 post says F2FS bootloops; check what the M30s userdata is), wipe system/vendor-keep (we keep stock vendor or only the MP2-free codec edit), flash system/product/boot via the proven TWRP + Heimdall flow, boot diag from `/cache/bootdiag` | worker-m30s-lead2 / user | 2-3 days to boot + 1-2 weeks to triage | **explicit user OK, wipes data** |
| 6 | **Triage list (in order):** boot, touch/display, Wi-Fi/BT, mobile data + VoLTE on SIM 2 (Vi), audio/speaker, camera (rear/front/ultrawide), fingerprint, sensors, charging, thermal/battery 24 h | | | |
| 7 | **Optional One UI 9.0:** donor A26/A35 or S25 FE 9.0 on the proven stack | | 2-3 weeks | only if 8.5 is solid |

Total: **3-5 weeks of agent time to a daily-usable One UI 8.5; 3-4 days if the user supplies the existing A50/A51 build as a donor for the vendor-side recipe** (UNVERIFIED, needs a human to read the closed threads). Resource: build disk 40+ GB on a CI runner (GitHub-hosted runners have about 14 GB free by default, so use `jlumbroso/free-disk-space` or a self-hosted step; INFERENCE).

### What this needs from the user
1. Confirm the target: One UI 8.5 on Android 16 (recommended), not 9.0, and that **losing the Pixel launcher look is acceptable** (One UI is a different UI).
2. Ack the costs: Knox is tripped, Samsung Pay/Wallet, Secure Folder, Play Integrity strong attest do not work; performance on 9611 may be worse than the Pixel GSI.
3. Download the S25 FE full firmware (or approve `samloader` with a Samsung-account/IMEI step) and about 15-40 GB of free disk on the Mac/CI.
4. Permission, when stage 5 comes, to flash and wipe `userdata`; the fallback is `v0.2-img` and the stock firmware tar.
5. Decide who owns it: worker-m30s-lead2 (phone) and Pam (kernel) as per standing rules.

## 5. Open questions (could not verify from here)
- Open XDA threads directly (403 to this agent): the A50 One UI 8.5 thread and the Hydrate thread for the real bug lists, and the "OneUI Port Guide".
- Which donor ZIP(s) the One UI 8.5 ports actually used for `odm` and `product` and how they fit each stock layout; the A50 thread says the stock A50 layout is mandatory.
- Whether the M30s userdata is ext4 or f2fs, and encryption (FBE) state with a disabled vbmeta.
- GitHub kernel trees (`FreshROMs/android_kernel_samsung_exynos9610_mint`, `sundrams-playground/kernel_samsung_m307f`, `Roynas-Android-Playground/kernel_samsung_universal9611`, `Exynos9611Development/android_kernel_samsung_universal9611`) could not be read: git history, config and the BPF backport commits.
- S25 FE and A26 One UI 9 firmware version strings and sizes.

## 6. Sources
- One UI timeline: https://en.wikipedia.org/wiki/One_UI
- One UI 8.5 / 9 rollout: https://www.sammyfans.com/2026/05/25/samsung-galaxy-a26-users-start-getting-one-ui-8-5-update/ , https://www.sammyfans.com/2026/11/04/one-ui-9-update-now-rolling-out-for-galaxy-a54-a26-and-a27-in-the-us/ , https://www.sammobile.com/news/galaxy-a36-gets-stable-one-ui-9-0-android-17-update/ , https://news.samsung.com/global/samsung-launches-one-ui-9-beta-for-galaxy-s26-series-users
- M30s: https://samfrew.com/firmware/model/SM-M307F/upload/Desc/0/10 , https://r2.community.samsung.com/t5/Galaxy-M/M30s-android-updates-12-version/td-p/19961730
- A51 last update: https://www.sammobile.com/news/last-major-one-ui-update-for-galaxy-a51-lte-is-live-in-europe/ ; M31: https://www.sammobile.com/news/galaxy-m31-android-12-update-released/
- Incredible OS V3 (M30s, One UI 6.1): https://xdaforums.com/t/rom-14-one-ui-6-1-stable-incredible-os-v3-for-galaxy-m30s.4728388/ ; V4 (One UI 7, closed): https://xdaforums.com/t/rom-one-ui-7-x-experimental-one-ui-7-for-m30s-m307f.4760365/
- A51 X-ROM (One UI 7): https://xdaforums.com/t/rom-15-oneui-7-0-x-rom-s23-fe-v16-1-galaxy-a51-07-09-2025.4658301/
- A50 One UI 8.5: https://xdaforums.com/t/rom-android-16-one-ui-8-5-port-for-galaxy-a50-beta-v2.4793557/
- Hydrate ROM Sakura (A51 One UI 8.5): https://xdaforums.com/t/hydrate-rom-sakura-one-ui-8-5-for-samsung-galaxy-a51-galaxy-ai-supported-s26-based-dirty-flash-supported.4790354/
- OneUI Port Guide: https://xdaforums.com/t/oneui-port-guide.4778257/
- DragonFox 9611 wiki: https://github.com/DragonFox-Project/wiki/blob/main/exynos9611/install.md
- Android 16 kernels: https://x.com/MishaalRahman/status/1887538693780742594 ; https://source.android.com/docs/core/architecture/kernel/android-common ; LPC 2024 slides https://lpc.events/event/18/contributions/1703/attachments/1391/2998/LPC%202024%20-%20Android%20Device%20Longevity.pdf
- Bootloader unlock removal in One UI 8: https://www.sammobile.com/news/say-goodbye-to-your-custom-roms-as-one-ui-8-kills-bootloader-unlock/ , https://www.androidauthority.com/samsung-bootloader-unlocking-disabled-one-ui-8-3581366/
- Mint kernel (M30s/A50): https://github.com/sundrams-playground/kernel_samsung_m307f
- Internal: `~/Aistuff/m30s-pixel-port/docs/{PLAN.md,phase0,phase2a,phase3prep}`, `hive/board.md` "M30s".
