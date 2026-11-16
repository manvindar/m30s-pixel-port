#!/usr/bin/env python3
"""Pinned swcodec ownership providers; no final-image or runtime acceptance."""
import json
from pathlib import Path
import shutil
import sys
import tempfile
import zipfile
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'graphics'))
from common import apex_manifest, digest, dump, elf, extract_fs, unpack_apex
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'downloads'))
from verified_input import obtain

CONTEXT = 'com.android.media.swcodec'
TARGETS = tuple((abi, '/' + directory + '/' + name)
                for abi, directory in [('arm32', 'lib'), ('arm64', 'lib64')]
                for name in ('libhidlbase.so', 'libcutils.so', 'libc++.so'))
FILE_CAP = 4 * 1024 ** 2
TOTAL_CAP = 16 * 1024 ** 2


def retain_provider(source, target, abi, total):
    source, target = Path(source), Path(target)
    if source.is_symlink() or not source.is_file() or not source.stat().st_size:
        raise RuntimeError('Missing, empty or nonregular required codec provider')
    size = source.stat().st_size
    if size > FILE_CAP or total + size > TOTAL_CAP:
        raise RuntimeError('Codec ownership provider exceeds evidence cap')
    metadata = elf(source)
    if metadata is None or metadata['abi'] != abi:
        raise RuntimeError('Required codec provider ABI mismatch')
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, target)
    if digest(target) != digest(source) or target.stat().st_size != size:
        raise RuntimeError('Codec provider retention readback mismatch')
    target.with_suffix('.symbols.txt').write_text(metadata['symbol_table_text'])
    return total + size, {'abi': abi, 'sha256': digest(target), 'bytes': size,
                         'needed': metadata['needed'], 'exports': sorted(metadata['exports']),
                         'imports': sorted(metadata['imports'])}


def require_space(directory, required, stage):
    free = shutil.disk_usage(directory).free
    if free < required: raise RuntimeError('Insufficient runner space: ' + stage)
    return {'stage': stage, 'free_bytes': free, 'required_bytes': required}


def complete_receipt(rows):
    expected = set(TARGETS)
    actual = [(r['abi'], r['source_path']) for r in rows]
    if len(actual) != len(expected) or set(actual) != expected:
        raise RuntimeError('Incomplete or duplicate codec ownership extraction')


def main():
    pin = json.loads(Path('docs/A17-UPSTREAM.json').read_text())['gsi']
    out = Path('codec-ownership-evidence'); out.mkdir(exist_ok=False)
    cache = Path('download-cache/gsi/gsi.zip')
    obtain(pin['url'], pin['sha256'], cache)
    rows = []; total = 0; space = []
    with tempfile.TemporaryDirectory(prefix='codec-ownership-') as scratch:
        tmp = Path(scratch); image = tmp / 'system.img'
        with zipfile.ZipFile(cache) as archive:
            members = [n for n in archive.namelist() if Path(n).name == 'system.img']
            if len(members) != 1: raise RuntimeError('Ambiguous pinned GSI image')
            image_size = archive.getinfo(members[0]).file_size
            space.append(require_space(tmp, 2 * image_size + 4 * 1024 ** 3, 'before pinned image and possible base decoding'))
            with archive.open(members[0]) as source, image.open('wb') as target:
                shutil.copyfileobj(source, target)
        with image.open('rb') as stream:
            if stream.read(4) == bytes.fromhex('3aff26ed'):
                raise RuntimeError('Unexpected sparse pinned GSI image')
            stream.seek(1080); base_ext4 = stream.read(2) == b'\x53\xef'
        remote = '/system/apex/com.android.media.swcodec.capex'
        if base_ext4:
            package = dump(image, remote, tmp / 'swcodec.capex')
        else:
            base = extract_fs(image, tmp / 'base-decoded')
            package = base / remote.lstrip('/')
            if package.is_symlink() or not package.is_file() or not package.stat().st_size:
                raise RuntimeError('Missing regular pinned swcodec package')
        original, payload, manifest_file = unpack_apex(package, tmp / 'swcodec')
        manifest = apex_manifest(manifest_file)
        if manifest['name'] != CONTEXT: raise RuntimeError('Codec APEX identity mismatch')
        with payload.open('rb') as stream:
            stream.seek(1080); ext4 = stream.read(2) == b'\x53\xef'
        space.append(require_space(tmp, (0 if ext4 else 2 * payload.stat().st_size) + 2 * 1024 ** 3, 'before codec provider extraction'))
        decoded = None if ext4 else extract_fs(payload, tmp / 'codec-decoded')
        for abi, path in TARGETS:
            source = (dump(payload, path, tmp / 'members' / path.lstrip('/')) if ext4
                      else decoded / path.lstrip('/'))
            target = out / path.lstrip('/')
            total, row = retain_provider(source, target, abi, total)
            rows.append(dict(row, source_path=path, evidence_file=str(target.relative_to(out))))
        complete_receipt(rows)
        receipt = {'input': pin, 'context': CONTEXT, 'apex_manifest': manifest,
                   'package_sha256': digest(package), 'original_apex_sha256': digest(original),
                   'payload_sha256': digest(payload), 'providers': rows, 'retained_bytes': total, 'runner_space': space,
                   'status': 'complete pinned source extraction', 'acceptance': False,
                   'final_provider_acceptance': False,
                   'limitations': ['Pinned base codec inputs, not final repacked APEX readback',
                                   'No provider symbol/interposition, namespace or process binding approval']}
        (out / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')


if __name__ == '__main__': main()
