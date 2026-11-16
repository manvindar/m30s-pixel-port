import copy
import json
from pathlib import Path
from types import SimpleNamespace
import unittest
from unittest.mock import patch
from caller_reviews import load_reviews, match_review
from verify_final import reviewed_binding


class CallerReviewTests(unittest.TestCase):
    def test_retained_37_callers_and_all_identity_binding_drift(self):
        rows = json.loads((Path(__file__).parent / 'fixtures/mapper-callers-43779962776.json').read_text())
        records = load_reviews()
        expected = {'nativewindow-arm64', 'nativewindow-arm32', 'media-jni-arm64',
                    'media-jni-arm32', 'virtual-camera-arm64', 'preapex-arm64',
                    'libgui-arm64', 'stagefright-arm64', 'android-runtime-arm64', 'stagefright-arm32'}
        accepted = set()
        unknown = 0
        for row in rows:
            policy = next((p for p in records if p['sha256'] == row['sha256']), None)
            binding = {'namespace': 'system', 'libui_sha256': policy['patched_libui_sha256'] if policy else 'unknown',
                       'latest_libui_sha256': policy['latest_libui_sha256'] if policy else 'unknown',
                       'decoder_sha256': policy['decoder_sha256'] if policy else None, 'missing_imports': []}
            def check(r, b):
                return match_review(records, r['context'], r['file'], r['abi'], r['sha256'],
                                    r['bytes'], r['interface_symbols'], b)
            result = check(row, binding)
            if not policy:
                self.assertIsNone(result)
                unknown += 1
                continue
            self.assertIsNotNone(result)
            accepted.add(result['id'])
            for field in ('context', 'file', 'abi', 'sha256', 'bytes', 'interface_symbols'):
                changed = copy.deepcopy(row)
                changed[field] = changed[field] + 1 if field == 'bytes' else (changed[field] + ['unreviewed'] if field == 'interface_symbols' else changed[field] + '-drift')
                with self.subTest(caller=policy['id'], field=field):
                    self.assertIsNone(check(changed, binding))
            for field in ('namespace', 'libui_sha256', 'latest_libui_sha256', 'missing_imports'):
                changed = dict(binding)
                changed[field] = ['missing@VERSION'] if field == 'missing_imports' else 'drift'
                with self.subTest(caller=policy['id'], binding=field):
                    self.assertIsNone(check(row, changed))
                del changed[field]
                self.assertIsNone(check(row, changed))
            if policy['decoder_sha256']:
                self.assertIsNone(check(row, dict(binding, decoder_sha256='drift')))
                changed = dict(binding); del changed['decoder_sha256']
                self.assertIsNone(check(row, changed))
            self.assertIsNone(check(row, dict(binding, error='unresolved dependency')))
            self.assertIsNone(check(row, {}))
        self.assertEqual(accepted, expected)
        self.assertEqual((len(rows), unknown), (37, 27))

    def test_direct_ui_and_actual_ui_decoder_edges(self):
        caller = '/system/lib64/caller.so'
        ui = '/system/lib64/libui.so'
        decoder = '/system/lib64/libgralloctypes.so'
        edges = [{'from': caller, 'needed': 'libui.so', 'to': ui, 'namespace': 'system'},
                 {'from': ui, 'needed': 'libgralloctypes.so', 'to': decoder, 'namespace': 'system'}]
        metadata = {'abi': 'arm64', 'imports': {'required@V1'}}
        inventory = SimpleNamespace(metadata={ui: {'abi': 'arm64', 'source_path': 'ui'},
                                             decoder: {'abi': 'arm64', 'source_path': 'decoder'}},
                                    closure=lambda *args: ([{'exports': {'required@V1'}}], edges))
        with patch('verify_final.digest', side_effect=lambda p: str(p)):
            binding = reviewed_binding(inventory, 'system', caller, metadata, Path('stage'), True)
            self.assertEqual(binding['decoder_sha256'], 'decoder')
            self.assertEqual(binding['missing_imports'], [])
            for index in (0, 1):
                for field, value in [('from', '/system/lib64/transitive.so'),
                                     ('to', '/apex/other/lib64/wrong.so'), ('namespace', 'other')]:
                    changed = copy.deepcopy(edges); changed[index][field] = value
                    inventory.closure = lambda *args: ([{'exports': {'required@V1'}}], changed)
                    with self.subTest(edge=index, field=field), self.assertRaises(RuntimeError):
                        reviewed_binding(inventory, 'system', caller, metadata, Path('stage'), True)
                for changed in (edges[:index] + edges[index+1:], edges + [edges[index]]):
                    inventory.closure = lambda *args: ([{'exports': {'required@V1'}}], changed)
                    with self.assertRaises(RuntimeError):
                        reviewed_binding(inventory, 'system', caller, metadata, Path('stage'), True)
            inventory.closure = lambda *args: ([{'exports': set()}], edges)
            self.assertEqual(reviewed_binding(inventory, 'system', caller, metadata, Path('stage'), True)['missing_imports'], ['required@V1'])
            for path in (ui, decoder):
                inventory.metadata[path]['abi'] = 'arm32'
                with self.assertRaises(RuntimeError):
                    reviewed_binding(inventory, 'system', caller, metadata, Path('stage'), True)
                inventory.metadata[path]['abi'] = 'arm64'


if __name__ == '__main__':
    unittest.main()
