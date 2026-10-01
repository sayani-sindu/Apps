import Flutter
import UIKit
import plotline_engage

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // 1) Register Flutter plugins FIRST — wires up plotline_engage's method channel
    GeneratedPluginRegistrant.register(with: self)

    // 2) Set App Group (MUST match the App Group ID in Xcode capabilities + the extension)
    PlotlineBridge.setAppGroupId(groupId: "group.com.plotline.DemoApp")

    // 3) Enable Plotline push (triggers the iOS permission prompt)
      NSLog("[Plotline] About to call enablePush")
      PlotlinePlugin.enablePush(self)
      NSLog("[Plotline] enablePush returned")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
      NSLog("[Plotline] Got APNs token: \(deviceToken)")
    PlotlinePlugin.setDeviceToken(deviceToken: deviceToken)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    PlotlinePlugin.onNotificationReceived(notification: notification, completionHandler: completionHandler)
  }

  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    PlotlinePlugin.plotlineUserNotificationCenter(center: center, didReceive: response)
    completionHandler()
  }
    
    override func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error
    ) {
      NSLog("[Plotline] APNs registration FAILED: \(error.localizedDescription)")
    }
}

