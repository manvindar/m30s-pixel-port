# Phase 2a: read-only probes (2026-11-06)

Method: `adb -s DEVICE_SERIAL`, `shell` user (uid 2000, SELinux Enforcing). One file pushed to `/data/local/tmp/kprobe` (3.5 MB, static arm64, source `tools/probe/kprobe.c`, build `tools/probe/build.sh`); it writes nothing, changes no setting, no reboot. Remove it with `adb -s DEVICE_SERIAL shell rm /data/local/tmp/kprobe` (not done yet; the user's OK covered pushing it). Raw output: `kprobe-output.txt`, `vintf/`, `codecs/`, `vendor-etc-listing.txt`, `sysfs-health-lights-vibrator.txt`. All lines below are VERIFIED unless marked.

## 1. Kernel capabilities (4.14.113)
| Item | Result | Consequence |
|---|---|---|
| `F_SEAL_FUTURE_WRITE` (memfd, fcntl 0x10) | **absent** (EINVAL) | Same as the tablet. A17 libhwui no longer seals with it (Phase 1, disassembly; RELAYED), A16/A14 builds may. Re-check on the chosen GSI's libhwui before the first boot |
| `clone3`, `close_range`, `openat2`, `faccessat2`, `pidfd_open/_getfd/_send_signal`, `process_madvise`, `epoll_pwait2`, `io_uring_setup`, `userfaultfd`, `rseq` | **all ENOSYS** | `close_range` kills netd's dnsmasq spawn (hotspot) exactly as on the tablet: reuse `tools/libc/patch_netd_spawn.py`. bionic of A14+ falls back for `clone3`/`faccessat2`/`openat2` (bionic has fallbacks since A12; UNVERIFIED on the build) |
| `membarrier`, `statx` | present | |
| BPF | **not testable as `shell`**: even `mov r0,0; exit`, `BPF_MAP_CREATE` get EACCES from SELinux/`unprivileged_bpf_disabled` | The 4.14 verifier cannot have atomics (they came in 5.12), so the tablet's netbpfload/netd.o patches apply; test as root later. `RINGBUF` is a 5.8 feature: absent by version |
| Binder | `/dev/binder`, `/dev/hwbinder` protocol version **8** (ioctl OK); `/dev/vndbinder` not openable as shell; `/dev/binderfs` dir exists, empty | A12+ wants 8: fine |
| PSI | **absent** (`/proc/pressure` missing) | confirmed |
| Memory cgroup v1 | `/dev/memcg` with `memory.pressure_level`, `memory.swappiness`, `apps/` | **correction to PLAN s9.3**: lmkd can run on memcg pressure events |
| In-kernel LMK | **present**: `/sys/module/lowmemorykiller/parameters/{minfree,adj,lmkcount,lmkd_count,lmkd_cricount,cost,debug_level}` (minfree and adj read `0,0,0,0,0,0` now: Samsung SLMK tuned from userspace) | **correction to PLAN s9.3** ("no in-kernel LMK"): the tablet's `lmkd_inkernel.c` approach carries over |
| Samsung SLMK userspace | `init.svc.lmkd=running`; props `ro.slmk.*` (`enable_userspace_lmk=true`, `dha_*`, `fha_enable`, `freelimit_val`...) | the stock `lmkd` is Samsung's build, so GSI `lmkd` ignores these; measure what the tablet shim does to RAM behaviour |
| cgroups mounted | cpuctl, cpuset, stune (schedtune), freezer, memcg (all v1), plus `cgroup2` at `/dev/cg2_bpf`; no `/sys/fs/cgroup` content visible | A17 `task_profiles` for v1 cgroups: the tablet is also 4.9, same issue and fix class |
| Filesystems | ext4, f2fs, vfat, sdfat, **sdcardfs**, fuse, ecryptfs, bpf, cgroup2; **no erofs, no overlayfs, no incremental-fs** | GSI images must be ext4 (they are). Overlayfs absent: no `adb remount` overlay trick; A17 `fs_mgr` handles that |
| Misc nodes | `/dev/ashmem` exists, `/dev/ion` exists, **`/dev/dma_heap` absent** | A17 gralloc/codec2 stack is HIDL vendor with ion: OK, same as the tablet |
| `/metadata` | no partition in `by-name`; `ls /metadata` as shell gives Permission denied (a directory exists on the ro rootfs) | A17 init mounts `/metadata` from the fstab and formats it; see PHASE2B-3 draft |

## 2. VINTF (device, `/vendor/etc/vintf`)
`manifest.xml` is the Phase 0 file (`target-level 3`, HIDL only); fragments in `manifest/` add: health 2.1 (Samsung `ISehHealth` 2.0), **AIDL `android.hardware.light` ILights/default**, sensors 2.0 multihal, usb 1.1, thermal 1.0/2.0 plus `vendor.samsung.hardware.thermal`, drm 1.3 (clearkey, widevine), cas 1.2, media c2 1.1 (`sec_c2`), wifi 1.0 + hostapd, wifi `vendor.samsung.hardware.wifi` 2.0, `vendor.samsung.hardware.hqm`, `vendor.samsung_slsi.hardware.ofi`, vaultkeeper, engmode, `power-samsung`, `hyper`. `compatibility_matrix.xml` (device matrix, version 2.0, all `optional="true"` entries: displayservice, schedulerservice, sensorservice, vr composer, hidl allocator/manager) is lenient.
- Vibrator: HIDL `android.hardware.vibrator@1.3::IVibrator/default` (service `vendor.samsung.hardware.vibrator@2.1-service`, node `/sys/class/timed_output/vibrator/enable`, **root-only readable**). Tablet situation again: A17 wants AIDL IVibrator (RELAYED from `tb-x606v-android17` notes), so a shim is needed; better to **forward to the vendor HIDL 1.3 service** than to write sysfs (keeps amplitude/effects if the HAL has them).
- Health: HIDL 2.0/2.1 (`android.hardware.health@2.0-impl-2.1-samsung`). A17 looks for AIDL health (tablet note), so the tablet's AIDL health shim is the model. Unlike the tablet, the gauge here is real: `sm5713-fuelgauge` + `sm5713-charger`; `power_supply/battery` readable as shell and plausible (status Charging, health Good, capacity 20, 3868000 uV, 324 = 32.4 C, cycle 647, charge_counter/charge_full present). A shim can read `battery` directly; the capacity-vs-ratio workaround should not be needed (UNVERIFIED).
- Lights: already AIDL (`vendor.samsung.hardware.light-service`); backlight `/sys/class/backlight/panel` (root-only for brightness reads). **No lights shim needed** if A17's AIDL version is compatible (UNVERIFIED: check the declared AIDL version).
- Camera is `@2.6::ICameraProvider/legacy/0` plus `ISehCameraProvider@4.0`; audio is HIDL 5.0 (+ `ISehDevicesFactory`); graphics composer 2.1, mapper 2.1, allocator 2.0; keymaster 4.0; gatekeeper 1.0; gnss 1.1/2.1; radio 1.4 slot1+slot2 and `vendor.samsung.hardware.radio`. All HIDL, which A17 still serves through the legacy compatibility path as on the tablet (HIDL 2.x composer/mapper worked there).

## 3. Codecs
`/vendor/etc/media_codecs*.xml` saved. The MP2 trap: `media_codecs_sec_primary.xml` line 42 declares `<Type name="audio/mpeg-L2">` (inside `OMX.SEC.mp3.dec`, 8-48 kHz, 8-384 kbps). On the tablet a vendor decoder for `audio/mpeg-L2` aborted system_server; here the equivalent edit is to remove that `Type` (script model: `tools/vendor/fix_vendor_codecs_mp2.py`). Whether it aborts on this device is UNVERIFIED, but the edit is a one-line vendor change and `/vendor` survives `system` reflashes. `media_codecs.xml` lists `OMX.Exynos.vp9.dec` (+ `.secure`) and `OMX.Exynos.VP9.Encoder`, so VP9 decode is an Exynos codec here (hardware or software not known: UNVERIFIED); the tablet's VP9 removal does not apply until a YouTube playback test shows a problem. Samsung software decoders: h263, vp8, hevc, avc, mpeg4, vc1.

## 4. Samsung sysfs for the shims (as `shell`, so only what is world-readable)
Readable: `power_supply/{battery,sm5713-charger,sm5713-fuelgauge,usb,ac,otg,wireless,ps}`. Denied: `/sys/class/leds`, `backlight/panel/{brightness,max_brightness}`, `/proc/bus/input/devices`, `timed_output/vibrator/enable`, `/proc/cgroups`, `/proc/sys/vm/overcommit_memory`. These need root (or a vendor HAL) in Phase 3.

## 5. Other findings
- `ls /vendor/etc/init` shows the full Samsung service list (`argos.rc`, `cass.rc`, `emservice.rc`, `teegris_v3.rc` = TEEgris TrustZone, `snap_utility.rc`, `hyper-default-sec.rc`...). These start under any `system`: expect SELinux denials on a GSI policy (`vendor` policy is split, so the vendor part is stock; the platform side needs mapping 30.0).
- `/apex/com.android.vndk.v30` is mounted from the stock system image (Android 11). Confirms the donor plan: the VNDK 30 APEX comes from the A14 GSI.
- Battery was 20% and charging at probe time; before any reboot or flash check the charge.
- Probe cleanup: `kprobe` is still in `/data/local/tmp` on the phone.
