"""Compiles and runs tests/CapsTest.java against the app's pure capability logic (Caps.java: no Android types)."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

TUNER = Path(__file__).resolve().parents[1]
SOURCES = [TUNER / 'tablet/src/org/tablet/tuner/Caps.java', TUNER / 'tests/CapsTest.java']


def tool(name):
    for home in (os.environ.get('JAVA_HOME'), '/opt/homebrew/opt/openjdk'):
        if home and (Path(home) / 'bin' / name).exists():
            return str(Path(home) / 'bin' / name)
    return shutil.which(name)


class CapsJava(unittest.TestCase):
    def test_capability_logic(self):
        javac, java = tool('javac'), tool('java')
        if not (javac and java):
            if os.environ.get('CI'):
                self.fail('JDK missing in CI')
            self.skipTest('no JDK on this machine')
        with tempfile.TemporaryDirectory() as out:
            subprocess.run([javac, '-Xlint:all,-options', '-Werror', '--release', '8', '-d', out] + [str(s) for s in SOURCES], check=True, capture_output=True, text=True)
            run = subprocess.run([java, '-cp', out, 'org.tablet.tuner.CapsTest'], capture_output=True, text=True)
            self.assertEqual(run.returncode, 0, run.stderr)
            self.assertIn('CapsTest OK', run.stdout)


if __name__ == '__main__':
    unittest.main()
