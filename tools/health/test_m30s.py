import hashlib
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch
from stage_m30s import stage, OLD


class StageTests(unittest.TestCase):
    def test_drift_rejected_without_creating_destination(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp); source = root / 'source'; (source / 'src').mkdir(parents=True)
            (source / 'src/HealthCore.java').write_bytes(b'changed')
            with self.assertRaises(ValueError):
                stage(source, root / 'output')
            self.assertFalse((root / 'output').exists())

    def test_only_profile_changes_and_original_stays_untouched(self):
        with tempfile.TemporaryDirectory() as temp:
            root = Path(temp); source = root / 'source'; (source / 'src').mkdir(parents=True)
            data = b'before\n' + OLD + b'\nafter\n'
            (source / 'src/HealthCore.java').write_bytes(data)
            with patch('stage_m30s.CORE_SHA256', hashlib.sha256(data).hexdigest()):
                stage(source, root / 'output')
                with self.assertRaises(ValueError):
                    stage(source, root / 'output')
            self.assertEqual((source / 'src/HealthCore.java').read_bytes(), data)
            result = (root / 'output/src/HealthCore.java').read_bytes()
            self.assertIn(b'correctLevel = false;', result)
            self.assertEqual(result.splitlines()[0], b'before')
            self.assertEqual(result.splitlines()[-1], b'after')


if __name__ == '__main__':
    unittest.main()
