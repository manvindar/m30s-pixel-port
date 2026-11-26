package org.tablet.tuner;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

/**
 * What this kernel offers, as the root backend published it in the state file (caps=2): option lists, profiles and which controls exist.
 * Pure functions on the state map (no Android types) so they are tested on a JVM. Nothing here knows a frequency or a scheduler name:
 * a list the backend does not publish is empty, and an empty list means the control is hidden.
 */
final class Caps {
    private Caps() { }

    /** Shown in the order the backend published them; blanks dropped. */
    static String[] csv(String v) {
        List<String> r = new ArrayList<>();
        if (v != null) for (String p : v.split(",")) { p = p.trim(); if (!p.isEmpty()) r.add(p); }
        return r.toArray(new String[0]);
    }

    private static String get(Map<String, String> st, String k) { String v = st.get(k); return v == null ? "" : v.trim(); }

    private static boolean number(String s) {
        if (s.isEmpty() || s.length() > 9) return false;
        for (int i = 0; i < s.length(); i++) if (s.charAt(i) < '0' || s.charAt(i) > '9') return false;
        return true;
    }

    /** Frequencies in kHz, highest first; anything that is not a plain number is dropped. */
    static String[] freqs(Map<String, String> st, String key) {
        List<String> r = new ArrayList<>();
        for (String f : csv(get(st, key))) if (number(f) && !r.contains(f)) r.add(f);
        Collections.sort(r, new Comparator<String>() { @Override public int compare(String a, String b) { return Long.compare(Long.parseLong(b), Long.parseLong(a)); } });
        return r.toArray(new String[0]);
    }

    /** The highest advertised frequency, or "" when the backend published none. */
    static String top(Map<String, String> st, String key) { String[] f = freqs(st, key); return f.length == 0 ? "" : f[0]; }

    /** "1742000" to "1742 MHz"; anything else is shown as it came. */
    static String mhz(String khz) { return number(khz) ? (Long.parseLong(khz) / 1000) + " MHz" : khz; }

    private static String capital(String w) { return w.isEmpty() ? w : w.substring(0, 1).toUpperCase(java.util.Locale.US) + w.substring(1); }

    /** Option values and the labels shown for them. */
    static final class Choice {
        final String[] vals, labels;
        Choice(String[] vals, String[] labels) { this.vals = vals; this.labels = labels; }
        boolean empty() { return vals.length == 0; }
    }

    static Choice governors(Map<String, String> st) {
        String[] v = csv(get(st, "governors")), l = new String[v.length];
        for (int i = 0; i < v.length; i++) l[i] = capital(v[i]);
        return new Choice(v, l);
    }

    /** I/O schedulers and TCP congestion algorithms are technical names: shown exactly as the kernel spells them. */
    static Choice names(Map<String, String> st, String key) { String[] v = csv(get(st, key)); return new Choice(v, v.clone()); }

    static Choice clocks(Map<String, String> st, String key) {
        String[] v = freqs(st, key), l = new String[v.length];
        for (int i = 0; i < v.length; i++) l[i] = mhz(v[i]);
        return new Choice(v, l);
    }

    static Choice readAhead(Map<String, String> st) {
        String[] v = csv(get(st, "read_aheads")), l = new String[v.length];
        for (int i = 0; i < v.length; i++) l[i] = number(v[i]) && Long.parseLong(v[i]) >= 1024 ? (Long.parseLong(v[i]) / 1024) + " MB" : v[i] + " KB";
        return new Choice(v, l);
    }

    /** GPU maximum clock: "No limit" (-1) and every step of the Mali DVFS table; empty (hidden) unless the backend can write the limit. */
    static Choice gpuLimit(Map<String, String> st) {
        String[] f = freqs(st, "gpu_freqs");
        if (f.length == 0 || get(st, "gpu_max").isEmpty()) return new Choice(new String[0], new String[0]);
        String[] v = new String[f.length + 1], l = new String[f.length + 1];
        v[0] = "-1"; l[0] = "No limit";
        for (int i = 0; i < f.length; i++) { v[i + 1] = f[i]; l[i + 1] = mhz(f[i]); }
        return new Choice(v, l);
    }

    /** Frequency steps as chart rules in MHz (the GPU graph); empty when unknown. */
    static float[] rulesMhz(Map<String, String> st, String key) {
        String[] f = freqs(st, key);
        float[] r = new float[f.length];
        for (int i = 0; i < f.length; i++) r[i] = Long.parseLong(f[i]) / 1000f;
        return r;
    }

    /** Whether the kernel has the touch boost module. Only an old backend (no caps key) is judged by the presence of its duration value. */
    static boolean touch(Map<String, String> st) {
        if (get(st, "caps").isEmpty()) return !get(st, "touch_duration_ms").isEmpty();
        return "1".equals(get(st, "touch_supported"));
    }

    /** The profiles the backend accepts, in cycling order. An old backend (no list at all) offered all three; a published empty list means none. */
    static List<String> profiles(Map<String, String> st) {
        if (!st.containsKey("profiles")) return new ArrayList<>(Arrays.asList("battery", "balanced", "performance"));
        return new ArrayList<>(Arrays.asList(csv(get(st, "profiles"))));
    }

    private static String name(String id) { return id.equals("battery") ? "Battery" : id.equals("balanced") ? "Balanced" : id.equals("performance") ? "Responsive" : capital(id); }

    private static String profileClocks(Map<String, String> st, String id) {
        String[] p = csv(get(st, "profile_" + id));
        return p.length == 2 && number(p[0]) && number(p[1]) ? mhz(p[0]) + " / " + mhz(p[1]) : "";
    }

