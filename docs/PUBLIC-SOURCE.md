# Public source and release records

This repository contains sanitized Pixel source history and public experimental flashable releases built by GitHub Actions. Generic boot/vendor/vbmeta and baseline kernel build inputs are hash-pinned in the public `build-inputs-a17` release. Public upstream donors are downloaded directly and checked against pinned hashes. Public builds need no personal access-token secret.

Original history, private logs, old releases and device records remain in a separate private archive. The One UI port is separate. Existing private checkouts must never push original history to this repository; use a fresh clone.

The public audit removed device serials, local endpoints, workstation paths, personal author email addresses, screenshots, compiled caches and backup/carrier inventories. Device tools require an explicitly supplied serial. `DEVICE_SERIAL` in examples is a placeholder.
