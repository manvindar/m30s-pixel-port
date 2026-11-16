#!/usr/bin/env python3
"""Assemble a checked system-only TWRP ZIP from a successful exact CI candidate."""
import argparse
import hashlib
import json
import lzma
from pathlib import Path
import shutil
import zipfile

SYSTEM_BYTES = 5033164800
BOOT_SHA = '5219d618dad571438312ab1fcd62deaa9af17f3e49a48b70638bb9e817917426'


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''): h.update(block)
    return h.hexdigest()


def validate_receipts(candidate, source, run):
    build = json.loads((candidate / 'build-receipt.json').read_text())
    graphics = json.loads((candidate / 'graphics-compatibility-verification.json').read_text())
    if build['source_commit'] != source or build['actions_run'].rstrip('/').split('/')[-1] != str(run):
        raise RuntimeError('Candidate identity mismatch')
    if not build['experimental_dirty_flash'] or build['graphics_acceptance'] is not False:
        raise RuntimeError('Experimental disclosure mismatch')
    if graphics['status'] != 'experimental-mechanical-pass' or graphics['acceptance'] is not False:
        raise RuntimeError('Mechanical checks have not passed')
    if graphics.get('error') or build['system_bytes'] != SYSTEM_BYTES:
        raise RuntimeError('Invalid mechanical receipt or geometry')
    return build, graphics


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('candidate', type=Path); ap.add_argument('boot', type=Path); ap.add_argument('output', type=Path)
    ap.add_argument('--source', required=True); ap.add_argument('--run', required=True)
    args = ap.parse_args(); c = args.candidate
    build, graphics = validate_receipts(c, args.source, args.run)
    # Verify every original distributed candidate file before repackaging.
    for line in (c / 'SHA256SUMS').read_text().splitlines():
        expected, name = line.split(maxsplit=1); name = name.lstrip('*')
        if Path(name).name != name or digest(c / name) != expected:
            raise RuntimeError('Candidate download hash mismatch: ' + name)
    if args.boot.stat().st_size != 57671680 or digest(args.boot) != BOOT_SHA:
        raise RuntimeError('Verified ACPM-fixed boot identity mismatch')
    raw_hashes = dict((name.lstrip('*'), h) for h, name in
                      (line.split(maxsplit=1) for line in (c / 'IMAGE-SHA256SUMS').read_text().splitlines()))
    expected = raw_hashes['system-a17-pixel.img']
    parts = sorted(c.glob('system-a17-pixel.img.xz.part-*'))
    if not parts or [p.name.rsplit('-', 1)[-1] for p in parts] != [f'{i:02d}' for i in range(len(parts))]:
        raise RuntimeError('Missing/out-of-order system parts')
    args.output.mkdir(exist_ok=False)
    out = args.output
    packed = out / 'system.img.xz'
    with packed.open('wb') as dst:
        for p in parts:
            with p.open('rb') as src: shutil.copyfileobj(src, dst)
    size = 0; h = hashlib.sha256()
    with lzma.open(packed, 'rb') as src:
        for block in iter(lambda: src.read(1024 * 1024), b''):
            size += len(block); h.update(block)
    if size != SYSTEM_BYTES or h.hexdigest() != expected:
        raise RuntimeError('Complete decompressed system identity mismatch')
    if packed.stat().st_size >= 2**32:
        raise RuntimeError('Compressed system exceeds recovery ZIP32 limit')
    archive = out / 'M30s-A17-TWRP-system-upgrade.zip'
    with zipfile.ZipFile(archive, 'w', allowZip64=False) as z:
        script = Path(__file__).with_name('twrp-system-update.sh')
        info = zipfile.ZipInfo('META-INF/com/google/android/update-binary'); info.external_attr = 0o100755 << 16
        z.writestr(info, script.read_bytes())
        z.writestr('META-INF/com/google/android/updater-script', '# Handled by guarded update-binary\n')
        z.writestr('system.sha256', expected + '\n')
        z.write(packed, 'system.img.xz', compress_type=zipfile.ZIP_STORED)
    with zipfile.ZipFile(archive) as z:
        if z.testzip() is not None: raise RuntimeError('TWRP archive CRC failure')
    # Raw system is obtained by xz -dc; retain original download parts under 2 GiB.
    packed.unlink()
    for p in parts: shutil.copy2(p, out / p.name)
    shutil.copy2(args.boot, out / 'boot-acpm-fixed.img')
    for name in ['vendor-a17.img.xz', 'vbmeta-disabled.img', 'build-receipt.json',
                 'graphics-compatibility-verification.json', 'image-fixes-verification.json',
                 'system-readback-manifest.json']:
        shutil.copy2(c / name, out / name)
    (out / 'IMAGE-SHA256SUMS').write_text(f'{expected}  system-a17-pixel.img\n' +
        f"{raw_hashes['vendor-a17.img']}  vendor-a17.img\n" + f'{BOOT_SHA}  boot-acpm-fixed.img\n' +
        f"{raw_hashes['vbmeta-disabled.img']}  vbmeta-disabled.img\n")
    if archive.stat().st_size >= 2_000_000_000:
        with archive.open('rb') as src:
            i = 0
            while data := src.read(1900 * 1024 * 1024):
                (out / (archive.name + f'.part-{i:02d}')).write_bytes(data); i += 1
        archive.unlink()
    (out / 'package-receipt.json').write_text(json.dumps({
        'source_commit': args.source, 'actions_run': args.run, 'system_sha256': expected,
        'system_bytes': size, 'boot_sha256': BOOT_SHA, 'graphics_acceptance': False,
        'exact_rebuilt_system_device_tested': False, 'twrp_installer_device_tested': False,
        'installer_scope': 'system-only; preserves boot/vendor/data; never auto-reboots',
        'unreviewed_caller_count': graphics['unreviewed_caller_count']}, indent=2) + '\n')


if __name__ == '__main__': main()
