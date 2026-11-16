"""Guarded audio evidence must reject missing/incorrect inputs, never imply binding."""
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

spec = importlib.util.spec_from_file_location('audio_staging', Path(__file__).with_name('inspect_audio_staging.py'))
m = importlib.util.module_from_spec(spec); spec.loader.exec_module(m)


class AudioEvidenceTests(unittest.TestCase):
    def test_nonregular_input_rejected(self):
        with patch.object(m, 'run', return_value='Inode: 10 Type: symlink Mode: 0777'):
            with self.assertRaisesRegex(RuntimeError, 'Nonregular'):
                m.stat('image', '/system/bin/audioserver')

    def test_symlink_only_allowed_as_external_evidence(self):
        with patch.object(m, 'run', return_value='Inode: 10 Type: symlink Mode: 0777 Fast link dest: /apex/libdl.so'):
            self.assertIn('Fast link dest:', m.stat('image', '/system/lib64/libdl.so', external_link=True))
            with self.assertRaisesRegex(RuntimeError, 'Nonregular'):
                m.stat('image', '/system/bin/audioserver')

    def exercise(self, wrong_abi=False, source_drift=False, wrong_provider_abi=False, missing_provider=False):
        import os
        with tempfile.TemporaryDirectory() as tmp:
            old = Path.cwd(); os.chdir(tmp)
            try:
                tablet = Path('tablet/tools/audio'); tablet.mkdir(parents=True)
                for name in ('patch_server_codes.py', 'patch_audiopermission.py'):
                    (tablet / name).write_text('pinned-source')
                Path('base').write_bytes(b'base'); Path('donor').write_bytes(b'donor')
                def fake_dump(image, remote, target):
                    target = Path(target); target.parent.mkdir(parents=True, exist_ok=True)
                    target.write_bytes(('service audioserver /system/bin/audioserver\n    user audioserver\n'
                                        if remote.endswith('.rc') else Path(remote).name).encode())
                    return target
                def metadata(path):
                    name = Path(path).name.removesuffix('.patched')
                    needs = sorted(m.KEEP) if name == 'audioserver' else ['libui.so', 'libc.so', 'libdl.so']
                    abi = 'arm32' if (wrong_abi and name == 'audioserver') or '/lib/' in str(path) else 'arm64'
                    if wrong_provider_abi and '/base/' in str(path):
                        abi = 'arm64' if abi == 'arm32' else 'arm32'
                    return {'abi': abi, 'needed': needs,
                            'exports': {}, 'imports': {'dlopen@LIBC'}, 'abi_imports': {'dlopen@LIBC', 'weak_optional'}}
                def fake_run(*args):
                    if args[0] == m.sys.executable:
                        Path(args[-1]).write_bytes(Path(args[-2]).read_bytes() + b'patched')
                    return ' 0x000000006ffffffb (FLAGS_1) Flags: NOW GLOBAL\n'
                def fake_stat(image, remote, **kwargs):
                    if missing_provider and image == 'base' and remote == '/system/lib/libhidlbase.so':
                        return None
                    if remote.endswith('/libdl.so'):
                        return 'Inode: 3 Type: symlink Mode: 0777 Fast link dest: /apex/com.android.runtime/lib64/bionic/libdl.so'
                    return None if remote.endswith('/libc.so') else 'Inode: 2 Type: regular Mode: 0755'
                argv = ['inspect', '--base', 'base', '--donor', 'donor', '--tablet', 'tablet']
                with patch.object(m.sys, 'argv', argv), patch.object(m, 'dump', side_effect=fake_dump), \
                     patch.object(m, 'elf', side_effect=metadata), patch.object(m, 'run', side_effect=fake_run), \
                     patch.object(m, 'stat', side_effect=fake_stat), \
                     patch.object(m, 'PATCH_SHA256', {n: ('0' * 64 if source_drift else m.digest(tablet / n)) for n in m.PATCH_SHA256}):
                    m.main()
                return json.loads(Path('audio-staging-evidence/receipt.json').read_text())
            finally:
                os.chdir(old)

    def test_cycle_external_and_patched_provenance(self):
        r = self.exercise()
        self.assertFalse(r['acceptance']); self.assertFalse(r['final_readback'])
        self.assertFalse(r['runtime_execution'])
        self.assertEqual(len(r['base_native_inputs']), 4)
        self.assertEqual({v['abi'] for v in r['base_native_inputs']}, {'arm32', 'arm64'})
        self.assertTrue(all(not v['final_provider_acceptance'] for v in r['base_native_inputs']))
        self.assertEqual({v['name'] for v in r['external_requirements']}, {'libc.so', 'libdl.so'})
        link = next(v for v in r['external_requirements'] if v['name'] == 'libdl.so')
        self.assertIn('Fast link dest:', link['source_inode'])
        self.assertNotIn('/system/lib64/a16audio/libdl.so', {v['file'] for v in r['files']})
        rows = {v['file']: v for v in r['files']}
        self.assertEqual(len(rows), len(r['files']))
        for name in ('libaudiopermission.so', 'audiopolicy-aidl-cpp.so'):
            v = rows['/system/lib64/a16audio/' + name]
            self.assertNotEqual(v['source_sha256'], v['sha256'])
            self.assertTrue(v['patch'])
            self.assertIn('weak_optional', v['abi_imports'])
            self.assertIn('GLOBAL', v['dynamic_text'])
        self.assertIn({'consumer': '/system/lib64/a16audio/libui.so', 'needed': 'libui.so'}, r['declared_edges'])

    def test_required_ownership_provider_absence_rejected(self):
        with self.assertRaisesRegex(RuntimeError, 'Required base ownership provider absent'):
            self.exercise(missing_provider=True)

    def test_wrong_ownership_provider_abi_rejected(self):
        with self.assertRaisesRegex(RuntimeError, 'Wrong base ownership provider ABI'):
            self.exercise(wrong_provider_abi=True)

    def test_patch_source_drift_rejected(self):
        with self.assertRaisesRegex(RuntimeError, 'Pinned patch source drift'):
            self.exercise(source_drift=True)

    def test_wrong_entry_abi_rejected(self):
        with self.assertRaisesRegex(RuntimeError, 'Invalid donor audio entrypoint'):
            self.exercise(wrong_abi=True)


if __name__ == '__main__':
    unittest.main()
