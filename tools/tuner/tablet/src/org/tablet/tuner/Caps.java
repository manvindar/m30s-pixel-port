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

    /** What "Balanced" is on this kernel, to compare the other settings against: key, value. Touch boost only when the module exists. */
    static String[][] baseline(Map<String, String> st) {
        List<String[]> r = new ArrayList<>();
        String big = top(st, "big_freqs"), little = top(st, "little_freqs");
        if (!big.isEmpty()) r.add(new String[]{"cap_big", big});
        if (!little.isEmpty()) r.add(new String[]{"cap_little", little});
        Choice g = governors(st);
        if (!g.empty()) r.add(new String[]{"governor", Arrays.asList(g.vals).contains("schedutil") ? "schedutil" : g.vals[0]});
        if (touch(st)) r.add(new String[]{"touch_duration_ms", "150"});
        return r.toArray(new String[0][]);
    }
}
