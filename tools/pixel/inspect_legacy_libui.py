"""Diagnostic: prior compatible libui export/dependency comparison, not a ROM patch."""
import hashlib
import json
from pathlib import Path
import re
import shutil
import subprocess
import urllib.request
import zipfile

out = Path("libui-evidence")
prior = {"build_id": "DP11.261016.003", "url": "https://dl.google.com/developers/android/cinnamonbun/images/gsi/aosp_arm64-exp-DP11.261016.003-16708287-d735a3b1.zip",
         "sha256": "d735a3b11fe1b76a736f325f5500f7211167642fe2ed39dae0cf530d1cf51436"}
(out / "legacy-input.json").write_text(json.dumps(prior, indent=2))

def run(*args):
    result = subprocess.run(args, capture_output=True, text=True, check=True)
    return result.stdout + result.stderr

# Latest system.img remains from the preceding extraction step.
latest_dirs = {}
for abi, directory in [("arm64", "lib64"), ("arm32", "lib")]:
    listing = run("debugfs", "-R", "ls -p /system/" + directory, "system.img")
    (out / ("latest-" + directory + "-listing.txt")).write_text(listing)
    latest_dirs[abi] = listing
# Record actual undefined references to the two new mapper lock signatures.
new_lock_names = ["_ZNK7android14Gralloc4Mapper4lockEPK13native_handlemRKNS_4RectEiPPv",
                  "_ZNK7android14Gralloc5Mapper4lockEPK13native_handlemRKNS_4RectEiPPv",
                  "_ZNK7android14Gralloc4Mapper4lockEPK13native_handleyRKNS_4RectEiPPv",
                  "_ZNK7android14Gralloc5Mapper4lockEPK13native_handleyRKNS_4RectEiPPv"]
scan = {"scope": ["/system/lib64", "/system/lib", "/system/bin", "swcodec payload lib64/lib/bin"], "missing_export_consumers": [], "elf_files": 0}

def scan_directory(image, directory, label):
    target = Path("consumer-scan-" + label)
    target.mkdir()
    run("debugfs", "-R", f"rdump {directory} {target}", image)
    for file in target.rglob("*"):
        if not file.is_file() or file.is_symlink():
            continue
        with file.open("rb") as stream:
            if stream.read(4) != b"\x7fELF":
                continue
        scan["elf_files"] += 1
        symbols = run("readelf", "-Ws", str(file))
        for line in symbols.splitlines():
            fields = line.split()
            if len(fields) >= 8 and fields[6] == "UND" and fields[7].split("@")[0] in new_lock_names:
                scan["missing_export_consumers"].append({"file": str(file.relative_to(target)), "symbol": fields[7]})
    shutil.rmtree(target)

for directory in ("/system/lib64", "/system/lib", "/system/bin"):
    scan_directory("system.img", directory, directory.replace("/", "_"))
# Inspect the codec APEX variant and its namespace requirements, not only system libui.
run("debugfs", "-R", "dump /system/apex/com.android.media.swcodec.capex swcodec.capex", "system.img")
with zipfile.ZipFile("swcodec.capex") as compressed:
    with compressed.open("original_apex") as src, open("swcodec.apex", "wb") as dst:
        shutil.copyfileobj(src, dst)
with zipfile.ZipFile("swcodec.apex") as apex:
    with apex.open("apex_payload.img") as src, open("swcodec-payload.img", "wb") as dst:
        shutil.copyfileobj(src, dst)
for abi, directory in [("arm64", "lib64"), ("arm32", "lib")]:
    target = out / ("swcodec-libui-" + abi + ".so")
    run("debugfs", "-R", f"dump /{directory}/libui.so {target}", "swcodec-payload.img")
    (out / (target.name + "-symbols.txt")).write_text(run("readelf", "-Ws", str(target)))
    (out / (target.name + "-dynamic.txt")).write_text(run("readelf", "-d", str(target)))
    scan_directory("swcodec-payload.img", "/" + directory, "swcodec-" + abi)
scan_directory("swcodec-payload.img", "/bin", "swcodec-bin")
for image, source, name in [("system.img", "/system/etc/linker.config.pb", "system-linker.config.pb"),
                              ("swcodec-payload.img", "/etc/linker.config.pb", "swcodec-linker.config.pb")]:
    target = out / name
    run("debugfs", "-R", f"dump {source} {target}", image)
    if target.is_file():
        (out / (name + "-strings.txt")).write_text(run("strings", str(target)))
(out / "new-export-consumer-scan.json").write_text(json.dumps(scan, indent=2))

Path("gsi.zip").unlink()
Path("system.img").unlink()
urllib.request.urlretrieve(prior["url"], "prior-gsi.zip")
assert hashlib.file_digest(open("prior-gsi.zip", "rb"), "sha256").hexdigest() == prior["sha256"]
with zipfile.ZipFile("prior-gsi.zip") as archive:
    names = [n for n in archive.namelist() if Path(n).name == "system.img"]
    assert len(names) == 1
    with archive.open(names[0]) as src, open("prior-system.img", "wb") as dst:
        shutil.copyfileobj(src, dst)
for abi, directory in [("arm64", "lib64"), ("arm32", "lib")]:
    library = out / ("prior-libui-" + abi + ".so")
    run("debugfs", "-R", f"dump /system/{directory}/libui.so {library}", "prior-system.img")
    assert library.stat().st_size > 0
    (out / (library.name + "-symbols.txt")).write_text(run("readelf", "-Ws", str(library)))
    dynamic = run("readelf", "-d", str(library))
    (out / (library.name + "-dynamic.txt")).write_text(dynamic)
    needed = re.findall(r"Shared library: \[([^]]+)\]", dynamic)
    missing = [name for name in needed if "/" + name + "/" not in latest_dirs[abi]]
    # Dump only absent dependencies plus libui: do not export unrelated system libraries.
    queue = list(missing)
    seen = set()
    while queue:
        name = queue.pop(0)
        if name in seen:
            continue
        seen.add(name)
        target = out / ("prior-" + abi + "-" + name)
        run("debugfs", "-R", f"dump /system/{directory}/{name} {target}", "prior-system.img")
        if not target.is_file() or not target.stat().st_size:
            raise RuntimeError("Missing donor dependency: " + name)
        dyn = run("readelf", "-d", str(target))
        (out / (target.name + "-dynamic.txt")).write_text(dyn)
        (out / (target.name + "-symbols.txt")).write_text(run("readelf", "-Ws", str(target)))
        queue.extend(dep for dep in re.findall(r"Shared library: \[([^]]+)\]", dyn)
                     if "/" + dep + "/" not in latest_dirs[abi] and dep not in seen)
    (out / ("missing-dependencies-" + abi + ".json")).write_text(json.dumps(sorted(seen), indent=2))
with (out / "SHA256SUMS").open("w") as sums:
    for library in sorted(out.glob("*.so")):
        sums.write(hashlib.file_digest(library.open("rb"), "sha256").hexdigest() + "  " + library.name + "\n")
