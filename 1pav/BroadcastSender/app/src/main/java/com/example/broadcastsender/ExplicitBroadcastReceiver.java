package com.example.broadcastsender;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.TextView;
import android.widget.Toast;

public class ExplicitBroadcastReceiver extends BroadcastReceiver {
    static TextView receivedText;

    @Override
    public void onReceive(Context context, Intent intent) {
        Toast.makeText(context,  intent.getStringExtra("EXTRA"), Toast.LENGTH_SHORT).show();
        receivedText.setText(intent.getStringExtra("EXTRA"));
    }
}
