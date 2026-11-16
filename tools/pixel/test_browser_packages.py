import unittest
from pathlib import Path
from verify_browser_packages import validate_package

FIXTURES = Path(__file__).parent / "testdata/browser-dp11.261030.003"


class BrowserPackagingTests(unittest.TestCase):
    def test_measured_standalone_manifests(self):
        for name, package, library in (("chrome", "com.android.chrome", "libchrome.so"),
                                        ("webview", "com.google.android.webview", "libwebviewchromium.so")):
            manifest = (FIXTURES / (name + "-manifest.txt")).read_text()
            # Native entries here exercise the gate; real payload libraries are checked in CI.
            self.assertEqual(validate_package(manifest, ["lib/arm64-v8a/" + library], package,
                                              name == "webview"), "154.0.8037.73")

    def test_missing_native_payload_rejected(self):
        manifest = (FIXTURES / "webview-manifest.txt").read_text()
        with self.assertRaisesRegex(ValueError, "no embedded ARM64"):
            validate_package(manifest, [], "com.google.android.webview", True)

    def test_trichrome_dependency_rejected(self):
        manifest = (FIXTURES / "chrome-manifest.txt").read_text() + "\n E: uses-static-library\n"
        with self.assertRaisesRegex(ValueError, "unstaged static library"):
            validate_package(manifest, ["lib/arm64-v8a/libchrome.so"], "com.android.chrome")

    def test_wrong_package_rejected(self):
        with self.assertRaisesRegex(ValueError, "identity"):
            validate_package((FIXTURES / "chrome-manifest.txt").read_text(), [], "com.google.android.webview")

    def test_wrong_webview_library_rejected(self):
        with self.assertRaisesRegex(ValueError, "implementation missing"):
            validate_package((FIXTURES / "webview-manifest.txt").read_text(),
                             ["lib/arm64-v8a/libother.so"], "com.google.android.webview", True)


if __name__ == "__main__":
    unittest.main()
