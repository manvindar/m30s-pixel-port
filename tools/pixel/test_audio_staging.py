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

    def exercise(self, wrong_abi=False, source_drift=False):
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
                    needs = sorted(m.KEEP) if name == 'audioserver' else ['libui.so', 'libc.so']
                    return {'abi': 'arm32' if wrong_abi else 'arm64', 'needed': needs,
                            'exports': {}, 'imports': {}}
                def fake_run(*args):
                    if args[0] == m.sys.executable:
                        Path(args[-1]).write_bytes(Path(args[-2]).read_bytes() + b'patched')
                    return 'evidence'
                def fake_stat(image, remote):
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
        self.assertEqual([v['name'] for v in r['external_requirements']], ['libc.so'])
        rows = {v['file']: v for v in r['files']}
        self.assertEqual(len(rows), len(r['files']))
        for name in ('libaudiopermission.so', 'audiopolicy-aidl-cpp.so'):
            v = rows['/system/lib64/a16audio/' + name]
            self.assertNotEqual(v['source_sha256'], v['sha256'])
            self.assertTrue(v['patch'])
        self.assertIn({'consumer': '/system/lib64/a16audio/libui.so', 'needed': 'libui.so'}, r['declared_edges'])

    def test_patch_source_drift_rejected(self):
        with self.assertRaisesRegex(RuntimeError, 'Pinned patch source drift'):
            self.exercise(source_drift=True)

    def test_wrong_entry_abi_rejected(self):
        with self.assertRaisesRegex(RuntimeError, 'Invalid donor audio entrypoint'):
            self.exercise(wrong_abi=True)


if __name__ == '__main__':
    unittest.main()
