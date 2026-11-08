# One UI 9 first boot (2026-11-08): from boot loop to the Samsung setup wizard

Phone M30s (SM-M307F), donor A266B, vendor/boot unchanged (v0.3e/f), kernel 4.14.113. Diagnosis was done from TWRP (`/data/local/tmp/bootdiag`, tombstones) and later over adb (root, no auth) with `adb logcat -b all` captured across reboots; files were patched live on the rw-remounted `/` and then baked into `tools/oneui/build_oneui_port.py`.

| # | Symptom (first failing line) | Cause | Fix (in the build script) |
|---|---|---|---|
| 1 | `NetBpfLoad: Android 25Q4 requires kernel 5.10.` then `reboot,bpfloader-failed` loop, no adb | new kernel gate in netbpfload, `reboot_on_failure` | `patch_netbpfload.py`: gate message list gets 25Q4 |
| 2 | netbpfload SIGABRT in `ElfObject::ElfObject` (`file %s is on device ...`) | the patched copy is bind-mounted from /system, the .o files live on the apex loop device | same tool: nop the device compare |
| 3 | `NetdUpdatable: Failed to get program ... prog_netd_egress_stats` -> `reboot,netd1shot-fail` | the only 4.14 variant of egress/ingress_stats has api window [3300,3500) | same tool: api level constant 3499 at the *program* skip site only (maps keep the real api: the 25Q2+ local_net_* maps must exist) |
| 4 | system_server: `config_servicesExtensionPackage ... android.ext.services` missing | the extservices apex ships `com.google.android.ext.services` | `overlay-extservices` (static overlay on `android`, built against the donor framework-res) |
| 5 | (silent) Google layer invisible | /product is mounted from the phone's own product partition (sda27) over the image's /product | Google stage goes to `/system/system_ext` |
| 6 | health: `ISehHealth$Stub$Proxy.registerCallback` NPE, then `HealthInfo` null | Samsung's BatteryService takes HealthInfo only from `ISehHealth` (AOSP `update(HealthInfo)` is an empty stub). The vendor has the HIDL `vendor.samsung.hardware.health@2.0::ISehHealth` and the framework uses it unless AIDL IHealth is declared (the vendor-a17 fragment declares it for the Pixel health shim) | `rc/00_health_hidl.rc`: bind-mount an empty manifest over that fragment at `early-init` (vendor untouched); `patch_services_oneui.py` also nops the Samsung AIDL `registerCallback`/`update` calls |
| 7 | `nativeGetNextMapKey failed: errno 524` on `local_net_access_map` | LPM tries cannot be iterated before kernel 4.20 | netbpfload creates LPM_TRIE maps as HASH |
| 8 | `BpfRingbuf init failed ...local_net_note_op_ringbuf` / `loopback_access_ringbuf` -> SIGABRT | no BPF ringbuf (kernel < 5.8) | `patch_lsc_ringbuf.py` (libservice-connectivity, bind-mounted like the other two): ringbuf fd = `eventfd2`, `nativeInitLoopbackEventConsumer` = `mov x0,#0; ret` |
| 9 | `Call to getInstalledModules before metadata loaded` | the donor's module metadata package comes from a Google-only partition | `modulemetadata/`: empty `<module-metadata/>` package `com.android.modulemetadata` (key is `android.content.pm.MODULE_METADATA`) |
| 10 | kernel oops `tz_uiwsock_poll` -> `circ_buf_bytes_used` ~15 s after the launcher, reboot loop | `com.samsung.sec.android.teegris.tui_service` epoll_ctl()s the TEEgris TUI socket | apk removed |

Result: `sys.boot_completed=1`, SystemUI and launcher start, Settings shows the setup wizard, no reboot for minutes. Not yet tested: touch after the wizard, Wi-Fi, SIM/radio, camera, fingerprint, audio, hotspot.
