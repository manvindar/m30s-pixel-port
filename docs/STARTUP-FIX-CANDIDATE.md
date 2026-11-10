# Pixel startup helper candidate

The automatic compilation job currently restarts SystemUI and Pixel Launcher after compiling the visible apps. That interruption can happen during setup. This candidate keeps compilation and cache selection unchanged but makes the restart explicit: automatic runs do not restart the interface; the existing manual Precompile apps request opts in.

The sensor helper also places a shell loop containing $c directly in an init service argument. Android init attempts property expansion before executing the shell; the captured error names the property c; done, followed by the nosensorhog child aborting. The candidate moves exactly the existing sleep and three Personal Safety component commands into a shell file. The service remains shell UID/group, u:r:shell:s0, disabled and oneshot, with the same boot-complete trigger.

## Image footprint

- Replace /system/etc/init/06_nosensorhog.rc and add /system/bin/nosensorhog.sh (0755).
- Replace /system/bin/dexopt_all.sh from a local M30s override (0755).
- Replace /system/etc/init/04_precompile.rc to opt the manual request into one UI restart.
- Update both the checked-in builder and generator to stage the local overrides.
- The firstboot launcher, .dexopt_done marker, two-pass schedule, forced compile semantics, permission/location logic, cache-selection code and unrelated image files are unchanged.

The dexopt override descends from workflow-pinned tablet commit 44cde4e25a160d95900ad12e3415b5527792be06; the original script SHA-256 is 984ff2105a3f33fc6ab9bc4cab9375a209a33e2655a628ae53262920e990297c. Only its UI restart guard and explanatory comments change.

## Host verification and limits

Eight host regressions pass with no skips. Fake pm, cmd, sleep and killall commands exercise the actual shell scripts without a phone or real compilation. Checks cover automatic versus explicit restart, existing forced-compile behavior, exact three component commands, and actual generated/check-in image staging paths. The original automatic script reproduces the unwanted restart regression.

No image was assembled and no Android operation was performed. The tests do not establish Android init execution, SELinux/domain behavior, compiled-code uptake or device persistence. Deferring an automatic restart leaves existing processes using their current mapped code until a natural restart; this trades immediate code uptake for preserving the visible session. The later TensorFlow Lite SIGILL crash is a separate gesture-model fault and is not fixed here.

The public baseline generator already differs from its checked-in builder: a regeneration drops fingerprint staging and one later face-feature cleanup block. This candidate preserves the checked-in blocks, changes only startup-specific anchors, and verifies generator startup wiring in a temporary directory. It does not repair or accept full-image regeneration equivalence; future publication must preserve those existing unrelated blocks.
