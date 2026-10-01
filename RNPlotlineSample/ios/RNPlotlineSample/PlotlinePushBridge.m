#import "PlotlinePushBridge.h"
#import <UserNotifications/UserNotifications.h>

@implementation PlotlinePushBridge

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(requestPermission)
{
  UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
  [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionSound | UNAuthorizationOptionBadge)
                        completionHandler:^(BOOL granted, NSError *_Nullable error) {
    if (granted) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] registerForRemoteNotifications];
      });
    }
  }];
}

@end