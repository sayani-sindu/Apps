import SwiftUI
import Plotline

struct AddHabitView: View {
    @EnvironmentObject var store: HabitStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var emoji = "🎯"
    @State private var goal = 1
    @State private var selectedColorHex = "007AFF"

    private let emojiOptions = [
        "🎯", "💧", "📚", "🏋️", "🧘",
        "✍️", "🏃", "🎨", "🎵", "💤",
        "🥗", "💊", "🧹", "📱", "🌱"
    ]

    private let colorOptions = [
        "007AFF", "34C759", "FF9500", "FF3B30",
        "AF52DE", "FF2D55", "5856D6", "00C7BE"
    ]

    var body: some View {
        NavigationStack {
            Form {
                Section("Habit Name") {
                    TextField("e.g. Drink Water", text: $name)
                        .PLabel("Habit Name")
                }

                Section("Icon") {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible()),
                            count: 5
                        ),
                        spacing: 12
                    ) {
                        ForEach(emojiOptions, id: \.self) { option in
                            Text(option)
                                .font(.title2)
                                .frame(width: 44, height: 44)
                                .background(
                                    emoji == option
                                        ? Color.blue.opacity(0.2)
                                        : Color(.systemGray6)
                                )
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            emoji == option
                                                ? Color.blue
                                                : Color.clear,
                                            lineWidth: 2
                                        )
                                )
                                .onTapGesture {
                                    emoji = option
                                }
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Daily Goal") {
                    Stepper(
                        "\(goal) time\(goal == 1 ? "" : "s") per day",
                        value: $goal,
                        in: 1...50
                    )
                }

                Section("Color") {
                    LazyVGrid(
                        columns: Array(
                            repeating: GridItem(.flexible()),
                            count: 4
                        ),
                        spacing: 12
                    ) {
                        ForEach(colorOptions, id: \.self) { hex in
                            ColorOptionView(
                                hex: hex,
                                isSelected: selectedColorHex == hex
                            ) {
                                selectedColorHex = hex
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        let habit = Habit(
                            name: name,
                            emoji: emoji,
                            goal: goal,
                            colorHex: selectedColorHex
                        )

                        store.addHabit(habit)

                        Plotline.track(
                            eventName: "habit added"
                        )

                        dismiss()
                    }
                    .disabled(
                        name
                            .trimmingCharacters(
                                in: .whitespaces
                            )
                            .isEmpty
                    )
                    .bold()
                }
            }
        }
    }
}

// MARK: - Color Option

struct ColorOptionView: View {
    let hex: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Circle()
            .fill(Color(hex: hex))
            .frame(width: 36, height: 36)
            .overlay {
                Circle()
                    .stroke(
                        Color.primary,
                        lineWidth: isSelected ? 3 : 0
                    )
                    .padding(-3)
            }
            .onTapGesture {
                onTap()
            }
    }
}
