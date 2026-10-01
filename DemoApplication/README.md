# DemoApplication

A native **Android** app (Java) demonstrating **Plotline** engagement + Firebase Cloud Messaging.

## Features

- Bottom navigation (Dashboard / Students) using `ViewPager2`
- Student management demo: list, detail, add — with a live student count
- Plotline SDK: `init`, `track`, `identify`, story widgets, in-app nudges and push (`PlotlinePush`)
- Firebase Cloud Messaging (push tokens)
- Local WebView pages (`students.html`, `courses.html`) that embed the Plotline web SDK

## Setup

1. Copy `.env.example` to `.env` and set your real Plotline API key:
   ```bash
   cp .env.example .env
   # PLOTLINE_API_KEY=your_plotline_api_key_here
   ```
2. Open the project in Android Studio (or `./gradlew assembleDebug`).
3. Build & run.

The `.env` file is read by Gradle at build time and exposed to the app via `BuildConfig.PLOTLINE_API_KEY`. The WebView pages inject the key from `BuildConfig` at runtime.

> `app/google-services.json` is committed intentionally — Firebase API keys are public identifiers, not secrets.

## Project structure

```
app/src/main/java/com/example/demoapplication/
  MainActivity.java        # Plotline init, push, redirects
  WebActivity.java         # loads local HTML pages with injected API key
  fragments/               # Dashboard + Student screens
  adapters/                # ViewPager adapter
  assets/                  # local WebView pages (students.html, courses.html)
```