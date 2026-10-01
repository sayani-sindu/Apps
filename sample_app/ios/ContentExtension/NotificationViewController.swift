import UIKit
import UserNotifications
import UserNotificationsUI
import Plotline

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Add this line
        NSLog("[Plotline-CE] viewDidLoad")
        PlotlineBridge.setAppGroupId(groupId: "group.com.plotline.DemoApp")
    }
    
    func didReceive(_ notification: UNNotification) {
        //Add this line
        NSLog("[Plotline-CE] didReceive called, category=\(notification.request.content.categoryIdentifier)")
        PlotlineBridge.handleNotificationContent(notification: notification, viewController: self)
    }

}
