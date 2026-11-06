# m30s-pixel-port

Pixel design (Pixel Launcher, Google look and feel) on a Samsung Galaxy M30s (SM-M307F, Exynos 9611), by putting a prebuilt Android GSI into `system` and layering Pixel apps on top. Sister project of the Lenovo TB-X606V port (`~/Aistuff/tb-x606v-android17`, `~/Aistuff/android-aosp`); its tooling is reused, not rewritten.

Status: **Phase 0 and Phase 2a (read-only probes) done; Phase 2b/3 plan drafted (`docs/PHASE2B-3-DRAFT.md`). Nothing has been flashed, unlocked, wiped or rebooted.** The bootloader is locked and the phone is in daily use (91 GB of 113 GB used, two SIMs, a Dual Messenger user, an SD card).

- `docs/PLAN.md`: feasibility verdict, GSI choice, layer design, flashing route, risks, phases.
- `docs/phase0/PHASE0.md`: what was read from the device, with the raw dumps next to it.
- `docs/phase2a/PHASE2A.md`: kernel capability probe (`tools/probe`), VINTF, codecs, Samsung sysfs.

Rules for anything done here
- Always `adb -s DEVICE_SERIAL`. Never touch the Lenovo tablet (OTHER_DEVICE_SERIAL / 192.0.2.71:5555) or its recovery.
- Phase 0 is read-only. Unlocking the bootloader wipes the phone and trips Knox permanently; it needs the user's explicit OK and a verified backup first.
- Everything not read from the device is marked UNVERIFIED.
