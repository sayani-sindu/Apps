# RNPlotlineSample

A **React Native 0.76.5** app (New Architecture enabled: Fabric + TurboModules) used to **integration-test the Plotline SDK** — verifying Plotline works correctly in a React Native app (events, push, WebView bridge).

## Features

- E-commerce style demo: Home, Products, Product Detail, Cart, Profile
- Web tab: local HTML store page in a `WebView` with a JS bridge
- Bridge tab: bidirectional RN ↔ WebView messaging
- Push notifications on Android

## Setup

1. Install JS dependencies:
   ```bash
   npm install
   ```
2. Copy `.env.example` to `.env` and set your API key:
   ```bash
   cp .env.example .env
   # PLOTLINE_API_KEY=your_plotline_api_key_here
   ```
3. iOS only — install pods with new arch:
   ```bash
   cd ios && RCT_NEW_ARCH_ENABLED=1 pod install && cd ..
   ```
4. Run:
   ```bash
   npm start        # Metro
   npm run android  # or
   npm run ios
   ```

The key is loaded via `react-native-dotenv` from `@env` and used by the app (`App.tsx`) and the WebView store page (`src/screens/web/shopHtml.js`).

## Project structure

```
App.tsx                    # navigation (tabs + stack) + app init
src/data/products.ts        # sample data
src/screens/                # screens incl. WebView + Bridge
src/screens/web/            # shopHtml.js (web store, key from @env)
android/app/google-services.json   # Firebase (Android only)
```