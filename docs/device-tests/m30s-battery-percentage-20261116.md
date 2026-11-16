# Samsung battery percentage override

On the newly flashed Android 17 candidate, Android showed **89% Charging** while
Samsung's kernel reported **100% Full**. Repeated reads showed:

| Property | Reading |
| --- | --- |
| `battery/capacity` | 100 |
| `battery/batt_read_raw_soc` | 10000 (100.00%) |
| Fuel-gauge kernel log | SOC register `0x6400`, scaled SOC 1000 |
| `battery/charge_counter` | 5361000 µAh |
| `battery/charge_full` | 6000000 µAh |
| Android level | 89 |

The inherited Lenovo health shim applies `round(100 * charge_counter / charge_full)`
when it differs from capacity by more than ten points. Here that produces 89 and
changes Full to Charging. Lenovo's MediaTek driver makes that ratio equal its
UI percentage. Samsung's `sec_battery.c` instead exports a nominal full capacity,
and `sm5713_fuelgauge.c` calculates charge counter using fuel-gauge capacity and
raw SOC. Those different denominators do not establish a Samsung UI percentage.

The pre-flash read-only check had matching Android/kernel 90% and raw 89.60%; it
is historical evidence and does not negate the new shim mismatch.

The M30s builder now stages a hash-pinned copy of the shared health source and
disables the Lenovo-only ratio correction. Samsung's kernel capacity and status
are preserved; raw counters, voltage, current, temperature and charger flags
remain available. The source of the Lenovo implementation is untouched.

Host Java tests reproduce 89% with the original source and validate the fixed
100%/Full result, changing capacity during discharge, low and zero percentages,
current sign, USB, voltage and temperature. Python tests reject source drift and
verify the original stays unchanged. The generated builder matches its generator,
and the complete health shim compiles to DEX.

## Owner-authorized installation

Installed the corrected health JAR on 2026-11-16, after preserving and verifying
the original. Installed SHA-256:
`b753d1853801a552178683360e50a689acdf309e2a802f8ff5ac1951bcc02332`.
Only `/system/etc/healthshim.jar` was replaced; root was returned to read-only.
Restarting only `healthshim` updated Android to **100% Full**, matching kernel
capacity 100 and status Full. Android remained boot-complete; no reboot occurred.
The original JAR and installation receipt are retained privately for rollback.
The earlier whole-image readback hash describes the image before this file fix.

No battery reset, calibration write or charging control change was performed.
Reported kernel SOC is not an independent measurement of physical battery health
or calibration. Discharge behavior across a real charge cycle remains untested.
