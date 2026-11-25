#!/usr/bin/env python3
"""Fails when a baked-oat seed (docs/superpowers/specs/2026-11-25-baked-precompiled-apps-design.md) does not belong to the image it goes into.

usage: verify_baked_oat.py --seed DIR --image system.img [--e2fs DIR]
Per app in DIR/manifest.json ({"android_build": ..., "apps": [{"apk": "/system/.../X.apk"}, ...]}; files at DIR/<apk dir>/oat/arm64/X.{odex,vdex}):
  1. the file hashes in the manifest match the files (a damaged download is caught);
  2. the dex CRCs in X.vdex equal the CRCs of the classes*.dex entries of the APK that is in the image;
  3. the boot class path dex CRCs recorded in X.odex are exactly those of the image's own boot image (/system/framework/boot*.vdex, checksum ^ 1).
ART ignores an oat file that fails 2 or 3 and the phone would silently run it interpreted, so the build stops instead.
ponytail: 3 compares sets, not order; oat version 291 (Android 17) and vdex 027 only, any other version fails loudly."""
import argparse, hashlib, io, json, os, re, struct, subprocess, sys, zipfile

OAT_VERSION = b'291\0'; KVS_SIZE_OFF = 72        # oat header words for version 291: key_value_store_size at +72, the store follows at +76


def vdex_checksums(b):
    """dex location checksums of a vdex 027: 4 section headers (kind, offset, size) after the 12-byte header; kind 0 is the checksum section."""
    if b[:8] != b'vdex027\0': sys.exit(f'unsupported vdex header {b[:8]!r}')
    n, = struct.unpack_from('<I', b, 8)
    for i in range(n):
        kind, off, size = struct.unpack_from('<3I', b, 12 + 12 * i)
        if kind == 0: return list(struct.unpack_from('<%dI' % (size // 4), b, off))
    sys.exit('vdex has no checksum section')


def oat_bcp_checksums(b):
    """(compiler filter, boot class path dex CRCs) from the key/value store in the oat header of an .odex (an ELF with the oat data at 0x1000-aligned oatdata)."""
    o = b.find(b'oat\n')
    if o < 0: sys.exit('no oat header in the .odex')
    if b[o + 4:o + 8] != OAT_VERSION: sys.exit(f'unsupported oat version {b[o + 4:o + 8]!r}')
    n, = struct.unpack_from('<I', b, o + KVS_SIZE_OFF)
    kv = b[o + KVS_SIZE_OFF + 4:o + KVS_SIZE_OFF + 4 + n].split(b'\0')
    d = {k: v for k, v in zip(kv[0::2], kv[1::2]) if k}
    sums = d.get(b'bootclasspath-checksums', b'').decode()
    if not sums or any(not re.fullmatch(r'd/[0-9a-f]{1,8}', p) for p in sums.split(':')): sys.exit(f'unexpected bootclasspath-checksums {sums[:80]!r}')
    return d[b'compiler-filter'].decode(), [int(p[2:], 16) for p in sums.split(':')]


def apk_crcs(apk):
    z = zipfile.ZipFile(io.BytesIO(apk)); names = ['classes.dex'] + ['classes%d.dex' % i for i in range(2, 100)]
    return [z.getinfo(x).CRC for x in names if x in z.namelist()]


def check_app(seed, app, read, boot_crcs):
    """list of problems for one manifest entry; read(path) returns the bytes of a file in the image"""
    apk = app['apk']; d, base = os.path.split(apk); base = base[:-4]; bad = []
    files = {}
    for ext in ('odex', 'vdex'):
        p = os.path.join(seed, d.lstrip('/'), 'oat', 'arm64', f'{base}.{ext}')
        if not os.path.isfile(p): return [f'{apk}: {p} is missing']
        files[ext] = open(p, 'rb').read()
        if hashlib.sha256(files[ext]).hexdigest() != app['sha256'][ext]: bad.append(f'{apk}: {base}.{ext} differs from the manifest sha256')
    have, want = vdex_checksums(files['vdex']), apk_crcs(read(apk))
    if have != want: bad.append(f'{apk}: baked for another APK (vdex dex CRCs {[hex(x) for x in have]}, APK in the image {[hex(x) for x in want]})')
    _, bcp = oat_bcp_checksums(files['odex'])
    if set(bcp) != boot_crcs: bad.append(f'{apk}: baked against another boot image ({len(set(bcp) ^ boot_crcs)} of {len(boot_crcs)} boot class path CRCs differ)')
    return bad


def verify(seed, read, boot_vdex_paths):
    m = json.load(open(os.path.join(seed, 'manifest.json'))); boot = {c ^ 1 for p in boot_vdex_paths for c in vdex_checksums(read(p))}     # ART sets the low bit of a boot vdex checksum (measured: all 53 equal bcp ^ 1)
    return [x for app in m['apps'] for x in check_app(seed, app, read, boot)]


def main():
    ap = argparse.ArgumentParser(); ap.add_argument('--seed', required=True); ap.add_argument('--image', required=True); ap.add_argument('--e2fs')
    a = ap.parse_args(); dbgfs = os.path.join(a.e2fs, 'debugfs') if a.e2fs else 'debugfs'
    def read(path):
        r = subprocess.run([dbgfs, '-R', f'cat {path}', a.image], capture_output=True).stdout
        if not r: sys.exit(f'{path} not found in {a.image}')
        return r
    ls = subprocess.run([dbgfs, '-R', 'ls -p /system/framework', a.image], capture_output=True).stdout.decode('latin1')
    boot = ['/system/framework/' + f for f in (l.split('/')[5] for l in ls.splitlines() if len(l.split('/')) > 5) if re.fullmatch(r'boot(-.*)?\.vdex', f)]
    if not boot: sys.exit('no boot*.vdex in /system/framework of the image')     # /system/framework/arm64/boot*.vdex are symlinks to these
    bad = verify(a.seed, read, boot)
    for b in bad: print('FAIL', b)
    if bad: sys.exit(1)
    print('baked oat OK:', len(json.load(open(os.path.join(a.seed, 'manifest.json')))['apps']), 'apps')

if __name__ == '__main__': main()
