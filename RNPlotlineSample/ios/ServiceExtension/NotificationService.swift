//
//  NotificationService.swift
//  ServiceExtension
//
//  Created by Sindu on 30/09/26.
//

import UserNotifications
import Plotline

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        print("[Plotline Ext] didReceive. category=\(request.content.categoryIdentifier), aps=\(request.content.userInfo["aps"] ?? "nil"), userInfo=\(request.content.userInfo)")
        print("[Plotline Ext] appGroup container: \(FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.com.plotline.DemoApp4")?.path ?? "nil")")

        PlotlinePush.setAppGroupId(appGroupId: "group.com.plotline.DemoApp4")

        let isPlotlinePush = PlotlinePush.isPushPlotline(request: request)
        print("[Plotline Ext] isPushPlotline = \(isPlotlinePush ? "true" : "false")")
        if isPlotlinePush {
            print("[Plotline Ext] calling onNotificationReceived")
            PlotlinePush.onNotificationReceived(request: request, contentHandler: contentHandler)
        } else if let bestAttemptContent = bestAttemptContent {
            // Non-Plotline push: deliver as-is.
            contentHandler(bestAttemptContent)
        } else {
            contentHandler(request.content)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
