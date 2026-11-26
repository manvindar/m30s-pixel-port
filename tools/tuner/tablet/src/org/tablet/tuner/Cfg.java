package org.tablet.tuner;

import android.content.Context;
import java.io.*;
import java.util.*;

/** State is written by the root daemon (state file); changes are requested through the request file. */
final class Cfg {
    static Map<String, String> load(Context c) {
        Map<String, String> m = new HashMap<>();
        File f = new File(c.getFilesDir(), "state");
        if (!f.exists()) return m;
        try (BufferedReader r = new BufferedReader(new FileReader(f))) {
            String l;
            while ((l = r.readLine()) != null) {
                int i = l.indexOf('=');
                if (i > 0) m.put(l.substring(0, i), l.substring(i + 1));
            }
        } catch (IOException ignored) { }
        return m;
    }

    /** The compile state list ("package=filter" lines). Null when the file is missing or incomplete: the daemon ends a finished file with apps_state_time=. */
    static Map<String, String> loadApps(Context c) {
        Map<String, String> m = new HashMap<>();
        boolean end = false;
        try (BufferedReader r = new BufferedReader(new FileReader(new File(c.getFilesDir(), "apps_state")))) {
            String l;
            while ((l = r.readLine()) != null) {
                if (l.isEmpty()) continue;
                int i = l.indexOf('=');
                if (i <= 0) return null;
                m.put(l.substring(0, i), l.substring(i + 1));
                end = l.startsWith("apps_state_time=");
            }
        } catch (Exception e) { return null; }
        return end && m.size() > 1 ? m : null;
    }

    private static final Requests REQ = new Requests();

    /** Queues a change; it is written now when the request file is free, else on the next pump. */
    static void request(Context c, String key, String value) { REQ.offer(key, value); pump(c); }

    /** Writes the next queued change once the daemon has taken the previous one. */
    static void pump(Context c) {
        File f = new File(c.getFilesDir(), "request"), tmp = new File(c.getFilesDir(), "request.new");
        boolean free = !f.exists() && !new File(c.getFilesDir(), "request.processing").exists();
        String line = REQ.next(free, System.currentTimeMillis());
        if (line == null) return;
        try (FileWriter w = new FileWriter(tmp)) { w.write(line); }
        catch (IOException e) { return; }
        if (!tmp.renameTo(f)) android.widget.Toast.makeText(c, "Could not queue change", android.widget.Toast.LENGTH_SHORT).show();
    }

    /** True while a change is queued or not yet reported back by the daemon. */
    static boolean waiting(String lastRequest) { return REQ.waiting(lastRequest, System.currentTimeMillis()); }
}
