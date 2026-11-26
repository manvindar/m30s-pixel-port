# ROM Tuner feature matrix (tablet app 8523f50 on the M30s, mint kernel)

Source of the tablet interface: `rom-tuner/` at `8523f50` of the Android 16 port (2026-11-04). Device facts: SM-M307F, kernel 4.14.113-a17-mint, read from the phone by Pam (2026-11-26, `agents/pam-mw9kdvck/work/caps`).

Rule for every row: the backend publishes the control's key in the state file only when the node, service or package is there; the app shows a control only when its key is published (`Caps.has`). A write is checked against a fixed list (or what the kernel advertises), read back, and rolled back on a mismatch.

"Host" = covered by the host tests (`tools/tuner/tests`, fake `/sys`, `/proc` and Android commands). "Device" = still needs Pam's run on the phone; nothing here has been run on the device yet.

## Pages

| Page | Shown when | Reason it can be missing |
| --- | --- | --- |
| Overview (mode cards, live chart, what the mode changes, save bar) | always | |
| Live (graphs, state) | always | reads `/sys` directly; Mali clocks, BIG zone, `mif` devfreq when the kernel has them |
| Performance | always | |
| Profiles (saved) | `saved_profiles` published | old backend |
| App speed (per app compile) | `compile_status` published | old backend |
| Look | `night` or `theme_ok` | UI-mode or theme setting unreadable |
| Display and touch | any of its settings | |
| Memory, storage and network | `swappiness` | |
| Connections | any of Wi-Fi country, DNS, ADB network, serial console | |
| System | always | |
| Picture | never | MediaTek PQ HAL (`pq-2-2` service, `persist.vendor.sys.pq.*`) does not exist on Exynos |
| Overclock | never | needs MediaTek `/proc/eem`, `/proc/gpufreq`; the Exynos kernel has neither |

## Controls

