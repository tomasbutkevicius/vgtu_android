package com.example.broadcastreceiver;

import androidx.appcompat.app.AppCompatActivity;

import android.content.IntentFilter;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private TextView textView;
    ImplicitBroadcastReceiver implicitBroadcastReceiver;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textView = findViewById(R.id.text_view);
        implicitBroadcastReceiver = new ImplicitBroadcastReceiver(textView, this);

        IntentFilter filter = new IntentFilter("custom.broadcast");
        registerReceiver(implicitBroadcastReceiver, filter);
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
        unregisterReceiver(implicitBroadcastReceiver);
    }
}