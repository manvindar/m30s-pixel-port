# Verified system-only recovery writes

These host tools preserve boot and vendor, require root recovery and an unmounted
M30s system partition, and stream exactly the partition size. They never reboot.
They default to verification only; `--apply` enables the write.

Supply the device serial, preserved boot/vendor hashes, and expected candidate
commit/run explicitly. Verify the downloaded candidate's successful build,
mechanical receipts, experimental mode and publication policy separately first.
A matching manifest is a content-identity gate, not ROM compatibility acceptance.

```sh
python3 tools/flash/flash_system_verified.py \
  system.img system-readback-manifest.json rollback-receipt.json flash-receipt.json \
  --serial DEVICE_SERIAL --boot-sha256 VERIFIED_BOOT_HASH \
  --vendor-sha256 VERIFIED_VENDOR_HASH --source-commit EXPECTED_COMMIT \
  --actions-run EXPECTED_RUN_URL
```

After a transport failure (return code 255), add `--apply` and
`--resume-interrupted-write previous-flash-receipt.json`, with a **new** output
receipt. This revalidates the exact original rollback stream and all retained
partition/candidate gates, records the current partial-system hash, and rewrites
the entire candidate from byte zero. It never guesses the interruption offset.
Keep the phone in recovery until full readback passes.

For rollback, use `restore_system_verified.py rollback-receipt.json
restore-receipt.json`, the same `--serial`, `--boot-sha256`, `--vendor-sha256`
arguments, and `--apply` only after verifying the dry run. An optional `--adb`
argument selects the host Android Debug Bridge executable.

A gzip backup may contain trailing `dd` statistics. The restore stream excludes
those bytes, verifies the exact trailer, and validates the full raw hash. If the
receipt declares a verified 512 MiB recovery prefix overlay, that exact prefix
replaces the first two 256 MiB windows; the remaining bytes come from the original
carrier. Full reconstructed readback, boot and vendor hashes must match.

Run regression checks with:

```sh
python3 -m unittest discover -s tools/flash -v
```

Optimized Python (`-O`) is rejected because the existing gate assertions must
remain enabled. These tools do not test touch, calls, camera capture, multimedia
quality, suspend stability, or runtime namespace compatibility.
