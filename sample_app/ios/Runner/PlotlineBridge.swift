//
//  PlotlineBridge.swift
//  Runner
//
//  Created by Sindu on 15/09/26.
//

import UserNotifications
import Plotline
import UIKit

public class PlotlineBridge {
    public static func isPushPlotline(request: UNNotificationRequest) -> Bool {
        return PlotlinePush.isPushPlotline(request: request)
    }
    
    public static func onNotificationReceived(request: UNNotificationRequest, contentHandler: @escaping (UNNotificationContent) -> Void) {
        PlotlinePush.onNotificationReceived(request: request, contentHandler: contentHandler)
    }
    
    public static func setAppGroupId(groupId: String) {
        PlotlinePush.setAppGroupId(appGroupId: groupId)
    }
    
    public static func handleNotificationContent(notification: UNNotification, viewController: UIViewController) {
        PlotlinePush.handleNotificationContent(notification, inViewController: viewController)
    }
}
