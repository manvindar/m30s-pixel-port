package org.tablet.tuner;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

/** Run by test_caps_java.py (no JUnit): exits non-zero on the first failed check. */
public final class CapsTest {
    private static void eq(Object want, Object got, String what) {
        if (!String.valueOf(want).equals(String.valueOf(got))) { System.err.println("FAIL " + what + ": want " + want + " got " + got); System.exit(1); }
    }

    private static Map<String, String> live() {   // the state the backend publishes on the mint kernel (values read from the phone)
        Map<String, String> m = new HashMap<>();
        m.put("backend", "m30s"); m.put("caps", "2");
        m.put("governors", "performance,schedutil");
        m.put("profiles", "battery,balanced");
        m.put("profile_battery", "1326000,1768000"); m.put("profile_balanced", "1742000,2314000");
        m.put("touch_supported", "0");
        m.put("io_devices", "sda,sdb,sdc,sdd,sde"); m.put("io_scheds", "noop,cfq"); m.put("io_sched", "cfq");
        m.put("read_aheads", "128,256,512,1024,2048"); m.put("read_ahead_kb", "128");
        m.put("tcp_ccs", "cubic,reno"); m.put("tcp_cc", "cubic");
        m.put("gpu_khz", "260000"); m.put("gpu_freqs", "1053000,949000,839000,764000,683000,572000,546000,455000,385000,338000,260000"); m.put("gpu_max", "-1");
        m.put("little_freqs", "1742000,1638000,1534000,1456000,1326000,1222000,1118000,1053000,910000,806000,702000,598000,403000");
        m.put("big_freqs", "2314000,2210000,2184000,2080000,1976000,1898000,1768000,1664000,1508000,1456000,1352000,1248000,1144000,1040000,936000");
        return m;
    }

