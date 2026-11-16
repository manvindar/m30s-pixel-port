# Tablet ROM Tuner adaptation

Copied from `rom-tuner/src`, `rom-tuner/res` and `rom-tuner/AndroidManifest.xml` in `manvindar/tb-x606v-android17`, local source checkout d718d61f95bba296a1093cdb8076a17aa1b6247d. Upstream source identifies the Android 16 port ROM Tuner as its original home (source sync 0fb0152, 2026-11-02).

The M30s adaptation retains the app package and existing UI code. It replaces supported performance, memory and animation pages; maps Exynos cluster ordering, Mali clock and BIG temperature; bounds selectable M30s profiles; removes unsupported pages from navigation and disallows their direct intent routes; and queues atomic backend requests. Tablet-only code remains as upstream lineage but is not exposed by the M30s navigation. Root writes use the separately reviewed M30s backend, never the tablet daemon.
