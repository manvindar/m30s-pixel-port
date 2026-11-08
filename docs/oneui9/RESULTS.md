# One UI 9 on the M30s: feature results (2026-11-08, image sha256 92b6c726..., kernel a17, vendor-a17 unchanged)

Method: over adb with the clean-flashed rebuilt image sitting in the first-run wizard. WORKS only where measured; HUMAN needs a person; NOT YET means no result.

| Area | Result | Evidence |
|---|---|---|
| Boot | WORKS | boot_completed in under 3 min from a clean flash, no reboot loop for 15+ min, load average above 20 for the first 10 min (dexopt) |
| Display | WORKS | screenshots: Samsung wizard Welcome and Wi-Fi pages render |
| Touch | HUMAN | `sec_touchscreen` and `sec_touchproximity` nodes present; physical taps not tried yet |
| Wi-Fi scan | WORKS | wizard lists 2.4 and 5 GHz networks (5 GHz marked); join/5 GHz link/hotspot: HUMAN (needs the owner's password) |
| Battery and charging | WORKS | `dumpsys battery`: level 100, 4.33 V, 28 C, USB powered, health good (Samsung HIDL ISehHealth path) |
| Sensors | WORKS, gap known | accelerometer, gyro, magnetometer (ICM42605M, AK09918C); proximity is `com.samsung.sensor.physical_proximity` (type 65592) under the donor framework: call test HUMAN |
| Fingerprint | HUMAN | `dumpsys fingerprint`: provider registered via the AIDL shim, 0 prints, 0 HAL deaths; enrolment after the wizard |
| Camera | partly | `dumpsys media.camera`: 3 camera devices; provider, ofi, remosaic daemons running; picture quality, front/rear: HUMAN |
| Audio | HUMAN | audioserver (Android 16 closure) running, AudioOut thread on 48 kHz, policy lists Earpiece and Speaker; sound and jack: HUMAN |
| Telephony | HAL only | both `rild` services up, Samsung RIL binds SehRadio HAL 2.1 for radio/network/data; no SIM: calls, SMS, data HUMAN; IMS not provided |
| Hotspot | NOT YET | the 5 GHz overlay from the Pixel image is not in the One UI image (config_wifi5ghzSupport is a vendor-side value on One UI; test first) |
| Performance | NOT YET | measure launcher and shade janky % after dexopt settles |
| Thermal | partial | zone temps 37-42 C at idle |

## Defects seen
- SSRM warning dialog at every boot: "Fails to parse policy XML". SDHMS log: `limiter(GPUFreqMax) has invalid value - 845000`. The donor SIOP policy names a GPU step the Mali-G72 table (260-1053 MHz: 260 338 385 455 546 572 683 764 839 949 1053) does not have. The policy is an asset inside `SamsungDeviceHealthManagerService.apk`. Cosmetic; thermal limiter rules are not applied until the policy parses. Options: edit the asset and re-sign (platform key not available), or disable the SIOP part.
- Factory Reset Protection page in the wizard: the owner must sign in with the previous account.
- `Permission not found: com.samsung.permission.WRITE_SDHMS_DATA` and BRList allowlist errors in logcat: noise.
