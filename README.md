# Apps

A collection of mobile sample apps for testing purposes, covering different platforms and frameworks.

| App | Platform | Framework | Description |
|-----|----------|-----------|-------------|
| [DemoApplication](./DemoApplication) | Android | Java | Student-management demo (CRUD + dashboard) with push notifications and WebView integration. |
| [HabitTracker](./HabitTracker) | iOS | SwiftUI | Habit-tracking app with a notification service extension and a notification content extension. |
| [RNPlotlineSample](./RNPlotlineSample) | Android & iOS | React Native | E-commerce style demo (Home, Products, Cart, Profile, Web, Bridge). |
| [sample_app](./sample_app) | Android & iOS | Flutter | Multi-screen demo (Home, Feed, Details, Profile, Settings, WebView). |

## Requirements

- [Android Studio](https://developer.android.com/studio) — for `DemoApplication`
- [Xcode](https://developer.apple.com/xcode/) — for `HabitTracker`
- [Node.js](https://nodejs.org/) ≥ 18 + React Native CLI — for `RNPlotlineSample`
- [Flutter](https://flutter.dev/) SDK — for `sample_app`

## Setup

Each app keeps its configuration keys in a local `.env` file which is **git-ignored**. To run an app:

1. Copy `.env.example` to `.env` inside the app folder.
2. Fill in the required API keys.
3. Build & run with the app's standard tooling.

See each app's `README.md` for details.

> **Note on Firebase keys:** `google-services.json`, `GoogleService-Info.plist` and `firebase_options.dart` are committed intentionally. Firebase API keys are public identifiers (not secrets) — access control is enforced by Firebase Security Rules and App Check, per Google's guidance.