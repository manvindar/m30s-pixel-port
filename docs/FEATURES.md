# Feature and sensor audit, Galaxy M30s (SM-M307F) on the Android 17 Pixel image, 2026-11-07

Read from the running phone (`pm list features`, `dumpsys sensorservice`, `dumpsys media.camera`, getprop, sysfs). "Works" only where something measured it; everything that needs a person (sound, camera picture, SIM, GPS fix, jack, charger) is marked **human**.

| Area | State | Evidence / note |
|---|---|---|
| Accelerometer | works | ICM42605M, 6.25-500 Hz; used by auto-rotate (WindowOrientationListener) |
| Gyroscope | works | ICM42605M, plus game rotation vector, rotation vector, gravity, linear acceleration from the AOSP fusion |
| Compass | works | AK09918C magnetometer, `android.hardware.sensor.compass` present (the tablet had none) |
| Proximity | **gap** | the HAL exposes it only as `com.samsung.sensor.physical_proximity` (type 65592, permission `com.samsung.permission.SSENSOR`, wake-up). Android's standard `TYPE_PROXIMITY` is missing, so the screen will not blank against the ear during a call and no app sees a proximity sensor. Stock Samsung framework synthesizes it. Fix options: map the type in the Samsung sensor HAL (vendor patch, `sensors.sensorhub.so`, the type is not a code constant so it needs disassembly of the sensor-list builder) or a small system shim. Not done |
| Ambient light | absent in hardware | no light sensor in the HAL list, no `light_sensor` in `/sys/class/sensors`, and the spec lists accelerometer, gyro, proximity, compass only: no auto brightness possible |
| Step counter / detector | present | Samsung sensor hub, `android.hardware.sensor.stepcounter` |
| Samsung extras | present, unused by Pixel UI | grip sensor (A96T3X6), pick-up gesture, tilt, wake-up motion, pocket mode, call gesture, hover proximity |
| Significant motion | active | the only sensor with a client when idle (after the sensor-hog fix) |
| Fingerprint | works | AIDL-to-HIDL shim `tools/fphal`; user unlock verified (fix 71b16e6, in v0.3d) |
| Face | declared, no HAL | feature file removed in the next image; BiometricService spun on `IVirtualHal` |
| Cameras | 3 camera devices listed, flash feature yes, autofocus yes | `dumpsys media.camera`. **Rear camera 0: works** (2026-11-08, driven over adb: stock camera app opens, a 3000x4000 JPEG is saved and has real picture content; the preview is only dark if the phone lies face down). HAL log noise while previewing: `PIPE_VRA wait timeout` (face-detection pipe) and `Failed to get Internal Bayer Buffer`, no crash. **Front camera: opens and streams** (2026-11-08 repro over adb: CameraService connects camera 1, the Exynos HAL starts the S5K3P8SP front sensor at 2304x1728, the kernel ISP (3AA) receives frames, the session ran 25 s without an error; switching rear to front and back works). The 'camera error, cannot connect' the user saw most likely came from my adb session still holding the rear camera (Samsung's HAL makes device 1 conflict with device 0), not from the front camera itself. `errorCode(2)` lines in the HAL log are request flushes when a session closes, harmless. No front picture was taken (shutter sound at night): **human** daytime check. Not verified: ultrawide, video, flash (night, skipped) |
| Audio | **human** | `android.hardware.audio.output/low_latency` declared; speaker, earpiece, mic, 3.5 mm jack (the phone has one per the spec) cannot be tested over adb. Samsung audio HIDL 5.0 vendor stays under the Android 16 audioserver closure |
| Wi-Fi | works | enabled, `wifi.direct`, `passpoint` declared; 5 GHz and hotspot not measured |
| Bluetooth | enabled | HEADSET profile connecting in the log; pairing and A2DP audio: **human** |
| GPS/GNSS | provider present | `gps provider` in `dumpsys location`; a fix needs sky: **human** |
| NFC | absent | no NFC service; the spec sources disagree by market, the SM-M307F has none |
| FM radio | no HAL | the spec lists FM radio but no FM HAL/app exists in this image |
| Telephony / SIM | not tested | `gsm.sim.state=ABSENT,ABSENT` (no SIM inserted), both `ril-daemon` services running, Samsung RIL v4.0, HIDL radio 1.4 slot bound; `telephony.ims` is declared but there is no IMS implementation, so no VoLTE/VoWiFi. Calls, SMS, data: **human** with a SIM |
| Charging | works, speed not measured | `dumpsys battery`: status charging, USB powered, level 89 %, 24.1 C (health shim). The Mac port gives 500 mA; the 15 W fast charge needs the wall charger: **human** |
| Display | 60 Hz only | see docs/PERF.md |
| HDR | do not use | HDR10 advertised gives black video (kernels `a17-hdr*`) |
| GPU | Mali-G72 MP3 | OpenGL ES 3.2, Vulkan 1.1 (`vulkan.level=1`), HWC DEVICE composition |
| Vibration | works in the stock HAL only, no shim | `android.hardware.vibrator` HIDL 1.3: haptics untested: **human** |

## Round of 2026-11-08 (user present, then phone put aside at night)
Done over adb (the user allowed the screen-lock PIN for this; it is not recorded anywhere): rear photo, launcher bench (below, also in docs/PERF.md). Skipped on purpose: audio and flash (night), SIM steps (no SIM), charger, GPS outdoors, headphone jack. Still open for daytime: front camera error log with a clean open (force-stop the camera app first), video, speaker + jack, wall charger, GPS fix.
Launcher bench (unlocked, 2 runs): Pixel Launcher janky 14-16 %, p50 21 ms, p99 48-65 ms, GPU p50 8-9 ms; SystemUI shade janky 15-19 %, p50 34-42 ms, GPU p50 19-20 ms. Launcher frames are slower than the 16.7 ms budget at the median but GPU is not the limit there (UI thread slow: 42-44 frames, draw-command issue slow: 87-97).

## One human round that settles the open rows
Unlock the phone once for the launcher bench; place a call with a SIM (proximity blanking, call audio); take a photo with each camera and a video; play a sound on speaker and with headphones in the jack; plug the wall charger; open Maps outdoors for a fix.
