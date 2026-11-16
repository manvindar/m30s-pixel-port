#!/usr/bin/env python3
"""Reproduce bounded audio staging inputs; never claim final/runtime binding."""
import argparse
import json
from pathlib import Path
import re
import sys
import tempfile
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'graphics'))
from common import digest, dump, elf, run

SEEDS = ['libaudiohal@5.0.so', 'libaudiopolicymanagerdefault.so',
         'libaudiopolicyenginedefault.so', 'libaudiopolicyengineconfigurable.so',
         'libaudiohal.so', 'libaudiohal_deathhandler.so']
PATCH_SHA256 = {
    'patch_server_codes.py': '080536e63b0526ba02218318b3f2af6c40303ef23dbfc099a1c1ad4228e018c7',
    'patch_audiopermission.py': 'ee9012c1f3026d1a8f640e89f8c55cc9a1adfd0ce539ea74090264dc35dd85bf'}
KEEP = {'libui.so', 'libgralloctypes.so', 'libgui.so', 'libnativewindow.so',
        'libaudiopermission.so', 'audiopolicy-aidl-cpp.so'}


def stat(image, path, *, external_link=False):
    value = run('debugfs', '-R', 'stat ' + path, image)
    if 'Inode:' not in value:
        return None
    if external_link and re.search(r'Type:\s+symlink', value):
        return value
    if not re.search(r'Type:\s+regular', value):
        raise RuntimeError('Nonregular audio input: ' + path)
    return value


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--base', required=True)
    ap.add_argument('--donor', required=True)
    ap.add_argument('--tablet', required=True)
    args = ap.parse_args()
    out = Path('audio-staging-evidence'); out.mkdir(exist_ok=False)
    tablet = Path(args.tablet)
    receipt = {'acceptance': False, 'final_readback': False, 'runtime_execution': False,
               'files': [], 'external_requirements': [], 'declared_edges': [],
               'limitations': ['Reproduced staging inputs; compare to actual final image before acceptance',
                              'DT_NEEDED graph excludes dynamic dlopen and does not prove namespace/runtime binding'],
               'inputs': {'base_image_sha256': digest(args.base), 'donor_image_sha256': digest(args.donor)},
               'patch_sources': {}}
    for name in ('patch_server_codes.py', 'patch_audiopermission.py'):
        p = tablet / 'tools/audio' / name
        if not p.is_file() or p.is_symlink():
            raise RuntimeError('Pinned patch source absent: ' + name)
        if digest(p) != PATCH_SHA256[name]:
            raise RuntimeError('Pinned patch source drift: ' + name)
        receipt['patch_sources'][name] = digest(p)
    receipt['base_interpreter_paths'] = []
    for remote in ('/system/bin/linker64', '/system/bin/bootstrap/linker64'):
        inode = stat(args.base, remote, external_link=True)
        receipt['base_interpreter_paths'].append({'file': remote, 'inode': inode,
            'limitation': 'Base path evidence only; final loader patches and symlink target must be verified'})
    total = 0
    with tempfile.TemporaryDirectory(prefix='audio-staging-') as tmp:
        tmp = Path(tmp)
        entry = dump(args.donor, '/system/bin/audioserver', out / 'system/bin/audioserver')
        meta = elf(entry)
        if not meta or meta['abi'] != 'arm64' or entry.stat().st_size > 4 * 1024 ** 2:
            raise RuntimeError('Invalid donor audio entrypoint')
        entry_stat = stat(args.base, '/system/bin/audioserver')
        if entry_stat is None:
            raise RuntimeError('Base entrypoint attributes missing')
        (out / 'audioserver-base.stat.txt').write_text(entry_stat)
        (out / 'audioserver-base.xattrs.txt').write_text(
            run('debugfs', '-R', 'ea_list /system/bin/audioserver', args.base))
        entry.with_suffix('.readelf.txt').write_text(run('readelf', '-h', '-l', '-d', '-V', '-Ws', '--wide', entry))
        receipt['files'].append({'file': '/system/bin/audioserver', 'sha256': digest(entry),
                                 'bytes': entry.stat().st_size, 'needed': meta['needed'],
                                 'abi': meta['abi'], 'attributes': 'audioserver-base.stat.txt'})
        total += entry.stat().st_size
        rc = dump(args.base, '/system/etc/init/audioserver.rc', tmp / 'audioserver.rc').read_text()
        first, rest = rc.split('\n', 1)
        if first != 'service audioserver /system/bin/audioserver' or 'setenv LD_LIBRARY_PATH' in rc:
            raise RuntimeError('Unexpected base audio service definition')
        staged_rc = out / 'system/etc/init/audioserver.rc'
        staged_rc.parent.mkdir(parents=True, exist_ok=True)
        staged_rc.write_text(first + '\n    setenv LD_LIBRARY_PATH /system/lib64/a16audio\n' + rest)
        receipt['service'] = {'source_sha256': digest(tmp / 'audioserver.rc'),
                              'staged_sha256': digest(staged_rc), 'file': str(staged_rc.relative_to(out))}
        todo = [(n, '/system/bin/audioserver') for n in meta['needed']] + [(n, 'plugin-seed') for n in SEEDS]
        seen = set()
        while todo:
            name, consumer = todo.pop()
            if Path(name).name != name or not name.endswith('.so'):
                raise RuntimeError('Invalid DT_NEEDED name: ' + name)
            receipt['declared_edges'].append({'consumer': consumer, 'needed': name})
            if name in seen:
                continue
            seen.add(name)
            if len(seen) > 256:
                raise RuntimeError('Audio dependency count exceeds bound')
            remote = '/system/lib64/' + name
            attrs = stat(args.donor, remote, external_link=True)
            if attrs is None or re.search(r'Type:\s+symlink', attrs):
                receipt['external_requirements'].append({'name': name, 'source_path': remote,
                    'source_inode': attrs, 'reason': ('Donor system symlink: target/provider not copied or accepted' if attrs else
                    'Absent from donor system/lib64; actual final APEX/vendor provider unresolved')})
                continue
            source = dump(args.donor, remote, tmp / name)
            if source.stat().st_size > 16 * 1024 ** 2:
                raise RuntimeError('Oversized closure input: ' + name)
            source_hash = digest(source)
            script = {'audiopolicy-aidl-cpp.so': 'patch_server_codes.py',
                      'libaudiopermission.so': 'patch_audiopermission.py'}.get(name)
            target = source
            if script:
                target = tmp / (name + '.patched')
                run(sys.executable, tablet / 'tools/audio' / script, source, target)
                if not target.is_file() or not target.stat().st_size:
                    raise RuntimeError('Empty patched audio input')
            info = elf(target)
            if not info or info['abi'] != 'arm64':
                raise RuntimeError('Wrong audio closure ABI: ' + name)
            virtual = '/system/lib64/a16audio/' + name
            item = {'file': virtual, 'source_sha256': source_hash, 'sha256': digest(target),
                    'bytes': target.stat().st_size, 'abi': info['abi'], 'needed': info['needed'],
                    'staged_mode': '0644', 'staged_uid': 0, 'staged_gid': 0,
                    'patch': script, 'exports': sorted(info['exports']), 'imports': sorted(info['imports'])}
            if name in KEEP:
                final = dump(args.donor, remote, out / virtual.lstrip('/'))
                if script:
                    final.write_bytes(target.read_bytes())
                total += final.stat().st_size
                if total > 16 * 1024 ** 2:
                    raise RuntimeError('Retained binary evidence exceeds16MiB')
                item['evidence_file'] = str(final.relative_to(out))
                final.with_suffix('.readelf.txt').write_text(run('readelf', '-h', '-l', '-d', '-V', '-Ws', '--wide', final))
            receipt['files'].append(item)
            todo.extend((n, virtual) for n in info['needed'])
        if not KEEP.issubset({Path(r['file']).name for r in receipt['files']}):
            raise RuntimeError('Required bounded audio review binaries missing')
    receipt['status'] = 'complete declared donor-system closure; external/dlopen/final binding unresolved'
    receipt['retained_binary_bytes'] = total
    encoded = json.dumps(receipt, indent=2) + '\n'
    if len(encoded.encode()) > 8 * 1024 ** 2:
        raise RuntimeError('Oversized closure receipt')
    (out / 'receipt.json').write_text(encoded)


if __name__ == '__main__':
    main()
