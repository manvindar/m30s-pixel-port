# A17 base image for the M30s (built offline 2026-11-07; Pixel layer, kernel and zram added the same day, see the sections at the end)

Builder: `tools/img/build_a17.py` (generated from the tablet's `build_image17.py` by `tools/img/make_build_a17.py`, 26 asserted text substitutions) + `tools/img/build_vendor_a17.py`. The tablet repo's `tools/` dir is the patch library (`A17_TOOLS`); because its health `build.sh` writes into `tools/health/out`, a copy lives in `work/a17/tools` (the repo is read-only for the agent sandbox).

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

## Boot findings (first booted on the phone 2026-11-07; the image above predates these, rebuild with the current builders)
Rebuild: `python3 tools/img/make_a14fs.py work/a14/system-a14.img work/a17/fs` (needs the NDK), then `make_build_a17.py` > `build_a17.py` with `--a14fs work/a17/fs`; `build_vendor_a17.py` as before.
- **No first stage.** A17's `/system/bin/init` is second-stage only (aborts without an argument) and the phone's boot.img has no ramdisk. `/init` is a symlink to `/system/a14fs/launcher` (`tools/debug/fslaunch.c`, static), which mounts devtmpfs, sends stderr to kmsg and runs Android 14's init through Android 14's `linker64` with `LD_LIBRARY_PATH=/system/a14fs/lib64` (35-library closure). That init mounts everything and ends with `execv /system/bin/init selinux_setup` = A17's init.
- **The stock kernel is `CONFIG_ALWAYS_ENFORCE`** (security/selinux/Makefile, user build + SEC_BUILD_OPTION_SELINUX_ENFORCE): `setenforce(0)` is forced to 1 and `(typepermissive ...)` does nothing, so patching init to boot permissive (as on the tablet) has no effect. Substitute: `make_allowall_cil.py` appends an allow-all block (attribute over all types, every class and permission, ioctl ranges) to `plat_sepolicy.cil`; init compiles it with `secilc -N`. A kernel with permissive support would make this unnecessary (separate gate).
- **No BPF JIT** (`CONFIG_BPF_JIT` unset): netbpfload fails every program with "Kernel eBPF JIT failure"; `patch_netbpfload_jit.py` NOPs the check (programs run in the interpreter).
- **EGL**: `ro.hardware.egl=mali` in build.prop, else surfaceflinger aborts ("couldn't find an OpenGL ES implementation").
- **Static helpers must be NDK builds** (`make_a14fs.py`): zig/musl binaries (lmkd) die with "TLS segment is underaligned" under bionic's linker.
- **Virt APEX stays**: the framework needs the `com.android.virt` jar; removing the APEX gives `NoClassDefFoundError` in zygote. The ext4 conversion (`virt_to_ext4.py`, needs `fsck.erofs`) is required.
- **Vendor**: `fileencryption=ice` removed from the userdata fstab line (format userdata once), and `vendor_mac_permissions.xml` loses the package-only signers (A17's SELinuxMMAC parser rejects the Samsung A11 file: system_server "Unable to load SELinux MMAC policy").
- **Kernel logging**: cmdline has `loglevel=4`, so only `<3>` and lower messages reach pstore (`/sys/fs/pstore/console-ramoops-0` from TWRP). `tools/debug/` has the probe tools; they are not part of the image.
- Known remaining gaps in the booted system: fs-verity ENOTTY, no memevents ringbuffer, no PSI, no power.stats HAL, `/efs/FactoryApp/cisd_*`, no vibrator shim, `/metadata` is volatile tmpfs.

## A14 stays restorable
`work/a14/system-a14.img` (sha256 9a3351708301666f3ffe2050eb25b90418def310095d1422fe777099962ad24b) and `boot-a14-permissive.img` are kept; they can be rebuilt with `tools/img/build_a14.sh` from the crDroid xz (kept) and `fw-extracted/`. Stock vendor for a full restore: `~/Aistuff/m30s-pixel-port/fw-extracted/img/vendor.img` (hash in FIRMWARE-TAR.md). Partition dump: `~/Aistuff/m30s-pixel-port/partition-dump/`.

## Pixel layer, kernel, zram (2026-11-07)
Current image: `work/a17/system-a17-pixel2.img` (5033164800 bytes, sha256 d6b6820c1b09894cfbfcff1d8b18745282ae7dbd4d3e2323e1952075c1d17bfb). Build:
```
python3 tools/pixel/stage_pixel_phone.py work/pixel/tegu-factory.zip work/pixel/stage --images work/pixel/img --keys <tablet repo>/tools/pixel
python3 tools/img/make_build_a17.py            # regenerates tools/img/build_a17.py
export JAVA_HOME=<temurin-17> A17_TOOLS=$PWD/work/a17/tools
python3 tools/img/build_a17.py --gsi work/a17/system.img --donor work/a17/LineageOS-23.2-20260524-GAPPS-EXT4-GSI.img --vndk-dir work/a17/vndk30 --a14fs work/a17/fs --pixel-phone work/pixel/stage --gapps work/gapps/MindTheGapps-16.0.0-arm64-20261023_034858.zip --dev-tools --out work/a17/system-a17-pixel2.img
```
- **Pixel layer** (`tools/pixel/stage_pixel_phone.py`, builder block `9d`): Pixel 9a (tegu) factory image apps re-signed with the public AOSP platform test key (SystemUIGoogle to SystemUI, SettingsGoogle to Settings, Nexus Launcher, wallpapers, setup wizard, Dialer, Messages, Photos, Gboard, Chrome, Trichrome, WebViewGoogle, 26 overlays, fonts, media, permissions). Fixes found on the way: GoogleConfigOverlay's `config_servicesExtensionPackage` patched to `android.ext.services` (else system_server aborts); `.apk.gz` files are gunzipped; WebViewGoogle is arm64-only so `unset_multiarch.py` clears `multiArch`; extra privapp allowlist in `tools/pixel/privapp-permissions-pixelphone-a17.xml`. Without the Pixel layer `02_webview.rc` picks the system WebView.
- **Kernel**: `boot-a17-psi.img` (kernel-4.14.113-a17, sha256 48de685820bf1d8c564c073b96d2df5c9545b4fe72bcec57c23af3719516d062) has PSI, BPF JIT, userfaultfd and permissive SELinux. With it the allow-all policy is not needed: the builder adds it only with `--allowall` (stock kernel). Booted and verified with the original `plat_sepolicy.cil`: `getenforce` Permissive, about 3000 denials logged (zygote and toolbox on unlabeled files, graphics allocator ioctl) that would have to be fixed before enforcing. The netbpfload JIT patch is kept: it only changes the path taken when the kernel has no JIT, so it is inert here (`bpf_jit_enable` 1, 19 programs loaded, no JIT failure in the logs).
- **zram**: the Samsung vendor fstab has no zram line, so the 5.6 GB phone ran with no swap (free RAM about 40 MB, `kswapd` at 25%). `tools/img/rc/03_zram.rc` sets up 3 GB of zstd zram at boot (a service with `seclabel u:r:shell:s0`; verified after a reboot).
- **Dexopt**: the image already has `zz_firstboot_dexopt.rc` (pass 1 about 60 s after boot, pass 2 about 45 min later, log `/data/local/tmp/dexopt.log`) and `pm.dexopt.install=speed`. By hand: `cmd package compile -m speed -a`. Compiling on a fresh flash keeps the CPU saturated for a long time; the phone is slow until it ends.
- **Flash** (TWRP, `adb reboot recovery`): `cat IMG | adb exec-in 'dd of=/dev/block/by-name/system bs=1048576'` (TWRP's dd rejects `4M`), then `head -c 5033164800 /dev/block/by-name/system | sha256sum`, then delete `/data/system/package_cache` and `/data/dalvik-cache` and reboot. Boot partition: `dd` the kernel image to `/dev/block/by-name/boot` (rollback: `work/a14/boot-current-stock-kernel.img`).
- **Not in this image**: camera, vibrator shim, `power.stats` HAL, Pixel utility apps (Recorder, Tips, accessibility, Maps and other Google apps), Tensor-only services. The GMS safety-center crash `Unexpected safety source: AdvancedProtection` is non-fatal and unresolved.
- **Release note**: the image contains Google's Pixel apps and the Samsung stock vendor, so it is not suitable for a public release; build it from the recipe above.
