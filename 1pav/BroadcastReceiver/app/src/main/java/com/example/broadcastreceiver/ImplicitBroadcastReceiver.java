package com.example.broadcastreceiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.TextView;

public class ImplicitBroadcastReceiver extends BroadcastReceiver {
    final TextView textView;
    final Context packageContext;

    public ImplicitBroadcastReceiver(TextView textView, Context context) {
        this.textView = textView;
        this.packageContext = context;
    }

    @Override
    public void onReceive(Context context, Intent intent) {
        if ("custom.broadcast".equals(intent.getAction())) {
            String textDisplayed = "Gautas naujas transliavimo pranesimas\n";
            textDisplayed += "Intentas: " + intent.getStringExtra("KEY") + "\n";
            textDisplayed += "Siuntejas: " + intent.getStringExtra("SENDER") + "\n";
            textDisplayed += "Papildoma informacija: " + intent.getStringExtra("EXTRA") + "\n";

            textView.setText(textDisplayed);


            Intent explicitIntent = new Intent("2_Programos_nesist_isreikst_trans");
            explicitIntent.setClassName(
                    "com.example.broadcastsender",
                    "com.example.broadcastsender.ExplicitBroadcastReceiver"
            );
            explicitIntent.putExtra("EXTRA", "Broadcast Receiver gavo intent " + intent.getStringExtra("KEY"));

            packageContext.sendBroadcast(explicitIntent);
        }
    }
}