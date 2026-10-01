import 'dart:io'; // <-- added: needed for Platform.isAndroid
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:plotline_engage/observer.dart';
import 'package:plotline_engage/plotline.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // <-- added
import 'firebase_options.dart';

import 'screens/root_nav.dart';
import 'screens/nav_state.dart';
import 'screens/details_screen.dart';
import 'screens/web_view_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Background Message received!");
  Plotline.showNotification(message.data);
}


Future<void> initialiseFirebase() async {
  if (!Platform.isAndroid) return;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;
  if (Platform.isAndroid) {
    NotificationSettings notificationSettings =
        await messaging.requestPermission(provisional: true);
    String? fcmToken;
    if (notificationSettings.authorizationStatus ==
        AuthorizationStatus.authorized) {
      debugPrint("Granted permission!");
      try {
        fcmToken = await messaging.getToken();
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
    debugPrint("fcm token: $fcmToken");

    if (fcmToken != null) {
      Plotline.setFcmToken(fcmToken);

      // Foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint("Message received!");
        Plotline.showNotification(message.data);
      });
    }

    messaging.onTokenRefresh.listen((receivedToken) {
      fcmToken = receivedToken;
      if (fcmToken != null) {
        Plotline.setFcmToken(fcmToken!);
      }
    });
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  Plotline.init(
      dotenv.env['PLOTLINE_API_KEY'] ?? '', "sindu_test");

      Plotline.requestPushPermission();

  Plotline.identify({
    "name": "Sindu",
    "plan": "free",
    "city": "Bengaluru",
  });
  Plotline.setLocale("en");
  Plotline.identify({"uiMode": "dark"});

  Plotline.setPlotlineNotificationClickListener((properties) {
    print('Notification clicked: $properties');
  });

  Plotline.setPlotlineRedirectListener((properties) {
    final screen = properties['screen'];
    print(properties.values.toString());

    if (screen == 'webview') {
      final src = '${properties['url'] ?? 'sample.html'}';
      navigatorKey.currentState?.pushNamed(
        WebViewScreen.routeName,
        arguments: src,
      );
      return;
    }

    // Details = a real route -> push it
    if (screen == 'details') {
      final id = int.tryParse('${properties['item_id']}') ?? 0;
      final item =
          FeedItem(id: id, title: 'Item #$id', subtitle: 'From redirect');
      navigatorKey.currentState
          ?.pushNamed(DetailsScreen.routeName, arguments: item);
      return;
    }

    // Home / Feed / Profile / Settings = tabs -> switch tab index
    final idx = tabIndex[screen];
    if (idx != null) {
      navigatorKey.currentState?.popUntil((r) => r.isFirst); // close Details if open
      selectedTab.value = idx;                                // tell RootNav to switch
    }
  });

  // Initialise Firebase + push, then register the background handler.
  await initialiseFirebase();
  if (Platform.isAndroid) {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  runApp(const SampleApp());
}

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return PlotlineWrapper(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Sample App',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [PlotlineNavigationObserver()],
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),

        // RootNav hosts the bottom navigation and is the home route.
        initialRoute: RootNav.routeName,
        routes: {
          RootNav.routeName: (_) => const RootNav(),
        },
        // Routes that need arguments are handled here.
        onGenerateRoute: (settings) {
          if (settings.name == DetailsScreen.routeName) {
            final item = settings.arguments as FeedItem;
            return MaterialPageRoute(
              builder: (_) => DetailsScreen(item: item),
              settings: settings,
            );
          }
          if (settings.name == WebViewScreen.routeName) {
            return MaterialPageRoute(
              builder: (_) => const WebViewScreen(),
              settings: settings,
            );
          }
          return null;
        },
      ),
    );
  }
}