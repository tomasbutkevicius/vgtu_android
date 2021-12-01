package com.example.broadcastsender;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ExplicitBroadcastReceiver.receivedText = findViewById(R.id.text_view);
    }

    // IMPLICIT BROADCAST. MEANS YOU NEED TO REGISTER WITH FILTER TO RECEIVE IT.
    public void sendBroadcast(View v) {
        Intent intent = new Intent("custom.broadcast");
        intent.putExtra("KEY", "1_Programos_nesist_trans");
        intent.putExtra("SENDER", "Broadcast Sender");
        intent.putExtra("EXTRA", "Hello World");
        sendBroadcast(intent);
    }
}