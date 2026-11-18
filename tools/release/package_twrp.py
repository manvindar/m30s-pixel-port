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
RELEASE_FILE_LIMIT = 2_000_000_000  # conservative GitHub single-asset ceiling; never split
BOOT_SHA = '5219d618dad571438312ab1fcd62deaa9af17f3e49a48b70638bb9e817917426'


def digest(path):
    h = hashlib.sha256()
    with path.open('rb') as f:
        for block in iter(lambda: f.read(1024 * 1024), b''): h.update(block)
    return h.hexdigest()


def verify_zip_system(z, expected, expected_bytes=SYSTEM_BYTES):
    """The system stream embedded in the TWRP ZIP must decompress to exactly the expected length and hash."""
    if z.read('system.sha256').decode().strip() != expected: raise RuntimeError('ZIP system.sha256 differs from the image hash')
    size = 0; h = hashlib.sha256()
    with z.open('system.img.xz') as raw, lzma.open(raw, 'rb') as src:
        for block in iter(lambda: src.read(1024 * 1024), b''):
            size += len(block); h.update(block)
    if size != expected_bytes or h.hexdigest() != expected: raise RuntimeError('Embedded ZIP system stream is incomplete or differs')


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


def validate_system_archive(path, expected_hash, expected_bytes=SYSTEM_BYTES):
    if path.stat().st_size >= RELEASE_FILE_LIMIT:
        raise RuntimeError('Complete System archive exceeds single-file release limit; recompress, never split')
    size = 0; h = hashlib.sha256()
    with lzma.open(path, 'rb') as src:
        for block in iter(lambda: src.read(1024 * 1024), b''):
            size += len(block); h.update(block)
    if size != expected_bytes or h.hexdigest() != expected_hash:
        raise RuntimeError('Complete decompressed system identity mismatch')
    return size


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('candidate', type=Path); ap.add_argument('boot', type=Path); ap.add_argument('output', type=Path)
    ap.add_argument('--source', required=True); ap.add_argument('--run', required=True)
    args = ap.parse_args(); c = args.candidate
    build, graphics = validate_receipts(c, args.source, args.run)
    fixes = json.loads((c / 'm30s-fixes-verification.json').read_text())
    if fixes['status'] != 'complete-image-readback-pass' or len(fixes['files']) != 5:
        raise RuntimeError('Integrated battery/tuner final readback missing')
    tablet_rows = [r for r in fixes['files'] if r['path'] == '/system/app/TabletRomTuner/TabletRomTuner.apk']
    if len(tablet_rows) != 1 or tablet_rows[0]['sha256'] != '6a9bc65cfde17e49292d802ec383cf3de1a79e6506fa9e2d2d368375b9a07eae':
        raise RuntimeError('Matching-signed tablet APK final identity mismatch')
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
    source_archive = c / 'system-a17-pixel.img.xz'
    if any(c.glob('system-a17-pixel.img.xz.part-*')):
        raise RuntimeError('Split System files are unsupported; provide one complete .xz archive')
    size = validate_system_archive(source_archive, expected)
    args.output.mkdir(exist_ok=False)
    out = args.output
    packed = out / 'system-a17-pixel.img.xz'
    shutil.copy2(source_archive, packed)
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
        verify_zip_system(z, expected)
    # Retain the complete archive beside the complete ZIP; neither is split.
    shutil.copy2(args.boot, out / 'boot-acpm-fixed.img')
    for name in ['vendor-a17.img.xz', 'vbmeta-disabled.img', 'build-receipt.json',
                 'graphics-compatibility-verification.json', 'image-fixes-verification.json', 'm30s-fixes-verification.json',
                 'system-readback-manifest.json']:
        shutil.copy2(c / name, out / name)
    (out / 'IMAGE-SHA256SUMS').write_text(f'{expected}  system-a17-pixel.img\n' +
        f"{raw_hashes['vendor-a17.img']}  vendor-a17.img\n" + f'{BOOT_SHA}  boot-acpm-fixed.img\n' +
        f"{raw_hashes['vbmeta-disabled.img']}  vbmeta-disabled.img\n")
    archive_sha = digest(archive)
    if archive.stat().st_size >= RELEASE_FILE_LIMIT:
        raise RuntimeError('Complete TWRP ZIP exceeds single-file release limit; recompress System, never split')
    (out / 'package-receipt.json').write_text(json.dumps({
        'source_commit': args.source, 'actions_run': args.run, 'system_sha256': expected,
        'complete_reconstructed_twrp_zip_sha256': archive_sha,
        'system_bytes': size, 'boot_sha256': BOOT_SHA, 'graphics_acceptance': False,
        'ci_profile1_boot_replaced': True, 'original_ci_boot_sha256': raw_hashes['boot-a17.img'],
        'build_receipt_scope': 'Original CI System/Vendor/VBMETA; CI baseline Boot replaced by separately verified fixed Boot',
        'final_kernel_provenance': 'kernel-provenance.json',
        'exact_rebuilt_system_device_tested': False, 'twrp_installer_device_tested': False,
        'installer_scope': 'system-only; preserves boot/vendor/data; never auto-reboots',
        'unreviewed_caller_count': graphics['unreviewed_caller_count']}, indent=2) + '\n')


if __name__ == '__main__': main()
