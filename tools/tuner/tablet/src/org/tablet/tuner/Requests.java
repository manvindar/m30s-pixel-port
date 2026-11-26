package org.tablet.tuner;

import java.util.ArrayList;
import java.util.List;

/**
 * Changes waiting for the daemon. The daemon takes one request file at a time, so a change made while it is busy used to be dropped: it is queued
 * here and sent when the file is free. The daemon echoes the request it handled last (state key last_request), which tells the header whether
 * the status shown belongs to the newest change (no Android types: tested on a JVM).
 */
final class Requests {
    static final long WAIT_MS = 20000;
    static final int MAX = 32;
    /** Keys whose value names a target (a package, a profile): two of them are two jobs, never one. */
    private static final String ACTIONS = ",compile_pkg,compile_pkg_profile,reset_pkg,save_profile,update_profile,apply_profile,delete_profile,compile_now,compile_all,refresh_apps,restart_ui,reboot,reboot_recovery,";
    private final List<String[]> queue = new ArrayList<>();
    private String sent;
    private long sentAt;

    /** A later value of a setting replaces an earlier one that is still queued. */
    void offer(String key, String value) {
        if (!ACTIONS.contains("," + key + ",")) {
            for (int i = 0; i < queue.size(); i++) if (queue.get(i)[0].equals(key)) { queue.remove(i); break; }
        }
        if (queue.size() >= MAX) queue.remove(0);
        queue.add(new String[] {key, value});
    }

    /** The next change to write as "key=value\n" when the request file is free, else null. */
    String next(boolean slotFree, long now) {
        if (!slotFree || queue.isEmpty()) return null;
        String[] r = queue.remove(0);
        sent = r[0] + "=" + r[1]; sentAt = now;
        return sent + "\n";
    }

    /** True while a change is queued or the daemon has not yet reported the last one sent. */
    boolean waiting(String lastRequest, long now) {
        if (!queue.isEmpty()) return true;
        if (sent == null) return false;
        if (sent.equals(lastRequest) || now - sentAt > WAIT_MS) { sent = null; return false; }
        return true;
    }
}
