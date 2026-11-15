#!/usr/bin/env python3
"""Remote diagnostic only: inspect pinned factory directories and browser manifests.
No image modification, ROM build, signing, or publication.
"""
import gzip
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import urllib.request
import zipfile

pins = json.loads(Path(sys.argv[1]).read_text())["pixel_factory"]
out = Path(sys.argv[2]).resolve()
out.mkdir(parents=True, exist_ok=True)
(out / "input.json").write_text(json.dumps(pins, indent=2) + "\n")

def debug(image, command):
    r = subprocess.run(["debugfs", "-R", command, str(image)], capture_output=True, text=True, check=True)
    return r.stdout + r.stderr

with tempfile.TemporaryDirectory() as scratch:
    root = Path(scratch)
    archive = root / "factory.zip"
    urllib.request.urlretrieve(pins["url"], archive)
    digest = hashlib.file_digest(archive.open("rb"), "sha256").hexdigest()
    if digest != pins["sha256"]:
        raise RuntimeError("Factory checksum mismatch")
    (out / "verified-sha256.txt").write_text(digest + "\n")
    with zipfile.ZipFile(archive) as factory:
        nested = [n for n in factory.namelist() if Path(n).name.startswith("image-") and n.endswith(".zip")]
        if len(nested) != 1:
            raise RuntimeError(f"Expected one image archive: {nested}")
        inner = root / "images.zip"
        with factory.open(nested[0]) as src, inner.open("wb") as dst:
            import shutil
            shutil.copyfileobj(src, dst)
    with zipfile.ZipFile(inner) as images:
        for partition in ("product", "system_ext", "system"):
            image = root / (partition + ".img")
            with images.open(image.name) as src, image.open("wb") as dst:
                shutil.copyfileobj(src, dst)
            for directory in ("/app", "/priv-app", "/apex", "/system/app", "/system/priv-app", "/system/apex"):
                listing = debug(image, "ls -p " + directory)
                label = partition + directory.replace("/", "_")
                (out / (label + ".txt")).write_text(listing)
                for line in listing.splitlines():
                    fields = line.split("/")
                    if len(fields) < 6:
                        continue
                    name = fields[5]
                    if not any(word in name.lower() for word in ("chrome", "webview")):
                        continue
                    target = root / ("extract-" + label + "-" + name)
                    target.mkdir()
                    (out / (label + "-" + name + "-dump.txt")).write_text(debug(image, f"rdump {directory}/{name} {target}"))
                    for apk in sorted(target.rglob("*")):
                        if apk.name.endswith(".apk.gz"):
                            expanded = apk.with_suffix("")
                            with gzip.open(apk) as src, expanded.open("wb") as dst:
                                shutil.copyfileobj(src, dst)
                        elif not apk.name.endswith(".apk"):
                            continue
                        else:
                            expanded = apk
                        result = subprocess.run(["aapt", "dump", "xmltree", str(expanded), "AndroidManifest.xml"], capture_output=True, text=True)
                        record = {"partition": partition, "source_directory": directory + "/" + name,
                                  "apk": str(expanded.relative_to(target)), "sha256": hashlib.file_digest(expanded.open("rb"), "sha256").hexdigest(),
                                  "manifest_exit_code": result.returncode}
                        prefix = label + "-" + name + "-" + expanded.name
                        (out / (prefix + ".json")).write_text(json.dumps(record, indent=2) + "\n")
                        (out / (prefix + "-manifest.txt")).write_text(result.stdout + result.stderr)
                    shutil.rmtree(target)
            image.unlink()
