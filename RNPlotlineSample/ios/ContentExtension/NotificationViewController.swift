//
//  NotificationViewController.swift
//  ContentExtension
//
//  Created by Sindu on 30/09/26.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import Plotline

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add this line
        PlotlinePush.setAppGroupId(appGroupId: "group.com.plotline.DemoApp4")
        print("[Plotline Content] viewDidLoad. appGroup container: \(FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.plotline.DemoApp4")?.path ?? "nil")")
    }
    
    func didReceive(_ notification: UNNotification) {
        print("[Plotline Content] didReceive. category=\(notification.request.content.categoryIdentifier), userInfo=\(notification.request.content.userInfo)")
        print("[Plotline Content] isPushPlotline = \(PlotlinePush.isPushPlotline(request: notification.request) ? "true" : "false")")
        //Add this line
        PlotlinePush.handleNotificationContent(notification, inViewController: self)
    }

}

