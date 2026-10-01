import Foundation
import SwiftUI

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var emoji: String
    var goal: Int
    var completedToday: Int
    var streak: Int
    var colorHex: String
    var createdAt: Date

    init(
        id: UUID = UUID(),
        name: String,
        emoji: String = "🎯",
        goal: Int = 1,
        completedToday: Int = 0,
        streak: Int = 0,
        colorHex: String = "007AFF",
        createdAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.goal = goal
        self.completedToday = completedToday
        self.streak = streak
        self.colorHex = colorHex
        self.createdAt = createdAt
    }

    var progress: Double {
        guard goal > 0 else { return 0 }
        return min(Double(completedToday) / Double(goal), 1.0)
    }

    var isCompletedToday: Bool {
        completedToday >= goal
    }

    var color: Color {
        Color(hex: colorHex)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6:
            r = Double((int >> 16) & 0xFF) / 255
            g = Double((int >> 8) & 0xFF) / 255
            b = Double(int & 0xFF) / 255
        default:
            r = 0; g = 0; b = 0
        }
        self.init(red: r, green: g, blue: b)
    }
}
