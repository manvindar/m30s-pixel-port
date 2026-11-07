#!/usr/bin/env python3
"""Derive build_a17.py (Galaxy M30s, SM-M307F) from the tablet's build_image17.py by exact text substitutions.
The tablet repo (~/Aistuff/tb-x606v-android17, read-only) stays the source of the patch tools (its tools/ dir); only the builder is forked here.
usage: make_build_a17.py [TABLET_REPO] > build_a17.py      (every substitution asserts that its anchor exists, so a changed upstream fails loudly)"""
import os, sys
repo = os.path.expanduser(sys.argv[1] if len(sys.argv) > 1 else '~/Aistuff/tb-x606v-android17')
s = open(os.path.join(repo, 'build', 'build_image17.py')).read()
n = 0
def sub(old, new, count=1):
    global s, n
    assert s.count(old) >= 1, 'anchor not found: ' + old[:80]
    s = s.replace(old, new) if count == 0 else s.replace(old, new, count); n += 1

sub('"""Android 17 (Google aosp_arm64 GSI DP11.261002.005) -> TB-X606V system image: every change that was applied to the tested tablet, rebuilt offline.',
    '"""Android 17 (Google aosp_arm64 GSI DP11.261016.003) -> Galaxy M30s (SM-M307F) system image. FORKED from the tablet builder by tools/img/make_build_a17.py (do not edit by hand).\nDifferences from the tablet: 4800 MiB partition, VNDK v30 + SELinux mapping 30.0 (from the Android 14 GSI, --vndk-dir) for the Android 11 Samsung vendor, Samsung identity props,\nno ROM Tuner (MediaTek only), no lights/vibrator shims in this first image (health shim kept), Bluetooth class of device of a phone.\nOriginal doc follows.\n\n(tablet text) Android 17 -> TB-X606V system image: every change that was applied to the tested tablet, rebuilt offline.')
sub("HERE = os.path.dirname(os.path.abspath(__file__)); TOOLS = os.path.join(HERE, '..', 'tools')",
    "HERE = os.path.dirname(os.path.abspath(__file__)); TOOLS = os.environ.get('A17_TOOLS') or os.path.expanduser('~/Aistuff/tb-x606v-android17/tools')")
sub("ap.add_argument('--out', required=True);",
    "ap.add_argument('--vndk-dir', required=True, help='dir with com.android.vndk.v30.apex, 30.0.cil, 30.0.compat.cil (from the Android 14 GSI)')\nap.add_argument('--out', required=True);")
sub("ap.add_argument('--no-tuner', action='store_true');", "ap.add_argument('--no-tuner', action='store_true', default=True);")
sub('PART = 0xf3800000', 'PART = 5033164800                                              # 4800 MiB: the M30s system partition')
sub('1  grow to the 0xf3800000-byte partition', '1  grow to the 5033164800-byte partition')

# step 2: properties
sub("bp += 'persist.vendor.sys.pq.shp.idx=0\\n'     # MediaTek sharpening off by default: it makes video look worse (ROM Tuner > Picture quality changes it)\n", '')
sub("bp += 'persist.sysui.disableBlur=1\\n'     # window blur (Pixel Launcher drawer, shade) drops the GE8320 to ~17 fps: 72% janky frames with blur, 5% without\n",
    "bp += 'persist.sysui.disableBlur=1\\n'     # kept from the tablet: blur is expensive on a mid-range GPU (Mali-G72 here is untested)\n")
i = s.index("# stock-looking fingerprint assembled"); j = s.index("# the GSI ships no bluetooth.mk properties")
s = s[:i] + ("# the phone's real stock identity (vendor props of M307FXXS4CWC2)\n"
             "bp += ('ro.build.fingerprint=samsung/m30sdd/m30s:11/RP1A.200720.012/M307FXXS4CWC2:user/release-keys\\n'\n"
             "       'ro.build.description=m30sdd-user 11 RP1A.200720.012 M307FXXS4CWC2 release-keys\\n')\n") + s[j:]
