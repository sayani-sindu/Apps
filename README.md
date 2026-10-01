# Apps

A collection of demo applications, each showcasing the [Plotline](https://www.plotline.so/) engagement SDK across different mobile platforms and frameworks.

| App | Platform | Framework | Description |
|-----|----------|-----------|-------------|
| [DemoApplication](./DemoApplication) | Android | Java | Student-management demo (CRUD + dashboard) with Plotline SDK, Firebase Cloud Messaging and WebView integration. |
| [HabitTracker](./HabitTracker) | iOS | SwiftUI | Habit-tracking app with Plotline push notifications, a notification service extension and a content extension. |
| [RNPlotlineSample](./RNPlotlineSample) | Android & iOS | React Native | E-commerce style demo (Home, Products, Cart, Profile, Web, Bridge) using the `plotline-engage` npm SDK. |
| [sample_app](./sample_app) | Android & iOS | Flutter | Multi-screen demo (Home, Feed, Details, Profile, Settings, WebView) using the `plotline_engage` Flutter package and Firebase. |

## Requirements

- [Android Studio](https://developer.android.com/studio) — for `DemoApplication`
- [Xcode](https://developer.apple.com/xcode/) — for `HabitTracker`
- [Node.js](https://nodejs.org/) ≥ 18 + React Native CLI — for `RNPlotlineSample`
- [Flutter](https://flutter.dev/) SDK — for `sample_app`

## Setup

Each app keeps its secrets in a local `.env` file which is **git-ignored**. To run an app:

1. Copy `.env.example` to `.env` inside the app folder.
2. Fill in your real **Plotline API key** (from the Plotline dashboard).
3. Build & run with the app's standard tooling.

See each app's `README.md` for details.

> **Note on Firebase keys:** `google-services.json`, `GoogleService-Info.plist` and `firebase_options.dart` are committed intentionally. Firebase API keys are public identifiers (not secrets) — access control is enforced by Firebase Security Rules and App Check, per Google's guidance.