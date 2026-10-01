#import "AppDelegate.h"

#import <React/RCTBundleURLProvider.h>
#import <Plotline/Plotline-Swift.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.moduleName = @"RNPlotlineSample";
  // You can add your custom initial props in the dictionary below.
  // They will be passed down to the ViewController used by React Native.
  self.initialProps = @{};

  // Route notification handling through Plotline
  [PlotlinePush setAppGroupIdWithAppGroupId:@"group.com.plotline.DemoApp4"];
  [PlotlinePush enablePush:self];

  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  center.delegate = self;
  // Notification permission + APNs registration is requested explicitly
  // from JS (PlotlinePushBridge) so it behaves like Android.

  // Handle a tap that launched the app from a notification (cold start)
  [PlotlinePush handleNotificationClicks];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

// Forward the APNs device token to Plotline
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
  [PlotlinePush setPushTokenWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
  NSLog(@"[Plotline] Remote notification registration failed: %@", error.localizedDescription);
}

// Objective-C (Add separate functions in AppDelegate)
// Handling foreground Notifications
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       willPresentNotification:(UNNotification *)notification
         withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler
{
    // Call PlotlinePush to handle the notification
  [PlotlinePush onNotificationReceivedWithNotification:notification completionHandler:completionHandler];
}

// Handling notifications when the user interacts with them
- (void)userNotificationCenter:(UNUserNotificationCenter *)center
       didReceiveNotificationResponse:(UNNotificationResponse *)response
                withCompletionHandler:(void (^)(void))completionHandler
{
    NSDictionary *userInfo = response.notification.request.content.userInfo;
    NSDictionary *data = userInfo[@"data"];
    
    // Custom data handling (if needed)
    if (data != nil) {
        // Handle your custom data here
    }

    // Call PlotlinePush to handle the notification response
    [PlotlinePush userNotificationCenterWithCenter:center didReceive:response];

    // Call completion handler
    completionHandler();
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
  return [self bundleURL];
}

- (NSURL *)bundleURL
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index"];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