    /** id, name, one line of what it does, taken from the clocks this kernel really has. */
    static String[][] presets(Map<String, String> st) {
        List<String[]> r = new ArrayList<>();
        for (String id : profiles(st)) {
            String c = profileClocks(st, id), d;
            if (id.equals("battery")) d = (c.isEmpty() ? "Lower CPU caps" : "CPU caps " + c) + ". Thermal limits retained.";
            else if (id.equals("balanced")) d = (c.isEmpty() ? "Stock CPU caps" : "Stock CPU caps " + c) + ". Thermal limits retained.";
            else if (id.equals("performance")) d = "Stock CPU caps, 300 ms touch boost. No overclock or thermal override.";
            else continue;
            r.add(new String[]{id, name(id), d});
        }
        return r.toArray(new String[0][]);
    }

    /** The quick settings tile steps through the profiles on offer; an unknown or custom one starts at the second (Balanced). */
    static String next(Map<String, String> st, String current) {
        List<String> p = profiles(st);
        if (p.isEmpty()) return current;
        int i = p.indexOf(current);
        return p.get(i < 0 ? (p.size() > 1 ? 1 : 0) : (i + 1) % p.size());
    }

    /** The control exists on this device when the backend published its value (the backend publishes a key only when the node or setting is there). */
    static boolean has(Map<String, String> st, String key) { return !get(st, key).isEmpty(); }

    private static boolean numeric(String s) { return number(s); }

    /**
     * A tunable with a fixed list of choices, plus what this kernel really has: its stock value (marked "stock", added when the list lacks it) and the current
     * value when something else set it (marked "current"). The list stays in numeric order when every value is a number, so the user never sees a value that
     * is not on the list and a list that hides the one in use.
     */
    static Choice options(Map<String, String> st, String key, String[] vals, String[] labels, String unit) {
        List<String> v = new ArrayList<>(Arrays.asList(vals)), l = new ArrayList<>(Arrays.asList(labels));
        String stock = get(st, "stock_" + key), cur = get(st, key);
        if (!stock.isEmpty()) {
            int i = v.indexOf(stock);
            if (i >= 0) l.set(i, l.get(i) + " (stock)"); else { v.add(stock); l.add(stock + unit + " (stock)"); }
        }
        if (!cur.isEmpty() && !cur.equals("mixed") && !v.contains(cur)) { v.add(cur); l.add(cur + unit + " (current)"); }
        boolean allNumeric = true;
        for (String x : v) if (!numeric(x)) allNumeric = false;
        if (allNumeric) {   // insertion sort: lists are short
            for (int i = 1; i < v.size(); i++) for (int j = i; j > 0 && Long.parseLong(v.get(j)) < Long.parseLong(v.get(j - 1)); j--) { Collections.swap(v, j, j - 1); Collections.swap(l, j, j - 1); }
        }
        return new Choice(v.toArray(new String[0]), l.toArray(new String[0]));
    }

    /** Display size choices: the sizes the backend offers (percentages of the physical density), "reset" standing for the physical value. */
    static Choice densities(Map<String, String> st) {
        List<String> v = new ArrayList<>(Arrays.asList(csv(get(st, "density_opts")))), l = new ArrayList<>();
        String phys = get(st, "density_phys"), cur = get(st, "density");
        for (String x : v) l.add(x.equals("reset") ? "Stock" + (phys.isEmpty() ? "" : " (" + phys + " dpi)") : x + " dpi");
        if (!v.isEmpty() && !cur.isEmpty() && !cur.equals(phys) && !v.contains(cur)) { v.add(cur); l.add(cur + " dpi (current)"); }
        return new Choice(v.toArray(new String[0]), l.toArray(new String[0]));
    }

    /** The pages this device can offer, in order. Without the backend's state only the pages that read the kernel directly are there. */
    static List<String> pages(Map<String, String> st) {
        List<String> r = new ArrayList<>(Arrays.asList("overview", "live", "perf"));
        if (!st.containsKey("backend")) return r;
        if (st.containsKey("saved_profiles")) r.add("profiles");
        if (st.containsKey("compile_status")) r.add("apps");
        if (has(st, "theme_ok") || has(st, "night")) r.add("look");
        if (has(st, "screen_timeout") || has(st, "anim_scale") || has(st, "nav_mode") || has(st, "density")) r.add("display");
        if (has(st, "swappiness")) r.add("memory");
        if (has(st, "wifi_country") || has(st, "dns") || has(st, "adb_tcp") || has(st, "serial_console")) r.add("connect");
        r.add("system");
        return r;
    }

    private static final String[] TUNABLES = {"swappiness", "vfs_cache", "page_cluster", "watermark", "extra_free", "schedstats", "up_rate", "down_rate", "deep_idle", "io_sched", "read_ahead_kb", "tcp_cc", "gpu_max"};

    /** What "Balanced" is on this kernel, to compare the other settings against: key, value. The values are the stock ones the backend recorded at boot. */
    static String[][] baseline(Map<String, String> st) {
        List<String[]> r = new ArrayList<>();
        String big = get(st, "stock_cap_big"), little = get(st, "stock_cap_little");
        if (big.isEmpty()) big = top(st, "big_freqs");
        if (little.isEmpty()) little = top(st, "little_freqs");
        if (!big.isEmpty()) r.add(new String[]{"cap_big", big});
        if (!little.isEmpty()) r.add(new String[]{"cap_little", little});
        Choice g = governors(st);
        if (!g.empty()) r.add(new String[]{"governor", Arrays.asList(g.vals).contains("schedutil") ? "schedutil" : g.vals[0]});
        if (touch(st)) r.add(new String[]{"touch_duration_ms", "150"});
        for (String k : TUNABLES) { String v = get(st, "stock_" + k); if (!v.isEmpty() && has(st, k)) r.add(new String[]{k, v}); }
        return r.toArray(new String[0][]);
    }
}
