import Foundation
import SwiftUI
import Plotline

class HabitStore: ObservableObject {
    @Published var habits: [Habit] = []

    private let saveKey = "saved_habits"

    init() {
        loadSampleData()
    }

    private func loadSampleData() {
        habits = [
            Habit(name: "Drink Water", emoji: "💧", goal: 8, completedToday: 5, streak: 12, colorHex: "34C759"),
            Habit(name: "Read 30 min", emoji: "📚", goal: 1, completedToday: 0, streak: 7, colorHex: "FF9500"),
            Habit(name: "Exercise", emoji: "🏋️", goal: 1, completedToday: 1, streak: 3, colorHex: "FF3B30"),
            Habit(name: "Meditate", emoji: "🧘", goal: 1, completedToday: 0, streak: 21, colorHex: "AF52DE"),
            Habit(name: "Journal", emoji: "✍️", goal: 1, completedToday: 0, streak: 5, colorHex: "007AFF"),
        ]
    }

    func addHabit(_ habit: Habit) {
        habits.insert(habit, at: 0)
        Plotline.track(eventName: "Added habit", properties: ["name": habit.name])
    }

    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
        Plotline.track(eventName: "Habit Deleted")
    }

    func incrementProgress(for habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        if habits[index].completedToday < habits[index].goal {
            habits[index].completedToday += 1
            if habits[index].isCompletedToday {
                Plotline.track(eventName: "habit_completed", properties: [
                                "habit_name": habits[index].name,
                                "streak": "\(habits[index].streak)"
                            ])
                habits[index].streak += 1
            }
        }
    }

    func resetProgress(for habit: Habit) {
        guard let index = habits.firstIndex(where: { $0.id == habit.id }) else { return }
        habits[index].completedToday = 0
    }

    var completedCount: Int {
        habits.filter { $0.isCompletedToday }.count
    }

    var totalCount: Int {
        habits.count
    }

    var overallProgress: Double {
        guard !habits.isEmpty else { return 0 }
        let total = habits.reduce(0.0) { $0 + $1.progress }
        return total / Double(habits.count)
    }
}
