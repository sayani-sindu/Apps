# HabitTracker

An **iOS** app (SwiftUI) demonstrating **Plotline** push notifications and engagement with two app extensions.

## Features

- Habit tracking: Home, Add Habit, Habit Detail, Settings, Onboarding, Main Tab view
- In-memory `HabitStore` + `Habit` model (no backend)
- Plotline SDK: analytics, `identify`, redirects, and rich push notifications
- `HabitTrackerNotificationService` — notification service extension
- `HabitTrackerContentService` — notification content extension
- Swift Package Manager (no CocoaPods)

## Setup

1. Copy `.env.example` to `.env` and set your real Plotline API key:
   ```bash
   cp .env.example .env
   # PLOTLINE_API_KEY=your_plotline_api_key_here
   ```
2. Open `HabitTracker.xcodeproj` in Xcode.
3. Select the **HabitTracker** scheme and a simulator/device, then run.

The `.env` file is read at build time by a "Generate Secrets from .env" build phase, which produces `HabitTracker/Secrets.swift` (git-ignored) with `Secrets.plotlineApiKey`.

## Project structure

```
HabitTracker/
  HabitTrackerApp.swift   # app entry point
  AppDelegate.swift       # Plotline init + push handling
  Models/                 # Habit model
  Store/                  # HabitStore (in-memory)
  Views/                  # SwiftUI screens
HabitTrackerNotificationService/   # notification service extension
HabitTrackerContentService/        # notification content extension
```