# Jank and performance notes (Galaxy M30s, Android 17 Pixel image), 2026-11-07

Bench: `tools/debug/bench.sh` (launcher + shade) and, with the screen locked, the shade pull alone (6 pulls down and up, `dumpsys gfxinfo com.android.systemui`). Numbers are `Janky frames` %, p50 frame ms, p50 GPU ms. Noise between identical runs: janky 11.6-12.8 %.

## Found and fixed
| Finding | Evidence | Fix |
|---|---|---|
| GMS Personal Safety streams the accelerometer (`personalsafety.ars.datacollection.SensorStreamer`, 10 ms period, 5 s batching, later 100 Hz) | `dumpsys sensorservice` history; RT SensorService thread 10 %, system_server 26-55 % CPU idle, 10-13 % after disabling `PSAService`, `PersonalSafetyService`, `SndDetectionService` of `com.google.android.gms` | `tools/img/rc/06_nosensorhog.rc` runs `pm disable` on the three at every boot (a GMS update or a wipe resets them) |
| Face feature declared with no HAL: BiometricService spins on `IVirtualHal` (4 log lines/s, 4279 lines in one logcat) | `pm list features` shows `android.hardware.biometrics.face` | image builder removes `/system/product/etc/permissions/android.hardware.biometrics.face.xml` |

## Checked, no change
- **Hardware rendering is real** (a): GLES `ARM, Mali-G72, OpenGL ES 3.2 v1.r26p0`, `vulkan.universal9611.so` present, HWUI pipeline `Skia (OpenGL)`, RenderEngine on GLES, HWC layers `composition=DEVICE`, `usesClientComposition=false`. No swiftshader/llvmpipe. `persist.sysui.disableBlur=1` is set, animation scales 0.6.
- **Display** (b): one mode, 1080x2340 at **60.00 Hz** (`dumpsys SurfaceFlinger`: a single `supportedModes` entry). The panel is a 60 Hz Super AMOLED ([GSMChina](https://gsmchina.com/smartphones/samsung-galaxy-m30s/), [GSMArena](https://www.gsmarena.com/samsung_galaxy_m30s-9818.php)): no higher refresh rate to unlock. Achieved: shade frames p50 30-38 ms (about 30 fps while pulling), launcher mostly 60.
- **Shade GPU cost**: SystemUI shade pull, keyguard: janky 12.4 %, p50 31 ms, GPU p50 21 ms (p90 24 ms). GPU runs at 949 MHz (clock sampled during the pull: 949 MHz 50 %, 764/839 MHz the rest; table 260-1053 MHz). Experiments, all measured with the same pull:
  | Change | janky | GPU p50 | verdict |
  |---|---|---|---|
  | baseline | 12.4 % | 21 ms | |
  | Mali `power_policy` always_on | 11.6 % | 21 ms | no |
  | MIF at max (2093 MHz, it already reaches it during the pull) | 12.5 % | 21 ms | not memory bound |
  | Skia Vulkan for SystemUI (`debug.hwui.renderer=skiavk`) | 13.6 % | 19 ms | no (p99 worse) |
  | **display 720x1560 (0.44x pixels)** | 9.7 % | **12 ms** | GPU time scales with pixels: fill-rate/overdraw/shader bound |
  | `debug.sf.latch_unsignaled=1` (the only phh Exynos tune, after a reboot, 3 runs) | 13.2 / 12.0 / 10.7 % | 20-21 ms | no measurable win |
  Conclusion: the Pixel 9a SystemUI shade is simply too heavy for 3 Mali-G72 cores at 1080x2340 (about 8 ns per pixel per frame). No driver or governor knob helps. What is left is less drawing (a lighter shade, density, or fewer effects), not tuning.
- **phh tunes** (c) (`device_phh_treble/rw-system.sh`, master): the only rule that matches this phone is `debug.sf.latch_unsignaled 1` for `ro.hardware=exynos*`: no win here (above). Everything else is for other SoCs. `dalvik.vm.isa.arm64.variant` is `generic` here (phh sets it only for kryo300); `cortex-a73` could help dex2oat but needs a full recompile to measure: not done, not shipped.
- Clock locks (CPU/GPU) and blur-off did not help in the earlier runs (lead3) and are not shipped.

## Not done
- Launcher bench, 2026-11-08, phone unlocked, two runs of `bench.sh`: launcher janky 15.7 / 14.2 %, p50 21 ms, p90 31-32 ms, p99 65 / 48 ms, GPU p50 8-9 ms; SystemUI (shade) janky 18.8 / 15.1 %, p50 34 / 42 ms, GPU p50 19-20 ms. The launcher is limited by UI-thread and draw-command issue time, not the GPU.
