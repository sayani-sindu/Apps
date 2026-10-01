import SwiftUI

@main
struct HabitTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var store = HabitStore()
    @StateObject private var router = AppRouter()
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                MainTabView()
                    .environmentObject(store)
                    .environmentObject(router)
                    .onReceive(NotificationCenter.default.publisher(for: .plotlineRedirect)) { notification in
                        guard let userInfo = notification.userInfo,
                              let screen = userInfo["screen"] as? String else { return }

                        router.navigate(to: screen, params: userInfo["params"] as? [String: String] ?? [:])
                    }
            } else {
                OnboardingView(hasCompletedOnboarding: $hasCompletedOnboarding)
            }
        }
    }
}