    public static void main(String[] a) {
        Map<String, String> st = live();

        // option lists are exactly what the kernel advertises
        eq("performance,schedutil", String.join(",", Caps.governors(st).vals), "governor values");
        eq("Performance,Schedutil", String.join(",", Caps.governors(st).labels), "governor labels");
        eq("noop,cfq", String.join(",", Caps.names(st, "io_scheds").vals), "io values");
        eq("noop,cfq", String.join(",", Caps.names(st, "io_scheds").labels), "io labels are the kernel names");
        eq("cubic,reno", String.join(",", Caps.names(st, "tcp_ccs").vals), "tcp values");
        eq("128 KB,256 KB,512 KB,1 MB,2 MB", String.join(",", Caps.readAhead(st).labels).replace(",", ",").replace("128 KB,", "128 KB,"), "read-ahead labels");
        eq(13, Caps.clocks(st, "little_freqs").vals.length, "little steps");
        eq(15, Caps.clocks(st, "big_freqs").vals.length, "big steps");
        eq("2314000", Caps.top(st, "big_freqs"), "big top");
        eq("2314 MHz", Caps.clocks(st, "big_freqs").labels[0], "big label");
        eq("936 MHz", Caps.clocks(st, "big_freqs").labels[14], "big lowest label");

        // frequencies are sorted whatever order the kernel printed them in, junk is dropped
        Map<String, String> odd = new HashMap<>(); odd.put("big_freqs", "936000,2314000,abc,,1768000,2314000,-5");
        eq("2314000,1768000,936000", String.join(",", Caps.freqs(odd, "big_freqs")), "sorted, unique, numeric");

        // GPU limit: "No limit" first, then the DVFS table; hidden when the backend cannot write it
        Caps.Choice g = Caps.gpuLimit(st);
        eq(12, g.vals.length, "gpu limit count"); eq("-1", g.vals[0], "no limit value"); eq("No limit", g.labels[0], "no limit label");
        eq("1053000", g.vals[1], "gpu top"); eq("1053 MHz", g.labels[1], "gpu top label"); eq("260000", g.vals[11], "gpu lowest");
        Map<String, String> noLock = live(); noLock.remove("gpu_max");
        eq(true, Caps.gpuLimit(noLock).empty(), "no dvfs_max_lock: GPU control hidden");
        Map<String, String> noTable = live(); noTable.remove("gpu_freqs");
        eq(true, Caps.gpuLimit(noTable).empty(), "no dvfs_table: GPU control hidden");
        eq(11, Caps.rulesMhz(st, "gpu_freqs").length, "gpu rules");
        eq(1053f, Caps.rulesMhz(st, "gpu_freqs")[0], "gpu rule value");

        // missing lists hide the control
        Map<String, String> bare = new HashMap<>(); bare.put("backend", "m30s"); bare.put("caps", "2");
        eq(true, Caps.names(bare, "io_scheds").empty(), "no io list"); eq(true, Caps.names(bare, "tcp_ccs").empty(), "no tcp list");
        eq(true, Caps.governors(bare).empty(), "no governor list"); eq(true, Caps.readAhead(bare).empty(), "no read-ahead list");
        eq(true, Caps.clocks(bare, "big_freqs").empty(), "no clock table");

        // touch boost exists only where the backend says so; an old backend is judged by its duration value
        eq(false, Caps.touch(st), "mint kernel has no touch boost");
        st.put("touch_supported", "1"); eq(true, Caps.touch(st), "touch supported");
        Map<String, String> old = new HashMap<>(); old.put("touch_duration_ms", "150");
        eq(true, Caps.touch(old), "old backend with a duration"); eq(false, Caps.touch(new HashMap<String, String>()), "nothing published");
        st.put("touch_supported", "0");

        // profiles: only what the backend accepts, described with this kernel's clocks
        String[][] p = Caps.presets(st);
        eq(2, p.length, "two profiles without touch boost");
        eq("battery", p[0][0]); eq("Battery", p[0][1], "name"); eq("CPU caps 1326 MHz / 1768 MHz. Thermal limits retained.", p[0][2], "battery text");
        eq("balanced", p[1][0]); eq("Stock CPU caps 1742 MHz / 2314 MHz. Thermal limits retained.", p[1][2], "balanced text");
        st.put("profiles", "battery,balanced,performance");
        eq(3, Caps.presets(st).length, "three with touch boost"); eq("Responsive", Caps.presets(st)[2][1], "responsive name");
        st.put("profiles", "battery,balanced");
        eq("balanced", Caps.next(st, "battery"), "tile next"); eq("battery", Caps.next(st, "balanced"), "tile wraps over two");
        eq("balanced", Caps.next(st, "custom"), "unknown starts at balanced");
        eq("performance", Caps.next(withProfiles(st, "battery,balanced,performance"), "balanced"), "three-way cycle");
        eq("battery", Caps.next(withProfiles(st, "battery,balanced,performance"), "performance"), "three-way wrap");
        eq(3, Caps.profiles(new HashMap<String, String>()).size(), "old backend offers three");
        Map<String, String> none = withProfiles(st, ""); eq(0, Caps.profiles(none).size(), "published empty list means none");
        eq("custom", Caps.next(none, "custom"), "no profile to step to");

        // comparison baseline follows the tables and the touch module
        String[][] b = Caps.baseline(st);
        eq("cap_big=2314000,cap_little=1742000,governor=schedutil", join(b), "baseline without touch");
        st.put("touch_supported", "1");
        eq("cap_big=2314000,cap_little=1742000,governor=schedutil,touch_duration_ms=150", join(Caps.baseline(st)), "baseline with touch");
        Map<String, String> noSched = live(); noSched.put("governors", "performance");
        eq("performance", Caps.baseline(noSched)[2][1], "baseline governor is one the kernel has");
        // a tunable keeps its fixed list, adds the stock value (marked) and the value in use when it is not on the list, in numeric order
        Map<String, String> vm = live(); vm.put("extra_free", "29615"); vm.put("stock_extra_free", "29615");
        Caps.Choice ef = Caps.options(vm, "extra_free", new String[]{"0", "24576", "49152", "98304"}, new String[]{"None", "24 MB", "48 MB", "96 MB"}, " KB");
        eq("0,24576,29615,49152,98304", String.join(",", ef.vals), "stock value inserted in order");
        eq("None,24 MB,29615 KB (stock),48 MB,96 MB", String.join(",", ef.labels), "stock labelled");
        vm.put("extra_free", "30000");
        eq("0,24576,29615,30000,49152,98304", String.join(",", Caps.options(vm, "extra_free", new String[]{"0", "24576", "49152", "98304"}, new String[]{"None", "24 MB", "48 MB", "96 MB"}, " KB").vals), "current value kept visible");
        eq("30000 KB (current)", Caps.options(vm, "extra_free", new String[]{"0", "24576", "49152", "98304"}, new String[]{"None", "24 MB", "48 MB", "96 MB"}, " KB").labels[3], "current labelled");
        Map<String, String> sw = live(); sw.put("swappiness", "130"); sw.put("stock_swappiness", "130");
        eq("80,100,130 (stock),160,200", String.join(",", Caps.options(sw, "swappiness", new String[]{"80", "100", "130", "160", "200"}, new String[]{"80", "100", "130", "160", "200"}, "").labels), "stock already on the list");
        Map<String, String> names = new HashMap<>(); names.put("bg_procs", "default");
        eq("default,8,16", String.join(",", Caps.options(names, "bg_procs", new String[]{"default", "8", "16"}, new String[]{"Default", "8", "16"}, "").vals), "non numeric lists keep their order");
        Map<String, String> mixed = live(); mixed.put("up_rate", "mixed");
        eq("0,2000", String.join(",", Caps.options(mixed, "up_rate", new String[]{"0", "2000"}, new String[]{"None", "2 ms"}, " µs").vals), "mixed state adds nothing");

        // display sizes: the backend's list with reset as the physical value
        Map<String, String> dn = live(); dn.put("density_opts", "336,378,reset,462,525"); dn.put("density_phys", "420"); dn.put("density", "420");
        eq("336,378,reset,462,525", String.join(",", Caps.densities(dn).vals), "density values");
        eq("336 dpi,378 dpi,Stock (420 dpi),462 dpi,525 dpi", String.join(",", Caps.densities(dn).labels), "density labels");
        dn.put("density", "400");
        eq("400", Caps.densities(dn).vals[5], "an override from elsewhere stays visible");
        eq(true, Caps.densities(live()).empty(), "no density list, no row");

        // pages: what this device can do decides what is listed
        eq("overview,live,perf", String.join(",", Caps.pages(new HashMap<String, String>())), "no state yet: only what reads the kernel directly");
        eq("overview,live,perf,system", String.join(",", Caps.pages(live())), "an old backend: no saved profiles, compile or settings pages");
        Map<String, String> full = live(); full.put("saved_profiles", ""); full.put("compile_status", "idle"); full.put("night", "auto"); full.put("anim_scale", "1.0");
        full.put("swappiness", "130"); full.put("dns", "auto");
        eq("overview,live,perf,profiles,apps,look,display,memory,connect,system", String.join(",", Caps.pages(full)), "every page");
        full.remove("night"); full.remove("dns"); full.put("compile_status", "missing");
        eq("overview,live,perf,profiles,apps,display,memory,system", String.join(",", Caps.pages(full)), "no theme, no connections");
        full.remove("saved_profiles");
        eq(false, Caps.pages(full).contains("profiles"), "an empty saved list still counts as supported, a missing one does not");
        eq(true, Caps.has(full, "swappiness"), "published control"); eq(false, Caps.has(full, "vfs_cache"), "unpublished control");
        Map<String, String> pr = new HashMap<>(); pr.put("backend", "m30s"); pr.put("saved_profiles", "");
        eq(true, Caps.pages(pr).contains("profiles"), "a published empty list means saved profiles are supported");

        // the baseline is the stock values the backend recorded at boot
        Map<String, String> sb = live(); sb.put("swappiness", "100"); sb.put("stock_swappiness", "130"); sb.put("vfs_cache", "100"); sb.put("stock_vfs_cache", "100"); sb.put("stock_cap_big", "2314000");
        sb.put("stock_up_rate", "5000");   // the control is not there (no up_rate published): not compared
        eq("cap_big=2314000,cap_little=1742000,governor=schedutil,swappiness=130,vfs_cache=100", join(Caps.baseline(sb)), "baseline from stock values");

        // phone layout: three mode cards stack; the card in use is scrolled into view with the least movement
        eq(true, Layouts.stackCards(false, 3), "three cards stack on a phone"); eq(false, Layouts.stackCards(false, 4), "four scroll"); eq(false, Layouts.stackCards(true, 3), "wide layouts have their own grid");
        eq(0, Layouts.scrollTo(0, 0, 230, 360), "first card is already in view");
        eq(100, Layouts.scrollTo(0, 100, 460, 360), "card overhanging the right moves in");
        eq(0, Layouts.scrollTo(500, -10, 230, 360), "never below zero");
        eq(230, Layouts.scrollTo(400, 230, 460, 360), "card hidden on the left moves back");
        eq(150, Layouts.scrollTo(150, 200, 300, 360), "visible card: no movement");
        System.out.println("CapsTest OK");
    }

    private static void eq(Object want, Object got) { eq(want, got, String.valueOf(want)); }

    private static Map<String, String> withProfiles(Map<String, String> st, String v) { Map<String, String> m = new HashMap<>(st); m.put("profiles", v); return m; }

    private static String join(String[][] kv) { StringBuilder sb = new StringBuilder(); for (String[] e : kv) sb.append(sb.length() == 0 ? "" : ",").append(e[0]).append('=').append(e[1]); return sb.toString(); }
}
