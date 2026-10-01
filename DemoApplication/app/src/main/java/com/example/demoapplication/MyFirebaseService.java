package com.example.demoapplication;

import androidx.annotation.NonNull;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import so.plotline.insights.PlotlinePush;

public class MyFirebaseService extends FirebaseMessagingService {

    @Override
    public void onNewToken(@NonNull String token) {
        super.onNewToken(token);
        PlotlinePush.setFcmToken(getApplicationContext(), token);
    }

    @Override
    public void onMessageReceived(@NonNull RemoteMessage remoteMessage) {
        // Check if the push is from Plotline
        if (PlotlinePush.isPushPlotline(remoteMessage.getData())) {
            // Let Plotline render the rich notification
            PlotlinePush.showNotification(getApplicationContext(), remoteMessage.getData());
        } else {
            // Handle your own push notifications here
        }
    }
}