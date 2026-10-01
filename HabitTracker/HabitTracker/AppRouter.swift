import SwiftUI

class AppRouter: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var navigateToHabitId: UUID? = nil
    @Published var showSheet: SheetType? = nil

    enum SheetType: Identifiable {
        case addHabit
        case settings

        var id: Int { hashValue }
    }

    func navigate(to screen: String, params: [String: String] = [:]) {
        switch screen {

        case "home":
            selectedTab = 0

        case "add_habit":
            selectedTab = 0
            showSheet = .addHabit

        case "settings":
            selectedTab = 1

        case "habit_detail":
            selectedTab = 0
            if let idString = params["habit_id"],
               let uuid = UUID(uuidString: idString) {
                navigateToHabitId = uuid
            }

        default:
            print("Unknown screen: \(screen)")
        }
    }
}
