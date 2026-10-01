import UserNotifications


class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        NSLog("[Plotline-SE] didReceive called")
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        // CHANGE #1: Set the SAME App Group ID configured in the main app (Step 3)
        PlotlineBridge.setAppGroupId(groupId: "group.com.plotline.DemoApp")
        NSLog("[Plotline-SE] App group set")

        // CHANGE #2: Pass payload data to Plotline if originating from Plotline
        if PlotlineBridge.isPushPlotline(request: request) {
            NSLog("[Plotline-SE] Plotline push detected, calling onNotificationReceived")
            PlotlineBridge.onNotificationReceived(request: request, contentHandler: contentHandler)
        }
        else {
               NSLog("[Plotline-SE] NOT a Plotline push — passing through")
               contentHandler(bestAttemptContent ?? request.content)
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
