#!/sbin/sh
# Recovery installer: system only. Never formats data or touches other partitions.
set -eu
set -o pipefail
OUTFD=$2
ZIP=$3
ui() { printf 'ui_print %s\nui_print\n' "$*" > /proc/self/fd/$OUTFD; }
fail() { ui "ERROR: $*"; exit 1; }
[ "$(id -u)" = 0 ] || fail 'Recovery root required'
[ -n "$(getprop ro.twrp.version)" ] || [ "$(getprop ro.bootmode)" = recovery ] || fail 'TWRP/recovery required; never run in Android'
[ "$(getprop ro.product.device)" = m30s ] || fail 'Galaxy M30s recovery required'
SYSTEM=/dev/block/by-name/system
BOOT=/dev/block/by-name/boot
VENDOR=/dev/block/by-name/vendor
[ -b "$SYSTEM" ] && [ -b "$BOOT" ] && [ -b "$VENDOR" ] || fail 'Required partitions absent'
[ "$(blockdev --getsize64 "$SYSTEM")" = 5033164800 ] || fail 'System geometry differs'
[ -r /proc/mounts ] || fail 'Cannot inspect mounted partitions'
awk '$2=="/system" || $2=="/system_root" || ($2=="/" && $3=="ext4") {found=1} END {exit !found}' /proc/mounts && fail 'Unmount System/System Root before installing'
for part in "$SYSTEM"; do
    resolved=$(readlink -f "$part")
    awk -v a="$part" -v b="$resolved" '$1==a || $1==b {found=1} END {exit !found}' /proc/mounts && fail "Unmount $part before installing"
done
if command -v xz >/dev/null 2>&1; then
    decompress() { xz -dc; }
elif command -v busybox >/dev/null 2>&1 && busybox --list | grep -qx xzcat; then
    decompress() { busybox xzcat; }
else fail 'Recovery has no xz decoder; use the documented Install Image route'; fi
for cmd in unzip sha256sum dd head blockdev sync; do command -v "$cmd" >/dev/null 2>&1 || fail "Missing recovery command: $cmd"; done
expected=$(unzip -p "$ZIP" system.sha256)
case "$expected" in ''|*[!0-9a-f]*) fail 'Malformed system checksum';; esac
[ ${#expected} = 64 ] || fail 'Malformed system checksum'
ui 'Verifying complete system image before any write...'
actual=$(unzip -p "$ZIP" system.img.xz | decompress | sha256sum)
[ "${actual%% *}" = "$expected" ] || fail 'System image checksum mismatch'
boot_before=$(sha256sum "$BOOT"); vendor_before=$(sha256sum "$VENDOR")
[ "${boot_before%% *}" = 5219d618dad571438312ab1fcd62deaa9af17f3e49a48b70638bb9e817917426 ] || fail 'ACPM-fixed boot required; install supplied Boot separately, without a data wipe'
case "${vendor_before%% *}" in
    5cc3c84c90655d46d558b317cfadf4764211f56295da59904d5197c4c1f13e30|63548021f66206ce28fc1739eb157febcc0c456fe2e1e11886ec8fa782433646) ;;
    *) fail 'Unverified Vendor; use the documented compatible Vendor first';;
esac
ui 'Writing System only. Do not unplug or reboot.'
unzip -p "$ZIP" system.img.xz | decompress | dd of="$SYSTEM" bs=1048576 || fail 'Write interrupted; stay in recovery and restore/retry'
sync
ui 'Verifying complete system readback...'
actual=$(head -c 5033164800 "$SYSTEM" | sha256sum)
[ "${actual%% *}" = "$expected" ] || fail 'Readback mismatch; stay in recovery and restore/retry'
[ "$(sha256sum "$BOOT")" = "$boot_before" ] || fail 'Boot preservation mismatch'
[ "$(sha256sum "$VENDOR")" = "$vendor_before" ] || fail 'Vendor preservation mismatch'
ui 'System readback verified. Boot, vendor and data preserved.'
ui 'You may now choose Reboot System. Experimental compatibility limits remain.'
