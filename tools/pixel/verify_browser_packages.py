"""Validate the measured standalone Chrome/WebView layout before re-signing."""
import os
import re
import subprocess
import zipfile


def validate_package(manifest, entries, expected_package, webview=False):
    if f'package="{expected_package}"' not in manifest:
        raise ValueError("Unexpected browser package identity")
    if "E: uses-static-library" in manifest or "trichrome" in manifest.lower():
        raise ValueError("Browser requires an unstaged static library")
    version = re.search(r'versionName\([^)]*\)="([^"]+)"', manifest)
    if not version:
        raise ValueError("Browser version missing")
    native = [n for n in entries if n.startswith("lib/arm64-v8a/") and n.endswith(".so")]
    if not native:
        raise ValueError("Standalone browser has no embedded ARM64 native libraries")
    if webview and "lib/arm64-v8a/libwebviewchromium.so" not in native:
        raise ValueError("Standalone WebView implementation missing")
    return version.group(1)


def verify_browser_pair(stage, build_tools):
    versions = []
    for directory, package, webview in (("Chrome", "com.android.chrome", False),
                                         ("WebViewGoogle", "com.google.android.webview", True)):
        apk = os.path.join(stage, "product", "app", directory, directory + ".apk")
        subprocess.run([os.path.join(build_tools, "apksigner"), "verify", apk], check=True, capture_output=True)
        manifest = subprocess.run([os.path.join(build_tools, "aapt"), "dump", "xmltree", apk,
                                   "AndroidManifest.xml"], check=True, capture_output=True, text=True).stdout
        with zipfile.ZipFile(apk) as archive:
            versions.append(validate_package(manifest, archive.namelist(), package, webview))
    if versions[0] != versions[1]:
        raise ValueError("Chrome and WebView versions differ")
    print("Verified standalone Chrome/WebView signatures, versions and ARM64 libraries:", versions[0])
