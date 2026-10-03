import UIKit
import UserNotifications
import Plotline

class AppDelegate: NSObject,
                   UIApplicationDelegate,
                   UNUserNotificationCenterDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
            [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        print("[Push] AppDelegate started")

        PlotlinePush.setAppGroupId(
            appGroupId: "group.com.plotline.DemoApp"
        )

        Plotline.initialize(
            apiKey: Secrets.plotlineApiKey,
            userId: "sindu_test1"
        )

        PlotlinePush.enablePush(self)
        UNUserNotificationCenter.current().delegate = self

        // These should run regardless of notification permission.
        Plotline.identify(attributes: [
            "plan": "free",
            "onboarding_completed": "true",
            "total_habits": "5",
            "uiMode": "light"
        ])

        Plotline.setLocale(locale: "en")

        Plotline.setPlotlineRedirectListener {
            (keyValuePairs: [String: String]) in

            DispatchQueue.main.async {
                if let screen = keyValuePairs["screen"] {
                    NotificationCenter.default.post(
                        name: .plotlineRedirect,
                        object: nil,
                        userInfo: [
                            "screen": screen,
                            "params": keyValuePairs
                        ]
                    )
                } else if let urlString = keyValuePairs["url"],
                          let url = URL(string: urlString),
                          let scheme = url.scheme?.lowercased(),
                          ["https", "http"].contains(scheme) {
                    UIApplication.shared.open(url)
                }
            }
        }

        // Request permission for visible notifications.
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            print("[Push] Permission granted: \(granted)")

            if let error = error {
                print("[Push] Permission error: \(error.localizedDescription)")
            }

            guard granted else { return }

            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        } // Permission callback ends here.

        return true
    } // Launch method ends here.

    // These are class methods, NOT nested inside the launch method.

    func application(
        _ application: UIApplication,
        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
        print("[Push] APNs token received")
        let token = deviceToken.map { String(format: "%02x", $0) }.joined()
        print("[Push] Token suffix: \(token.suffix(8))")
        print("[Push] Bundle: \(Bundle.main.bundleIdentifier ?? "unknown")")
        PlotlinePush.setPushToken(deviceToken: deviceToken)
    }

    func application(
        _ application: UIApplication,
        didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
        print("[Push] Registration failed: \(error.localizedDescription)")
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler:
            @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        PlotlinePush.onNotificationReceived(
            notification: notification,
            completionHandler: completionHandler
        )
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        PlotlinePush.userNotificationCenter(
            center: center,
            didReceive: response
        )
        completionHandler()
    }
} // AppDelegate ends here.

extension Notification.Name {
    static let plotlineRedirect = Notification.Name("plotlineRedirect")
}
