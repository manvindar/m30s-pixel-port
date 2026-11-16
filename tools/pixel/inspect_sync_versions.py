#!/usr/bin/env python3
"""Measure pinned prior libsync definitions for the codec's exact LIBSYNC imports."""
import json
from pathlib import Path
import shutil
import sys
import tempfile
import zipfile
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'graphics'))
from common import digest, dump, elf, run, unpack_apex
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'downloads'))
from verified_input import obtain


def main():
    pins = json.loads(Path('docs/A17-UPSTREAM.json').read_text())['legacy_graphics']
    archive = Path('download-cache/graphics/gsi.zip')
    obtain(pins['url'], pins['sha256'], archive)
    out = Path('sync-version-evidence'); out.mkdir(exist_ok=False)
    records = []
    with tempfile.TemporaryDirectory() as scratch:
        tmp = Path(scratch); image = tmp / 'system.img'
        with zipfile.ZipFile(archive) as z:
            names = [n for n in z.namelist() if Path(n).name == 'system.img']
            if len(names) != 1: raise RuntimeError('Ambiguous graphics donor image')
            with z.open(names[0]) as src, image.open('wb') as dst: shutil.copyfileobj(src, dst)
        if image.open('rb').read(4) == bytes.fromhex('3aff26ed'): raise RuntimeError('Unexpected sparse donor')
        package = dump(image, '/system/apex/com.android.media.swcodec.capex', tmp / 'codec.capex')
        _, payload, _ = unpack_apex(package, tmp / 'codec')
        for context, fs, prefix in [('system', image, '/system'), ('codec', payload, '')]:
            for directory in ('lib64', 'lib'):
                target = dump(fs, prefix + '/' + directory + '/libsync.so', out / context / directory / 'libsync.so')
                metadata = elf(target)
                if metadata is None: raise RuntimeError('Invalid donor libsync ELF')
                (target.parent / 'symbols.txt').write_text(metadata['symbol_table_text'])
                (target.parent / 'dynamic-versions.txt').write_text(run('readelf', '-d', '-V', target))
                records.append({'context': context, 'abi': metadata['abi'], 'file': str(target.relative_to(out)),
                                'sha256': digest(target), 'bytes': target.stat().st_size,
                                'exports': sorted(metadata['exports']), 'imports': sorted(metadata['imports']), 'needed': metadata['needed']})
    (out / 'receipt.json').write_text(json.dumps({'input': pins, 'libraries': records,
        'purpose': 'Measure exact prior provider versions; no replacement or namespace/version exemption accepted'}, indent=2) + '\n')


if __name__ == '__main__': main()
