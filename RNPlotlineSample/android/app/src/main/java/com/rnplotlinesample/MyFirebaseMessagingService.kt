package com.rnplotlinesample

import com.google.firebase.messaging.FirebaseMessagingService
import com.google.firebase.messaging.RemoteMessage
import com.reactnativeplotline.RNPlotline

class MyFirebaseMessagingService : FirebaseMessagingService() {

    override fun onNewToken(token: String) {
        super.onNewToken(token)
        RNPlotline.setFcmToken(applicationContext, token)   
    }

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        if (RNPlotline.isPushPlotline(remoteMessage.data)) {
            RNPlotline.showNotification(applicationContext, remoteMessage.data)
        } else {
            // your own (non-Plotline) notifications here
        }
    }
}