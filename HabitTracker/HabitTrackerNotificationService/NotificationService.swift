import UserNotifications
import Plotline

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(
        _ request: UNNotificationRequest,
        withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void
    ) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        // Same App Group ID as main app
        PlotlinePush.setAppGroupId(appGroupId: "group.com.plotline.DemoApp")

        if PlotlinePush.isPushPlotline(request: request) {
            PlotlinePush.onNotificationReceived(
                request: request,
                contentHandler: contentHandler
            )
        } else {
            // Not a Plotline push - pass through
            if let bestAttemptContent = bestAttemptContent {
                contentHandler(bestAttemptContent)
            }
        }
    }

    override func serviceExtensionTimeWillExpire() {
        if let contentHandler = contentHandler,
           let bestAttemptContent = bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }
}
