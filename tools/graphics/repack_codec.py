#!/usr/bin/env python3
"""Add only required legacy interfaces to the codec APEX, then re-sign its payload.
Uses the same generated test signing identities as the existing runtime APEX.
"""
import argparse
import json
import os
from pathlib import Path
import re
import shutil
import tempfile
import zipfile
from common import digest, dump, run, unpack_apex
from stage_legacy import LEGACY


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('input'); parser.add_argument('output'); parser.add_argument('stage')
    parser.add_argument('key'); parser.add_argument('avbtool')
    parser.add_argument('ui64'); parser.add_argument('ui32')
    args = parser.parse_args()
    stage = Path(args.stage)
    receipt = {'input_package_sha256': digest(args.input), 'replacements': [], 'added': [],
               'namespace_strategy': 'Legacy interfaces reside inside codec payload; manifest requirements unchanged'}
    with tempfile.TemporaryDirectory(prefix='codec-graphics-') as scratch:
        tmp = Path(scratch)
        original, payload, _ = unpack_apex(args.input, tmp / 'input')
        zdir = tmp / 'zip'; zdir.mkdir()
        with zipfile.ZipFile(original) as z:
            names = [n for n in z.namelist() if n and not n.endswith('/')]
            if any(Path(n).is_absolute() or '..' in Path(n).parts for n in names):
                raise RuntimeError('Unsafe APEX member path')
            z.extractall(zdir)
        pay = zdir / 'apex_payload.img'
        info = run('python3', '-I', args.avbtool, 'info_image', '--image', pay)
        original_bytes = int(re.search(r'Original image size:\s+(\d+)', info).group(1))
        block = int(re.search(r'Data Block Size:\s+(\d+)', info).group(1))
        apex_key = re.search(r"Prop: apex.key -> '([^']+)'", info).group(1)
        # Bounded extra ext4 space for at most ten small HIDL interface libraries.
        new_bytes = ((original_bytes + 16 * 1024 * 1024 + block - 1) // block) * block
        with pay.open('r+b') as stream:
            stream.truncate(original_bytes)
        run('e2fsck', '-fy', pay, ok=(0, 1))
        with pay.open('r+b') as stream:
            stream.truncate(new_bytes)
        run('resize2fs', pay)
        run('e2fsck', '-fy', '-E', 'unshare_blocks', pay, ok=(0, 1))
        run('e2fsck', '-fn', pay)
        commands = []
        for directory, library in [('lib64', Path(args.ui64)), ('lib', Path(args.ui32))]:
            original_path = '/' + directory + '/libui.so'
            label = run('debugfs', '-R', f'ea_get -V {original_path} security.selinux', pay).split('\n')[0].split('\x00')[0].strip()
            if not label.startswith('u:object_r:'):
                raise RuntimeError('Missing codec library SELinux label')
            label_file = tmp / (directory + '-label'); label_file.write_bytes(label.encode() + b'\x00')
            planned = [(original_path, library, 'replacements')]
            for name in LEGACY:
                destination = '/' + directory + '/' + name
                stat = run('debugfs', '-R', 'stat ' + destination, pay)
                if 'Inode:' not in stat:
                    planned.append((destination, stage / 'interfaces' / directory / name, 'added'))
            for destination, source, kind in planned:
                if not source.is_file() or not source.stat().st_size:
                    raise RuntimeError('Missing codec donor file: ' + str(source))
                if kind == 'replacements':
                    commands.append('rm ' + destination)
                commands.extend([f'write {source.resolve()} {destination}',
                                 f'set_inode_field {destination} mode 0100644',
                                 f'set_inode_field {destination} uid 0', f'set_inode_field {destination} gid 0',
                                 f'ea_set -f {label_file} {destination} security.selinux'])
                receipt[kind].append({'path': destination, 'sha256': digest(source), 'selinux_label': label})
        script = tmp / 'commands'; script.write_text('\n'.join(commands) + '\n')
        output = run('debugfs', '-w', '-f', script, pay)
        if re.search(r'(?i)(file not found|no such|not enough|no space|error)', output):
            raise RuntimeError('Codec payload edit failed: ' + output[-2000:])
        run('e2fsck', '-fn', pay)
        for entry in receipt['replacements'] + receipt['added']:
            check = dump(pay, entry['path'], tmp / 'readback' / entry['path'].lstrip('/'))
            if digest(check) != entry['sha256']:
                raise RuntimeError('Codec payload readback mismatch')
            actual_label = run('debugfs', '-R', f'ea_get -V {entry["path"]} security.selinux', pay).split('\n')[0].split('\x00')[0].strip()
            if actual_label != entry['selinux_label']:
                raise RuntimeError('Codec payload label readback mismatch')
        total = ((new_bytes + new_bytes // 64 + 1024 * 1024) // block) * block
        run('python3', '-I', args.avbtool, 'add_hashtree_footer', '--image', pay,
            '--partition_size', str(total), '--partition_name', '', '--do_not_generate_fec',
            '--algorithm', 'SHA256_RSA4096', '--key', args.key, '--hash_algorithm', 'sha256',
            '--block_size', str(block), '--salt', os.urandom(32).hex(), '--prop', 'apex.key:' + apex_key)
        run('python3', '-I', args.avbtool, 'verify_image', '--image', pay, '--key', args.key)
        run('python3', '-I', args.avbtool, 'extract_public_key', '--key', args.key, '--output', zdir / 'apex_pubkey')
        unsigned = tmp / 'unsigned.apex'
        with zipfile.ZipFile(unsigned, 'w', compression=zipfile.ZIP_STORED) as z:
            for name in names:
                if not name.startswith('META-INF/'):
                    z.write(zdir / name, name)
        aligned = tmp / 'aligned.apex'
        run(os.environ['ZIPALIGN'], '-f', '4096', unsigned, aligned)
        run(os.environ['APKSIGNER'], 'sign', '--ks', os.environ['APEX_SIGN_KS'], '--ks-pass', 'pass:android',
            '--key-pass', 'pass:android', '--v1-signing-enabled', 'false', '--v2-signing-enabled', 'true',
            '--v3-signing-enabled', 'true', '--alignment-preserved', 'true', '--out', args.output, aligned)
        run(os.environ['APKSIGNER'], 'verify', args.output)
        run(os.environ['ZIPALIGN'], '-c', '4096', args.output)
    receipt['output_package_sha256'] = digest(args.output)
    receipt['validation'] = ['ext4 check', 'each modified file SHA256 readback', 'AVB hashtree verify', 'APK signature verify', '4096 ZIP alignment']
    (stage / 'codec-repack-receipt.json').write_text(json.dumps(receipt, indent=2) + '\n')


if __name__ == '__main__':
    main()
