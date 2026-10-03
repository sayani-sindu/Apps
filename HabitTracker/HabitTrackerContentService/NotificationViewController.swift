import UIKit
import UserNotifications
import UserNotificationsUI
import Plotline

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    override func viewDidLoad() {
        super.viewDidLoad()
        PlotlinePush.setAppGroupId(appGroupId: "group.com.plotline.DemoApp")
    }

    func didReceive(_ notification: UNNotification) {
        PlotlinePush.handleNotificationContent(notification, inViewController: self)
    }
}