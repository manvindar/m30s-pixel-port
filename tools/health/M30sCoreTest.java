package shim;
import java.io.File;
import java.nio.file.Files;

/** Real Samsung values and a changing-capacity fixture, without Android/device writes. */
public class M30sCoreTest {
    static File root;
    static void put(String node, String value) throws Exception {
        File dir = new File(root, "battery"); dir.mkdirs();
        Files.write(new File(dir, node).toPath(), (value + "\n").getBytes());
    }
    static void check(boolean value, String name) {
        if (!value) throw new AssertionError(name);
        System.out.println("PASS " + name);
    }
    public static void main(String[] args) throws Exception {
        root = Files.createTempDirectory("m30s-health").toFile();
        put("type", "Battery"); put("present", "1"); put("health", "Good");
        put("capacity", "100"); put("status", "Full");
        put("charge_counter", "5361000"); put("charge_full", "6000000");
        put("voltage_now", "4311000"); put("temp", "305");
        File usb = new File(root, "usb"); usb.mkdirs();
        Files.write(new File(usb, "type").toPath(), "USB\n".getBytes());
        Files.write(new File(usb, "online").toPath(), "1\n".getBytes());
        HealthCore core = new HealthCore(root.getPath());
        HealthCore.Info i = core.read();
        if (args.length > 0 && args[0].equals("upstream")) {
            check(i.level == 89 && i.levelCorrected && i.status == HealthCore.CHARGING,
                  "unmodified Lenovo policy reproduces measured Samsung 89% mismatch");
            return;
        }
        check(i.level == 100 && i.status == HealthCore.FULL && !i.levelCorrected,
              "Samsung kernel full capacity preserved despite nominal counter ratio");
        check(i.chargeCounterUah == 5361000 && i.fullChargeUah == 6000000,
              "charge counter and nominal full capacity remain accurate raw properties");
        check(i.voltageMv == 4311 && i.tempTenthsC == 305 && i.usb,
              "voltage temperature and USB reporting unchanged");
        put("capacity", "90"); put("status", "Discharging");
        put("charge_counter", "3000000"); put("current_now", "-450000");
        Files.write(new File(usb, "online").toPath(), "0\n".getBytes());
        i = core.read();
        check(i.level == 90 && i.status == HealthCore.DISCHARGING && i.currentUa == -450000 && !i.usb,
              "decreasing kernel capacity and discharge sign follow new readings");
        put("capacity", "12"); i = core.read();
        check(i.level == 12 && !i.levelCorrected, "low capacity not overwritten by charge ratio");
        put("capacity", "0"); i = core.read();
        check(i.level == 0, "empty battery remains zero");
    }
}
