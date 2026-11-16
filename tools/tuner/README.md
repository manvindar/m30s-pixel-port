# M30s ROM Tuner

Native Android app (`org.m30s.tuner`) and a root backend for Samsung Galaxy M30s / Exynos 9611. The ROM builder includes both by default; `--no-m30s-tuner` omits them. The inherited MediaTek tuner stays excluded.

Controls use the actual policy0/policy4 frequency tables: per-cluster CPU maximum, schedutil/performance governor, input boost enable/duration, swappiness and animation scales. CPU/GPU clocks, BIG temperature, kernel battery capacity and available memory are displayed. GPU controls, overclocking and thermal overrides are unavailable.

| Profile | Efficiency maximum | Performance maximum | Touch boost |
| --- | --- | --- | --- |
| Battery saver | 1326 MHz | 1768 MHz | 100 ms |
| Balanced | 1742 MHz | 2314 MHz | 150 ms |
| Responsive | 1742 MHz | 2314 MHz | 300 ms |

All profiles select schedutil and enable touch boost. Responsive extends boost duration without raising stock maximum clocks. Performance improvements have not been measured.

A fresh installation changes no knobs. Only successful explicit requests are saved under `/data/misc/m30s-tuner`; they are revalidated at service startup. Requests are parsed as data, bounded and checked against advertised frequencies. Writes require readback; partial failures attempt restoration. Hardware/transport failures can also prevent restoration: inspect actual values if a request fails. Thermal controls are never written.

The service requires root, Samsung `ro.product.device=m30s`, the documented sysfs interfaces and a compatible permissive/root SELinux policy. Image integration uses the existing init domain; standalone installation uses the supplied su-domain service only where that domain exists. It has not been validated on enforcing stock Samsung firmware. The boot-completed init service starts the backend; the app cannot start it itself. The app's state and request files live in its private directory. Removing the app does not restore previous tuning; restore values before removal and remove saved configuration if no longer wanted.

## Build and checks

```sh
sh tools/tuner/build.sh /absolute/output /external/signing-key-directory
python3 -m unittest discover -s tools/tuner/tests -v
```

Requires Android SDK build tools 35.0.0, platform android-34, Java and zip. Override `ANDROID_HOME` / `BUILD_TOOLS` when needed. Signing directory supplies `platform.pk8` and `platform.x509.pem`; alternatively pass a keystore and set `M30S_TUNER_KEY_PASSWORD`. Keep keys and generated APKs outside Git. The experimental image uses the existing AOSP test signing identity; this is not a production private key.

The M30s package is separate from Lenovo's `org.tablet.tuner`, so its signing identity and data remain independent. The original app can be disabled reversibly after verification.

## Tablet interface on M30s

`tablet/` retains the tablet ROM Tuner's `org.tablet.tuner` package, interface, graphs, search, responsive layout and quick-settings performance tile. Its M30s pages expose CPU caps, governors, touch boost, swappiness and animation scales. The original tablet-only pages are excluded from navigation; direct legacy page intents return to the supported home page. Named saved profiles and the tablet's MediaTek, picture, overclock and thermal controls are unavailable. Both apps use one M30s backend and shared saved values; changes from either affect the same hardware.

```sh
M30S_TUNER_FLAVOR=tablet sh tools/tuner/build.sh /absolute/output /external/signing-key
```

For an in-place update, supply the same signing identity as the installed tablet app. Image builds use their supplied platform test identity; that identity does not replace a differently signed existing data app. The live M30s update was signed with the tablet app's original external keystore and preserved its data. Neither keystore nor credentials are in this repository.
