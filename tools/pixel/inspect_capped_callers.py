#!/usr/bin/env python3
"""Retrieve exact capped final callers and inspect existing frozen libsync providers."""
import json
import lzma
from pathlib import Path
import shutil
import sys
import tempfile
import zipfile
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'graphics'))
from common import apex_manifest, digest, dump, elf, run, unpack_apex
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'downloads'))
from verified_input import obtain

A14 = {'url': 'https://github.com/naz664/crDroid_gsi/releases/download/v2025.03.08/crDroid-10.13-arm64_bgN-slim-Unofficial.img.xz',
       'sha256': '0a403c4de120adbb15e7219f7c2acc59337e6d7fc995eaf4ace7e9267e25a0dc'}


def main():
    pins = json.loads(Path('docs/A17-UPSTREAM.json').read_text())
    targets = json.loads(Path('tools/graphics/capped-callers.json').read_text())
    out = Path('capped-caller-evidence'); out.mkdir(exist_ok=False)
    receipt = {'reference_run': targets['run'], 'callers': [], 'sync_providers': [], 'absences': [], 'apex_manifests': {}, 'acceptance': False}
    total = 0
    with tempfile.TemporaryDirectory() as scratch:
        tmp = Path(scratch)
        for label, pin, cache in [('latest', pins['gsi'], Path('download-cache/gsi/gsi.zip')),
                                  ('a14', A14, Path('download-cache/a14/crdroid.img.xz'))]:
            obtain(pin['url'], pin['sha256'], cache)
            image = tmp / (label + '.img')
            if label == 'latest':
                with zipfile.ZipFile(cache) as z:
                    names = [n for n in z.namelist() if Path(n).name == 'system.img']
                    if len(names) != 1: raise RuntimeError('Ambiguous GSI image')
                    with z.open(names[0]) as src, image.open('wb') as dst: shutil.copyfileobj(src, dst)
            else:
                with lzma.open(cache) as src, image.open('wb') as dst: shutil.copyfileobj(src, dst)
            if image.open('rb').read(4) == bytes.fromhex('3aff26ed'): raise RuntimeError('Unexpected sparse input')
            contexts = {}
            for row in targets['targets']:
                if (row['context'] == 'com.android.vndk.v30') != (label == 'a14'): continue
                context = row['context']
                if context == 'system':
                    fs, path = image, row['file']
                else:
                    if context not in contexts:
                        remote = ('/system/apex/com.android.media.swcodec.capex' if context == 'com.android.media.swcodec'
                                  else targets['apex_paths'][context])
                        package = dump(image, remote, tmp / (context + '-' + label + '.apex'))
                        _, payload, manifest_file = unpack_apex(package, tmp / (context + '-' + label))
                        manifest = apex_manifest(manifest_file)
                        if manifest['name'] != context: raise RuntimeError('APEX name mismatch')
                        contexts[context] = payload; receipt['apex_manifests'][context] = manifest
                    fs = contexts[context]; path = row['file'].removeprefix('/apex/' + context)
                target = dump(fs, path, out / 'callers' / (row['sha256'] + '.elf'))
                if digest(target) != row['sha256'] or target.stat().st_size != row['bytes']:
                    raise RuntimeError('Extracted source does not match exact final caller: ' + row['file'])
                total += target.stat().st_size
                if total > 64 * 1024 ** 2: raise RuntimeError('Caller evidence exceeds64MiB bound')
                receipt['callers'].append(dict(row, evidence_file=str(target.relative_to(out)), input=pin))
            for context, payload in contexts.items():
                if not context.startswith('com.android.vndk.'): continue
                for directory in ('lib64', 'lib'):
                    remote = '/' + directory + '/libsync.so'
                    stat = run('debugfs', '-R', 'stat ' + remote, payload)
                    if 'Inode:' not in stat:
                        receipt['absences'].append({'context': context, 'file': remote, 'stat': stat})
                        continue
                    target = dump(payload, remote, out / 'providers' / context / directory / 'libsync.so')
                    metadata = elf(target)
                    if metadata is None: raise RuntimeError('Invalid provider ELF')
                    (target.parent / 'versions.txt').write_text(run('readelf', '-d', '-V', target))
                    (target.parent / 'symbols.txt').write_text(metadata['symbol_table_text'])
                    receipt['sync_providers'].append({'context': context, 'abi': metadata['abi'], 'input': pin,
                        'file': str(target.relative_to(out)), 'sha256': digest(target), 'bytes': target.stat().st_size,
                        'exports': sorted(metadata['exports']), 'imports': sorted(metadata['imports']), 'needed': metadata['needed']})
            image.unlink()  # ephemeral runner only, after exact evidence extraction
    if len(receipt['callers']) != len(targets['targets']): raise RuntimeError('Incomplete caller extraction')
    (out / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')


if __name__ == '__main__': main()
