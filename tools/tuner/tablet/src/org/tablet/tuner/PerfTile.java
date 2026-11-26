package org.tablet.tuner;

import android.graphics.drawable.Icon;
import android.service.quicksettings.Tile;
import android.service.quicksettings.TileService;
import java.util.Map;

public class PerfTile extends TileService {
    private static String name(String id) { return id.equals("battery") ? "Battery saver" : id.equals("performance") ? "Responsive" : "Balanced"; }

    /** The profile in use; a custom one counts as Balanced. */
    private String current(Map<String, String> st) {
        String p = st.containsKey("perf_profile") ? st.get("perf_profile") : "balanced";
        return Caps.profiles(st).contains(p) ? p : "balanced";
    }

    private void render(String id) {
        Tile t = getQsTile();
        if (t == null) return;
        t.setIcon(Icon.createWithResource(this, R.drawable.ic_tuner));
        t.setLabel("Performance");
        t.setSubtitle(name(id));
        t.setState(id.equals("balanced") ? Tile.STATE_INACTIVE : Tile.STATE_ACTIVE);
        t.updateTile();
    }

    @Override public void onStartListening() { render(current(Cfg.load(this))); }

    /** Steps through the profiles this kernel's backend offers (Responsive only where the touch boost module exists). */
    @Override public void onClick() {
        Map<String, String> st = Cfg.load(this);
        String next = Caps.next(st, current(st));
        Cfg.request(this, "perf_profile", next);
        render(next);
    }
}