| Control | Key | Source on this device | Hidden when | Status |
| --- | --- | --- | --- | --- |
| Mode: Battery, Balanced | `perf_profile` | caps 77 percent step / table maximum, schedutil | no schedutil | Host (v0.9 behaviour, unchanged) |
| Mode: Responsive | | needs the touch boost module | module absent: hidden on the mint kernel | Host |
| CPU maximum, little and big | `cap_little`, `cap_big` | cpufreq tables (13 and 15 steps) | table missing | Host |
| CPU governor | `governor` | performance, schedutil (both clusters) | none in common | Host |
| Clock rise and drop delay | `up_rate`, `down_rate` | schedutil `up_/down_rate_limit_us` (5000/5000) on both policies | governor is not schedutil | Host, Device |
| Deep idle | `deep_idle` | cpuidle `state1..` `disable` (state1 `bootcl-cpu-slee`); state0 WFI never touched | nodes missing | Host, Device |
| Scheduler statistics | `schedstats` | `/proc/sys/kernel/sched_schedstats` | node missing | Host |
| Touch boost on, duration | `touch_enabled`, `touch_duration_ms` | `input_boost_m30s` | module absent (it is, on the mint kernel) | Host |
| GPU maximum clock | `gpu_max` | Mali `dvfs_table`, `dvfs_max_lock`: the node reads `<limit> / <min>` while limited and `-1` when free; writing 0 releases (writing -1 does nothing); a rejected change puts the previous lock back and never leaves one behind | files missing | Host (format from device evidence), Device |
| I/O scheduler | `io_sched` | UFS `sda..sde` (USB disks skipped); all five took noop and cfq on the phone | no UFS disk | Host, Device (passed) |
| Read-ahead | `read_ahead_kb` | only where a probe shows a changed value sticks: once per boot the first disk is given another step, read back and put back (on this kernel sda keeps 128, so the row is expected to be hidden) | probe fails, no UFS disk | Host, Device |
| TCP congestion control | `tcp_cc` | cubic, reno | list missing | Host |
| Swappiness | `swappiness` | `/proc/sys/vm/swappiness` (130, up to 200) | | Host |
| File cache pressure | `vfs_cache` | `vfs_cache_pressure` (100) | node missing | Host |
| Swap read-ahead | `page_cluster` | `page-cluster` (3) | node missing | Host |
| Memory watermark | `watermark` | `watermark_scale_factor` (10) | node missing | Host |
| Free memory reserve | `extra_free` | `extra_free_kbytes` (29615) | node missing | Host |
| Background apps kept | `bg_procs` | `device_config activity_manager max_cached_processes` | | Host, Device |
| Cached app limit | `cached_apps` | `settings global activity_manager_constants` (other constants kept) | | Host, Device |
| Stock values | `stock_*` | recorded by the backend at its first run after a boot, before saved values are restored; read whole (a `/proc/sys` node answers the shell's byte-wise `read` with one character, so kernel nodes are read with `cat`); a snapshot of an older version is dropped until the next boot | | Host (one-byte-read stand-in) |
| Request status | `last_request`, `status` | the header shows Applying until the daemon echoes the newest request the app sent; changes made while the daemon is busy are queued in the app, not dropped | | Host, Device |
| Request latency | `last_request` | a waiting request stops the state build at its next checkpoint (at most three stops in a row); one build serves both apps; the static part (lists, stock values, frequencies) is cached and rebuilt every 60 s; `tuner.log` records `request X answered`, `publish took N s` (3 s or more) and each stopped build | | Host (slow-`cat` stand-in), Device |
| Dark mode | `night` | `cmd uimode night` | service missing | Host, Device |
| Accent colour, palette source, palette style | `accent`, `palette_source`, `theme_style` | `secure theme_customization_overlay_packages` (rebuilt from the current value) | setting or `cmd overlay` unavailable | Host, Device (SystemUI must pick it up) |
| Font | `font` | font overlays found by `cmd overlay list` | none installed (the image ships none) | Host |
| Icon shape, icon pack | `icon_shape`, `icon_pack` | `com.android.theme.icon.*` and `icon_pack.*` overlays | none installed | Host |
| Pure black | `black_theme` | `org.lineageos.overlay.customization.blacktheme` | overlay absent (the image ships none) | Host |
| Navigation mode | `nav_mode` | both `com.android.internal.systemui.navbar.*` overlays | overlay missing | Host, Device |
| Animation speed | `anim_scale` | global animation scales, 0.0 to 2.0 in steps of 0.1; not saved by the backend (the Settings database keeps it, and a saved copy would override what the user sets elsewhere; an older saved value is ignored) | | Host |
| Turn off window blur | `window_blur` | `global disable_window_blurs` | | Host |
| Display size | `density` | `wm density`: percentages (80, 90, 100, 110, 125) of the physical density | `wm density` unreadable | Host, Device |
| Font size, text weight, high contrast, screen timeout, stay awake, auto-rotate, show taps | | `settings` | | Host |
| Wi-Fi country | `wifi_country` | `cmd wifi force-country-code` (applied again after boot and when system_server restarts) | command missing | Host, Device |
| Private DNS | `dns` | `settings global private_dns_*` | | Host |
| ADB over network | `adb_tcp` | `service.adb.tcp.port`, restarts adbd (drops the USB session too); not kept across boots | | Host, Device (run last) |
| Serial console | `serial_console` | `init.svc.console` | service absent | Host |
| System logging | `logging` | `persist.log.tag`, `logcat -G`; nothing is applied until the user changes it | | Host |
| Saved profiles (save, use, update, delete) | `save_profile`, `apply_profile`, `update_profile`, `delete_profile` | the keys of the table above plus animation, blur, background limits, CarPlay boost; a key the device lacks is skipped; one rejected key puts everything back; at most 24, names up to 24 characters | | Host |
| Compile apps now, recompile all | `compile_now`, `compile_all` | `/system/bin/dexopt_all.sh` of the image (`DEXOPT_FORCE`; a manual compile restarts the interface after the first apps); refused while the first-boot compile runs | script missing | Host (fake script), Device |
| Per app compile, reset, refresh | `compile_pkg`, `compile_pkg_profile`, `reset_pkg`, `refresh_apps` | `cmd package compile`, state list from `cmd package art dump` or `dumpsys package dexopt`; the interface, phone service and this app are never force-stopped | | Host, Device (dump format on Android 17) |
| Progress of both | `compile_*` | parsed from the script log or the queue | | Host |
| Boost while CarPlay is open | `carplay_boost` | DiPlay or Pillion installed; Battery becomes Balanced while it is on screen and goes back | neither app installed | Host |
| Restart interface, reboot | `restart_ui`, `reboot` | `pkill -f com.android.systemui`, `sync; reboot` | | Host |
| Hub mode tile, screen saver | | app only (unchanged from the tablet app); no backend | | not tested |
| Widevine row, shortcuts | | MediaDrm; shortcuts only when their target app resolves (LineageOS parts and Dolby Atmos are not on this image) | target absent | n/a |

## Not offered, with the reason

| Feature | Reason |
| --- | --- |
| Presets Smooth, Performance, Extreme | built on MediaTek boosts, a touch boost the mint kernel lacks, and an overclock; no Exynos equivalent has been measured |
| App boost, touched-app boost, big-task rotation, thermal limit off, Maximum clocks | MediaTek `perfmgr` and `ppm` nodes absent (no `/proc/perfmgr`, `/proc/ppm`); thermal controls are never written by this backend |
| MCDI deep idle | no MCDI node; replaced by the cpuidle row above |
| Touch boost clock and strength, clock headroom | schedplus and MediaTek touch nodes absent |
| Write buffer (`dirty_ratio`) | the kernel reports 0 for `dirty_ratio` and `dirty_background_ratio` (byte limits are probably in use); writing a ratio would change that and is unverified |
| GPU governor, GPU minimum clock | Mali governor names `Static`, `Booster`, `Dynamic` and a minimum above the maximum could pin or stall the GPU; not tested |
| Bluetooth MediaTek workaround | MediaTek controller workaround |
| Treble audio effects switch | tablet-specific workaround that edits another app's preferences |
| Boot animation | the zips are tablet-sized and not in this image; the image build copies none |
| Picture, Overclock, preview photo | see Pages |
