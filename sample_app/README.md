# sample_app

A **Flutter** app used to **integration-test the Plotline SDK** — verifying Plotline works correctly in a Flutter app (events, push notifications, in-app WebView).

## Features

- Screens: Home, Feed, Details, Profile, Settings, WebView
- Bottom navigation (Home / Feed / Profile / Settings)
- Named routes with argument passing (Feed → Details)
- Push notifications on Android (foreground + background handlers)
- Local WebView page (`assets/sample.html`)

## Setup

1. Fetch dependencies:
   ```bash
   flutter pub get
   ```
2. Copy `.env.example` to `.env` and set your API key:
   ```bash
   cp .env.example .env
   # PLOTLINE_API_KEY=your_plotline_api_key_here
   ```
3. Run:
   ```bash
   flutter run
   ```
   Requires Flutter 3.24+ / Dart 3.5+.

The key is loaded with `flutter_dotenv` (`.env` is registered as an asset) and used by the app (`lib/main.dart`) and the WebView page (`lib/screens/web_view_screen.dart` injects it into `assets/sample.html` at runtime).

> `lib/firebase_options.dart`, `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist` are committed intentionally — Firebase API keys are public identifiers, not secrets.

## Project structure

```
lib/
  main.dart                    # app entry + Firebase
  firebase_options.dart        # FlutterFire config
  screens/                     # Home, Feed, Details, Profile, Settings, WebView, RootNav
  screens/nav_state.dart       # bottom nav state
assets/sample.html             # local WebView page (key injected at runtime)
```