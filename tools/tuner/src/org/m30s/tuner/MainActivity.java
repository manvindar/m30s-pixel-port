package org.m30s.tuner;

import android.app.Activity;
import android.app.AlertDialog;
import android.os.Bundle;
import android.os.Handler;
import android.graphics.Color;
import android.view.View;
import android.widget.*;
import java.io.*;
import java.util.*;

/** M30s controls publish validated requests; only the root backend writes settings. */
public class MainActivity extends Activity {
    private final Handler handler = new Handler();
    private final Map<String,String> state = new HashMap<>();
    private final Map<String,TextView> labels = new HashMap<>();
    private LinearLayout content;
    private TextView live, status;
    private boolean pending;
    private long pendingSince;
    private final Runnable poll = new Runnable() {
        public void run() { readState(); refresh(); handler.postDelayed(this, 1000); }
    };
    public void onCreate(Bundle b) {
        super.onCreate(b); getFilesDir(); readState(); build();
    }
    public void onResume() { super.onResume(); handler.removeCallbacks(poll); handler.post(poll); }
    public void onPause() { handler.removeCallbacks(poll); super.onPause(); }
    private int dp(int n) { return Math.round(n * getResources().getDisplayMetrics().density); }
    private TextView text(String s, int size) {
        TextView t = new TextView(this); t.setText(s); t.setTextSize(size);
        t.setTextColor(Color.rgb(225,233,236)); t.setPadding(0,dp(6),0,dp(6)); return t;
    }
    private String get(String k) { String v=state.get(k); return v==null||v.isEmpty()?"—":v; }
    private void readState() {
        Map<String,String> next=new HashMap<>();
        try (BufferedReader r=new BufferedReader(new FileReader(new File(getFilesDir(),"state")))) {
            String line; while((line=r.readLine())!=null) {
                int at=line.indexOf('='); if(at>0) next.put(line.substring(0,at),line.substring(at+1));
            }
            state.clear();state.putAll(next);
        } catch(IOException ignored) { }
        if(pending && !new File(getFilesDir(),"request").exists() && !new File(getFilesDir(),"request.processing").exists()) pending=false;
        if(pending && System.currentTimeMillis()-pendingSince>8000) {
            pending=false; Toast.makeText(this,"Backend has not confirmed this request",Toast.LENGTH_LONG).show();
        }
    }
    private void request(String key,String value) {
        if(!"m30s".equals(state.get("backend"))) {
            Toast.makeText(this,"M30s service is not connected",Toast.LENGTH_LONG).show(); return;
        }
        if(pending||new File(getFilesDir(),"request").exists()||new File(getFilesDir(),"request.processing").exists()) {
            Toast.makeText(this,"Waiting for the previous change",Toast.LENGTH_SHORT).show();return;
        }
        File tmp=new File(getFilesDir(),"request.new"), dst=new File(getFilesDir(),"request");
        try(FileWriter w=new FileWriter(tmp)) { w.write(key+"="+value+"\n"); }
        catch(IOException e) {Toast.makeText(this,"Could not send change",Toast.LENGTH_LONG).show();return;}
        if(!tmp.renameTo(dst)) {Toast.makeText(this,"Could not queue change",Toast.LENGTH_LONG).show();return;}
        pending=true;pendingSince=System.currentTimeMillis(); status.setText("Applying…");
    }
    private void heading(String s) { TextView t=text(s,19);t.setPadding(0,dp(22),0,dp(8));content.addView(t); }
    private void choice(String title,String key,String[] names,String[] values) {
        LinearLayout row=new LinearLayout(this);row.setOrientation(LinearLayout.VERTICAL);
        row.setPadding(dp(16),dp(12),dp(16),dp(12));row.setBackgroundColor(Color.rgb(29,42,46));
        row.addView(text(title,17)); TextView value=text("—",14);row.addView(value);labels.put(key,value);
        LinearLayout.LayoutParams lp=new LinearLayout.LayoutParams(-1,-2);lp.setMargins(0,0,0,dp(8));content.addView(row,lp);
        row.setOnClickListener(v->new AlertDialog.Builder(this).setTitle(title)
            .setItems(names,(d,index)->request(key,values[index])).setNegativeButton("Cancel",null).show());
    }
    private void cap(String title,String key,String frequencyKey) {
        LinearLayout row=new LinearLayout(this);row.setOrientation(LinearLayout.VERTICAL);row.setPadding(dp(16),dp(12),dp(16),dp(12));
        row.setBackgroundColor(Color.rgb(29,42,46));row.addView(text(title,17));TextView value=text("—",14);row.addView(value);labels.put(key,value);
        LinearLayout.LayoutParams lp=new LinearLayout.LayoutParams(-1,-2);lp.setMargins(0,0,0,dp(8));content.addView(row,lp);
        row.setOnClickListener(v->{
            String available=state.get(frequencyKey);
            if(available==null||available.trim().isEmpty()){Toast.makeText(this,"Frequency table unavailable",Toast.LENGTH_SHORT).show();return;}
            String[] values=available.trim().split("[,\\s]+");String[] names=new String[values.length];
            for(int i=0;i<values.length;i++)names[i]=mhz(values[i])+" MHz";
            new AlertDialog.Builder(this).setTitle(title).setItems(names,(d,index)->request(key,values[index])).setNegativeButton("Cancel",null).show();
        });
    }
    private void build() {
        ScrollView scroll=new ScrollView(this);scroll.setBackgroundColor(Color.rgb(14,23,27));
        content=new LinearLayout(this);content.setOrientation(LinearLayout.VERTICAL);content.setPadding(dp(20),dp(24),dp(20),dp(40));scroll.addView(content);setContentView(scroll);
        content.addView(text("ROM Tuner",30));content.addView(text("Galaxy M30s · Exynos 9611",15));
        status=text("Waiting for M30s service",14);content.addView(status);
        heading("Live readings");live=text("—",16);content.addView(live);
        heading("Performance");
        choice("Profile","perf_profile",new String[]{"Battery saver — lower CPU caps","Balanced — stock CPU caps, 150 ms touch boost","Responsive — stock CPU caps, 300 ms touch boost"},new String[]{"battery","balanced","performance"});
        content.addView(text("Profiles keep schedutil and the existing thermal limits. Responsive extends touch boost; it does not raise maximum clocks.",14));
        cap("Efficiency-core maximum","cap_little","little_freqs");cap("Performance-core maximum","cap_big","big_freqs");
        choice("CPU governor","governor",new String[]{"Schedutil — dynamic clocks","Performance — highest allowed clocks"},new String[]{"schedutil","performance"});
        choice("Touch boost","touch_enabled",new String[]{"Enabled","Disabled"},new String[]{"1","0"});
        choice("Touch boost duration","touch_duration_ms",new String[]{"50 ms","100 ms","150 ms","200 ms","300 ms","500 ms"},new String[]{"50","100","150","200","300","500"});
        heading("Memory and animations");
        choice("Swappiness","swappiness",new String[]{"80","100","130","160","200"},new String[]{"80","100","130","160","200"});
        choice("Animation speed","anim_scale",new String[]{"Off","0.5×","1×","1.5×"},new String[]{"0","0.5","1.0","1.5"});
        content.addView(text("Only explicit changes are saved and reapplied at boot. GPU clocks are read-only. Overclocking, thermal overrides and MediaTek picture controls are unavailable on this device.",14));
        refresh();
    }
    private String mhz(String v) {try{return Long.toString(Long.parseLong(v)/1000);}catch(Exception e){return "—";}}
    private String mib(String v) {try{return Long.toString(Long.parseLong(v)/1024);}catch(Exception e){return "—";}}
    private void refresh() {
        if(status==null)return; if(!pending)status.setText(get("status"));
        live.setText("Efficiency CPU  "+mhz(get("cpu_little_khz"))+" MHz\nPerformance CPU  "+mhz(get("cpu_big_khz"))+" MHz\nMali GPU  "+mhz(get("gpu_khz"))+" MHz\nCPU temperature  "+mhz(get("temp_mc"))+" °C\nBattery  "+get("battery_percent")+"%\nAvailable memory  "+mib(get("mem_available"))+" MiB");
        for(Map.Entry<String,TextView> e:labels.entrySet()) {
            String value=get(e.getKey());
            if(e.getKey().startsWith("cap_"))value=mhz(value)+" MHz";
            if(e.getKey().equals("touch_enabled"))value=(value.equals("Y")||value.equals("1"))?"Enabled":value.equals("N")||value.equals("0")?"Disabled":value;
            if(e.getKey().equals("touch_duration_ms"))value+=" ms";
            if(e.getKey().equals("perf_profile"))value=value.equals("performance")?"Responsive":value.equals("battery")?"Battery saver":value.equals("balanced")?"Balanced":value.equals("—")?"Current settings (unchanged)":value;
            e.getValue().setText(value);
        }
    }
}
