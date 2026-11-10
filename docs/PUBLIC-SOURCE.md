# Public source and private build records

This repository publishes the Pixel port's source and scrubbed development history. The original repository is retained privately as `manvindar/m30s-pixel-port-private-archive`, including firmware releases, input assets, build logs and original device records. The One UI repository is separate and remains private.

Public history omits device serials, local network addresses, workstation usernames, personal author email addresses, screenshots, carrier/app inventories and detailed backup records. Historical commit IDs have changed. Existing local checkouts must not push old history into this public repository; use a fresh clone.

Firmware workflow dispatches require a maintainer-provided `M30S_INPUTS_TOKEN` with access to the private archive and patch library. `M30S_KERNEL_TOKEN` is optional when using the mirrored kernel inputs. The workflow reads private inputs and publishes firmware releases only to the private archive. No credential values are committed.

Device tools require an explicitly supplied serial. `DEVICE_SERIAL` in historical examples is a placeholder.
