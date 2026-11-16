import importlib.util
import json
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('package', Path(__file__).with_name('package_twrp.py'))
package = importlib.util.module_from_spec(spec); spec.loader.exec_module(package)


class CandidateGateTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(); self.addCleanup(self.tmp.cleanup)
        self.root = Path(self.tmp.name)
        self.build = {'source_commit': 'exact-source', 'actions_run': 'https://github.com/owner/repo/actions/runs/123',
                      'experimental_dirty_flash': True, 'graphics_acceptance': False, 'system_bytes': 5033164800}
        self.graphics = {'status': 'experimental-mechanical-pass', 'acceptance': False}

    def write(self):
        (self.root / 'build-receipt.json').write_text(json.dumps(self.build))
        (self.root / 'graphics-compatibility-verification.json').write_text(json.dumps(self.graphics))

    def test_exact_mechanical_pass_retains_false_acceptance(self):
        self.write()
        b, g = package.validate_receipts(self.root, 'exact-source', '123')
        self.assertIs(b['graphics_acceptance'], False)
        self.assertIs(g['acceptance'], False)

    def test_identity_or_geometry_drift_rejected(self):
        for key, value in [('source_commit', 'different'), ('actions_run', 'https://github.com/owner/repo/actions/runs/124'),
                           ('system_bytes', 1), ('experimental_dirty_flash', False), ('graphics_acceptance', True)]:
            with self.subTest(key=key):
                old = self.build[key]; self.build[key] = value; self.write()
                with self.assertRaises(RuntimeError): package.validate_receipts(self.root, 'exact-source', '123')
                self.build[key] = old

    def test_failed_partial_or_acceptance_claim_rejected(self):
        for key, value in [('status', 'failure'), ('status', 'partial'), ('acceptance', True), ('error', 'failed linkage')]:
            with self.subTest(key=key):
                self.graphics = {'status': 'experimental-mechanical-pass', 'acceptance': False, key: value}; self.write()
                with self.assertRaises(RuntimeError): package.validate_receipts(self.root, 'exact-source', '123')

    def test_missing_receipts_do_not_pass(self):
        with self.assertRaises(FileNotFoundError): package.validate_receipts(self.root, 'exact-source', '123')
