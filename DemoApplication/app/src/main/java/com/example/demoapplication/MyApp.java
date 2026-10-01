package com.example.demoapplication;

import android.app.Application;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.os.Build;

import org.json.JSONObject;

import so.plotline.insights.Activities.PlotlineNotificationListener;
import so.plotline.insights.Models.PlotlineNotificationConfig;
import so.plotline.insights.Plotline;
import so.plotline.insights.PlotlinePush;

// Application is a base class provided by Android.
// Extend it to create your own global app entry point.
// This class is instantiated before anything else in your app.
public class MyApp extends Application {

    // onCreate here is NOT the same as Activity's onCreate.
    // This onCreate runs when the APP starts, not when a screen opens.
    // It runs exactly once for the entire app lifetime.
    @Override
    public void onCreate() {
        super.onCreate();
        Plotline.registerApplication(this);

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    "default",                           // Must match dashboard channel ID
                    "General Notifications",
                    NotificationManager.IMPORTANCE_HIGH   // Shows heads-up banner + sound
            );
            channel.setDescription("App notifications");
            channel.enableVibration(true);

            NotificationManager manager = getSystemService(NotificationManager.class);
            manager.createNotificationChannel(channel);
        }

        PlotlinePush.setPlotlineNotificationMetaData(
                this,
                new PlotlineNotificationConfig(R.drawable.small_icon)
        );

        PlotlinePush.setPlotlineNotificationClickListener(new PlotlineNotificationListener() {
            @Override
            public void onNotificationClickedPayloadReceived(JSONObject customData) {
                // Handle push click navigation here
                // customData contains key-value pairs from the dashboard
            }
        });


    }
}