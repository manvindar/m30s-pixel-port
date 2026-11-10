# Backup before changing firmware

Back up personal files, account recovery codes, authenticator exports and application data before unlocking or flashing. Keep backups outside Git and do not publish raw device partitions, screenshots or account inventories.

Bootloader unlocking can erase internal storage. Confirm backups first and keep a verified stock-firmware recovery route. Preserve device-specific radio and calibration partitions privately; never substitute another device's dumps.

Provide the target device serial explicitly through `ADB_SERIAL` for backup tooling. Device-specific backup records remain in the private archive.
