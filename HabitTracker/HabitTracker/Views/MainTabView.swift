import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var router: AppRouter

    var body: some View {
        TabView(selection: $router.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(0)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(1)
        }
        .sheet(item: $router.showSheet) { sheet in
            switch sheet {
            case .addHabit:
                AddHabitView()
            case .settings:
                SettingsView()
            }
        }
    }
}
