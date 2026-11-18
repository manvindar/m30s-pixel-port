#!/usr/bin/env python3
"""Publish only install downloads and corresponding kernel source/build files."""
import argparse
import hashlib
from pathlib import Path
import shutil

COMMON = {'system-a17-pixel.img.xz', 'vendor-a17.img.xz', 'vbmeta-disabled.img', 'IMAGE-SHA256SUMS'}
ASSETS = {
    'twrp': COMMON | {'boot-acpm-fixed.img', 'M30s-A17-TWRP-system-upgrade.zip',
                     'TWRP-INSTALL.md', 'kernel-source-acpm-fixed.tar.gz',
                     'kernel.config', 'kernel-provenance.json', 'KERNEL-BUILD.md'},
    'image': COMMON | {'boot-a17.img', 'FLASH.md'},
}


def select(source, destination, kind):
    names = ASSETS[kind]
    for name in names:
        path = source / name
        if not path.is_file():
            raise RuntimeError('Missing public install asset: ' + name)
        if path.stat().st_size >= 2_000_000_000:
            raise RuntimeError('Asset exceeds single-file limit; never split: ' + name)
    destination.mkdir(exist_ok=False)
    rows = []
    for name in sorted(names):
        shutil.copy2(source / name, destination / name)
        with (destination / name).open('rb') as f:
            rows.append(hashlib.file_digest(f, 'sha256').hexdigest() + '  ' + name)
    (destination / 'SHA256SUMS').write_text('\n'.join(rows) + '\n')


if __name__ == '__main__':
    ap = argparse.ArgumentParser()
    ap.add_argument('source', type=Path)
    ap.add_argument('destination', type=Path)
    ap.add_argument('--kind', choices=ASSETS, required=True)
    args = ap.parse_args()
    select(args.source, args.destination, args.kind)
