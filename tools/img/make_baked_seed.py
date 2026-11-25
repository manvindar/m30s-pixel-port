#!/usr/bin/env python3
"""Step 1 of the baked precompiled apps design: compile on the phone and pull the result as a seed for build_a17.py --baked-oat.

usage: make_baked_seed.py --out DIR [--adb PATH] [-s SERIAL] [--no-compile] PACKAGE...
ART Service writes the output of a system app to /data/dalvik-cache/arm64/<apk path with @>@classes.{dex,vdex} (measured on v0.8, 2026-11-25), or has it already
in <app dir>/oat/arm64/ when a seed was baked. Both are the same oat/vdex pair; the seed stores them as DIR/<app dir>/oat/arm64/<apk>.{odex,vdex}
and DIR/manifest.json, which verify_baked_oat.py checks against the image. Only apps whose APK is in /system, /system_ext or /product can be baked.
Compiling restarts nothing by itself, but it loads the CPU (SystemUI and Settings about 2 to 3 minutes each); tell the owner before running a long list."""
import argparse, hashlib, json, os, subprocess, sys

ap = argparse.ArgumentParser(); ap.add_argument('--out', required=True); ap.add_argument('--adb', default='adb'); ap.add_argument('-s', dest='serial')
ap.add_argument('--no-compile', action='store_true', help='pull what is already compiled'); ap.add_argument('packages', nargs='+')
a = ap.parse_args(); ADB = [a.adb] + (['-s', a.serial] if a.serial else [])
def sh(cmd): return subprocess.run(ADB + ['shell', cmd], capture_output=True, text=True).stdout.strip()     # no check: ls of a missing file is a normal answer
def pull(remote, local):
    os.makedirs(os.path.dirname(local), exist_ok=True); subprocess.run(ADB + ['pull', remote, local], capture_output=True, check=True)

manifest = {'android_build': sh('getprop ro.build.id'), 'fingerprint': sh('getprop ro.system.build.fingerprint'), 'apps': []}
for pkg in a.packages:
    apk = sh(f'pm path {pkg}').splitlines()[0].removeprefix('package:')
    if not apk.startswith(('/system/', '/system_ext/', '/product/')): sys.exit(f'{pkg}: {apk} is not in the image (updated from Play?), nothing to bake')
    if not a.no_compile: print(pkg, sh(f'cmd package compile -m speed -f {pkg}'))
    d, base = os.path.split(apk); base = base[:-4]; cache = '/data/dalvik-cache/arm64/' + apk.lstrip('/').replace('/', '@') + '@classes'
    src = {'odex': cache + '.dex', 'vdex': cache + '.vdex'}
    if sh(f'ls {src["odex"]} 2>/dev/null'): pass
    elif sh(f'ls {d}/oat/arm64/{base}.odex 2>/dev/null'): src = {e: f'{d}/oat/arm64/{base}.{e}' for e in src}
    else: sys.exit(f'{pkg}: no compiled output in dalvik-cache or {d}/oat/arm64')
    status = sh(f'cmd package dump {pkg}')
    if 'status=speed' not in status.split('Dexopt state', 1)[-1][:600]: sys.exit(f'{pkg}: not status=speed after the compile')
    entry = {'pkg': pkg, 'apk': apk, 'sha256': {}, 'size': {}}
    for ext, remote in src.items():
        local = os.path.join(a.out, d.lstrip('/'), 'oat', 'arm64', f'{base}.{ext}'); pull(remote, local)
        b = open(local, 'rb').read(); entry['sha256'][ext] = hashlib.sha256(b).hexdigest(); entry['size'][ext] = len(b)
    manifest['apps'].append(entry); print(pkg, 'odex %.1f MB vdex %.1f MB' % (entry['size']['odex'] / 2**20, entry['size']['vdex'] / 2**20))
os.makedirs(a.out, exist_ok=True); json.dump(manifest, open(os.path.join(a.out, 'manifest.json'), 'w'), indent=1)
print('total %.1f MB' % (sum(sum(e['size'].values()) for e in manifest['apps']) / 2**20))
