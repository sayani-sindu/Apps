import SwiftUI

struct HabitDetailView: View {
    @EnvironmentObject var store: HabitStore
    @State private var detailWidgetHeight: CGFloat = 0
    let habit: Habit

    private var currentHabit: Habit {
        store.habits.first(where: { $0.id == habit.id }) ?? habit
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Hero card
                VStack(spacing: 16) {
                    Text(currentHabit.emoji)
                        .font(.system(size: 60))
                    Text(currentHabit.name)
                        .font(.title2.bold())

                    ZStack {
                        Circle()
                            .stroke(currentHabit.color.opacity(0.2), lineWidth: 10)
                        Circle()
                            .trim(from: 0, to: currentHabit.progress)
                            .stroke(currentHabit.color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .rotationEffect(.degrees(-90))
                            .animation(.spring(), value: currentHabit.progress)
                        VStack(spacing: 2) {
                            Text("\(currentHabit.completedToday)")
                                .font(.largeTitle.bold())
                            Text("of \(currentHabit.goal)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                    .frame(width: 120, height: 120)

                    // Action buttons
                    PlotlineSwiftUIWidget(widgetId: "habit_detail", height: $detailWidgetHeight)
                        .frame(maxWidth: .infinity)
                        .frame(height: detailWidgetHeight)
                    HStack(spacing: 16) {
                        Button {
                            store.incrementProgress(for: currentHabit)
                        } label: {
                            Label("Log", systemImage: "plus.circle.fill")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(currentHabit.isCompletedToday ? Color.gray : currentHabit.color)
                                .cornerRadius(12)
                        }
                        .disabled(currentHabit.isCompletedToday)

                        Button {
                            store.resetProgress(for: currentHabit)
                        } label: {
                            Label("Reset", systemImage: "arrow.counterclockwise")
                                .font(.headline)
                                .foregroundColor(currentHabit.color)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 12)
                                .background(currentHabit.color.opacity(0.1))
                                .cornerRadius(12)
                        }
                    }
                }
                .padding(24)
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)

                // Weekly overview (mock data)
                VStack(alignment: .leading, spacing: 12) {
                    Text("This Week")
                        .font(.headline)

                    HStack(spacing: 0) {
                        ForEach(weekDays, id: \.self) { day in
                            VStack(spacing: 8) {
                                Text(day.label)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                                Circle()
                                    .fill(day.completed ? currentHabit.color : Color(.systemGray5))
                                    .frame(width: 28, height: 28)
                                    .overlay(
                                        day.completed ? Image(systemName: "checkmark")
                                            .font(.caption2.bold())
                                            .foregroundColor(.white) : nil
                                    )
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)

                // Stats
                VStack(alignment: .leading, spacing: 12) {
                    Text("Stats")
                        .font(.headline)

                    HStack(spacing: 16) {
                        StatBox(title: "Streak", value: "\(currentHabit.streak)", unit: "days", color: .orange)
                        StatBox(title: "Goal", value: "\(currentHabit.goal)", unit: "per day", color: .blue)
                        StatBox(title: "Created", value: daysAgo, unit: "days ago", color: .green)
                    }
                }
                .padding(20)
                .background(Color(.systemBackground))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.05), radius: 8, y: 4)
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var daysAgo: String {
        let days = Calendar.current.dateComponents([.day], from: currentHabit.createdAt, to: Date()).day ?? 0
        return "\(days)"
    }

    private var weekDays: [WeekDay] {
        let labels = ["M", "T", "W", "T", "F", "S", "S"]
        let today = Calendar.current.component(.weekday, from: Date())
        return labels.enumerated().map { index, label in
            WeekDay(label: label, completed: index < today - 1)
        }
    }
}

struct WeekDay: Hashable {
    let label: String
    let completed: Bool
}

struct StatBox: View {
    let title: String
    let value: String
    let unit: String
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2.bold())
                .foregroundColor(color)
            Text(unit)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(title)
                .font(.caption)
                .foregroundColor(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(color.opacity(0.08))
        .cornerRadius(10)
    }
}
