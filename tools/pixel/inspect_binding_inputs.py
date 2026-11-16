#!/usr/bin/env python3
"""Bounded pinned-source evidence, explicitly not final image/runtime binding proof."""
import json
from pathlib import Path
import shutil
import sys
import tempfile
import zipfile
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'graphics'))
from common import digest, dump, elf, extract_fs, run
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'downloads'))
from verified_input import obtain


def main():
    pins = json.loads(Path('docs/A17-UPSTREAM.json').read_text())['gsi']
    out = Path('binding-input-evidence'); out.mkdir(exist_ok=False)
    cache = Path('download-cache/gsi/gsi.zip')
    obtain(pins['url'], pins['sha256'], cache)
    receipt = {'input': pins, 'files': [], 'absences': [], 'acceptance': False,
               'limitations': ['Pinned base inputs, not final staged image readback',
                               'Source audioserver.rc is modified by port staging',
                               'Runtime-generated linkerconfig and actual bindings remain unproven',
                               'Missing standalone linkerconfig is recorded, not replaced by an assumed init generator'],
               'binding_review_complete': False, 'generator_identified': False, 'directory_inventories': []}
    targets = [('/system/lib/libgralloctypes.so', True),
               ('/system/lib64/libgralloctypes.so', True),
               ('/system/bin/linkerconfig', False),
               ('/system/bin/init', True),
               ('/system/etc/linker.config.json', False),
               ('/system/etc/init/audioserver.rc', True),
               ('/system/build.prop', True),
               ('/system/etc/ld.config.txt', False),
               ('/system/etc/public.libraries.txt', False)]
    total = 0
    with tempfile.TemporaryDirectory(prefix='binding-inputs-') as scratch:
        tmp = Path(scratch); image = tmp / 'system.img'
        with zipfile.ZipFile(cache) as archive:
            names = [n for n in archive.namelist() if Path(n).name == 'system.img']
            if len(names) != 1:
                raise RuntimeError('Ambiguous pinned GSI image')
            with archive.open(names[0]) as src, image.open('wb') as dst:
                shutil.copyfileobj(src, dst)
        with image.open('rb') as stream:
            if stream.read(4) == bytes.fromhex('3aff26ed'):
                raise RuntimeError('Unexpected sparse pinned image')
            stream.seek(1080); ext4 = stream.read(2) == b'\x53\xef'
        decoded = None if ext4 else extract_fs(image, tmp / 'decoded')
        for directory in ('/system/bin', '/system/bin/bootstrap', '/system/apex'):
            if ext4:
                if 'Inode:' not in run('debugfs', '-R', 'stat ' + directory, image):
                    receipt['directory_inventories'].append({'path': directory, 'absent': True})
                    continue
                listing = run('debugfs', '-R', 'ls -p ' + directory, image)
            else:
                directory_path = decoded / directory.lstrip('/')
                if not directory_path.is_dir() or directory_path.is_symlink():
                    receipt['directory_inventories'].append({'path': directory, 'absent': True})
                    continue
                listing = '\n'.join(sorted(p.name for p in directory_path.iterdir()))
            if len(listing.encode()) > 512 * 1024:
                raise RuntimeError('Oversized bounded generator directory inventory')
            filename = directory.lstrip('/').replace('/', '-') + '.inventory.txt'
            (out / filename).write_text(listing)
            receipt['directory_inventories'].append({'path': directory, 'evidence_file': filename})
        for remote, required in targets:
            target = out / remote.lstrip('/')
            if ext4:
                present = 'Inode:' in run('debugfs', '-R', 'stat ' + remote, image)
                if present:
                    dump(image, remote, target)
            else:
                source = decoded / remote.lstrip('/')
                present = source.is_file() and not source.is_symlink()
                if present:
                    target.parent.mkdir(parents=True, exist_ok=True); shutil.copyfile(source, target)
            if not present:
                if required:
                    raise RuntimeError('Required binding input absent: ' + remote)
                receipt['absences'].append({'file': remote, 'observation': 'Absent from verified pinned source inventory'})
                continue
            size = target.stat().st_size
            if not size or size > 4 * 1024 ** 2:
                raise RuntimeError('Empty or oversized binding input: ' + remote)
            total += size
            if total > 16 * 1024 ** 2:
                raise RuntimeError('Binding input evidence exceeds16MiB')
            record = {'file': remote, 'evidence_file': str(target.relative_to(out)),
                      'sha256': digest(target), 'bytes': size}
            metadata = elf(target)
            expected_abi = {'/system/lib/libgralloctypes.so': 'arm32',
                            '/system/lib64/libgralloctypes.so': 'arm64',
                            '/system/bin/linkerconfig': 'arm64', '/system/bin/init': 'arm64'}.get(remote)
            if expected_abi and (metadata is None or metadata['abi'] != expected_abi):
                raise RuntimeError('Invalid binding input ELF ABI: ' + remote)
            if metadata is not None:
                record.update(abi=metadata['abi'], exports=sorted(metadata['exports']),
                              imports=sorted(metadata['imports']), needed=metadata['needed'])
                target.with_suffix(target.suffix + '.readelf.txt').write_text(
                    run('readelf', '--dyn-syms', '--version-info', '--dynamic', '--wide', target))
            receipt['files'].append(record)
    if len(receipt['files']) != sum(1 for _, required in targets if required) + sum(
            1 for remote, required in targets if not required and remote not in {r['file'] for r in receipt['absences']}):
        raise RuntimeError('Incomplete binding evidence receipt')
    receipt['status'] = 'pinned inputs extracted; namespace generator/bindings unresolved'
    (out / 'receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')

if __name__ == '__main__':
    main()