sub("bluetooth.device.class_of_device=90,2,12", "bluetooth.device.class_of_device=5a,02,0c")
sub("Tablet without telephony or LE Audio.", "Phone (class of device 0x5a020c); LE Audio left off.")
sub("(('brand', 'Lenovo'), ('device', 'achilles6_row_call'), ('manufacturer', 'LENOVO'), ('model', 'Lenovo TB-X606V'), ('name', 'full_achilles6_row_call'))",
    "(('brand', 'samsung'), ('device', 'm30s'), ('manufacturer', 'samsung'), ('model', 'SM-M307F'), ('name', 'm30sdd'))")
sub("# the tablet reports its real identity", "# the phone reports its real identity")

# step 4: VNDK 30 from --vndk-dir
sub("vndk = cat(a.donor, '/system/system_ext/apex/com.android.vndk.v29.apex'); assert len(vndk) > 50_000_000",
    "vndk = open(os.path.join(a.vndk_dir, 'com.android.vndk.v30.apex'), 'rb').read(); assert len(vndk) > 50_000_000")
sub("put(tmpf('vndk29.apex', vndk), '/system/system_ext/apex/com.android.vndk.v29.apex', '644')", "put(tmpf('vndk30.apex', vndk), '/system/system_ext/apex/com.android.vndk.v30.apex', '644')")
sub("looks for passthrough HALs in /system/lib64/vndk-sp-29/hw", "looks for passthrough HALs in /system/lib64/vndk-sp-30/hw")
sub("symlink('/system/lib64/vndk-sp-29', '/apex/com.android.vndk.v29/lib64'); symlink('/system/lib/vndk-sp-29', '/apex/com.android.vndk.v29/lib')",
    "symlink('/system/lib64/vndk-sp-30', '/apex/com.android.vndk.v30/lib64'); symlink('/system/lib/vndk-sp-30', '/apex/com.android.vndk.v30/lib')")
sub("print(f'  mapping 29.0:", "print(f'  mapping 30.0:")
sub("put(tmpf('map29.cil', prune(cat(a.donor, '/system/etc/selinux/mapping/29.0.cil').decode('latin1'))), '/system/etc/selinux/mapping/29.0.cil', '644')",
    "put(tmpf('map30.cil', prune(open(os.path.join(a.vndk_dir, '30.0.cil'), encoding='latin1').read())), '/system/etc/selinux/mapping/30.0.cil', '644')")
sub("put(tmpf('map29c.cil', cat(a.donor, '/system/etc/selinux/mapping/29.0.compat.cil')), '/system/etc/selinux/mapping/29.0.compat.cil', '644')",
    "put(os.path.join(a.vndk_dir, '30.0.compat.cil'), '/system/etc/selinux/mapping/30.0.compat.cil', '644')")
sub("('/system/system_ext/etc/selinux/mapping/29.0.cil', '/system/system_ext/etc/selinux/mapping/29.0.compat.cil', '/system/product/etc/selinux/mapping/29.0.cil')",
    "('/system/system_ext/etc/selinux/mapping/30.0.cil', '/system/system_ext/etc/selinux/mapping/30.0.compat.cil', '/system/product/etc/selinux/mapping/30.0.cil')")
sub("print('4 vndk 29, selinux mapping, cgroups')", "print('4 vndk 30, selinux mapping, cgroups')")

# step 8: no lights / vibrator shims in the first image
i = s.index("run('sh', os.path.join(TOOLS, 'lights', 'build.sh')"); j = s.index("# health: same pattern")
s = s[:i] + "# lights and vibrator shims: not in the first M30s image (see docs/phase3prep/A17-BUILD.md); health shim below is kept\n" + s[j:]
open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'build_a17.py'), 'w').write(s)
print(f'build_a17.py written, {n} substitutions', file=sys.stderr)
