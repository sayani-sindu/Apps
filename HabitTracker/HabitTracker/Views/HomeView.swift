import SwiftUI
import Plotline

struct HomeView: View {
    @EnvironmentObject var store: HabitStore
    @State private var showAddHabit = false
    @State private var bannerHeight: CGFloat = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    summaryCard
                    
                    PlotlineSwiftUIWidget(widgetId: "home_banner", height: $bannerHeight)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: bannerHeight)

                    LazyVStack(spacing: 12) {
                        ForEach(store.habits) { habit in
                            NavigationLink(destination: HabitDetailView(habit: habit)) {
                                HabitRowView(habit: habit)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding()
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Today")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddHabit = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $showAddHabit) {
                AddHabitView()
            }
        }
    }

    private var summaryCard: some View {
        VStack(spacing: 16) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(formattedDate)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .PLabel("Date")
                    Text("\(store.completedCount) of \(store.totalCount) done")
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .PLabel("count")
                }
                Spacer()
                ZStack {
                    Circle()
                        .stroke(Color.white.opacity(0.3), lineWidth: 6)
                    Circle()
                        .trim(from: 0, to: store.overallProgress)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 6, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                    Text("\(Int(store.overallProgress * 100))%")
                        .PLabel("Progress")
                        .font(.caption.bold())
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 50)
            }
        }
        .padding(20)
        .background(
            LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(16)
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d"
        return formatter.string(from: Date())
    }
}

struct HabitRowView: View {
    let habit: Habit

    var body: some View {
        HStack(spacing: 14) {
            Text(habit.emoji)
                .font(.title2)
                .frame(width: 44, height: 44)
                .background(habit.color.opacity(0.15))
                .cornerRadius(12)
                .PLabel("emoji")

            VStack(alignment: .leading, spacing: 4) {
                Text(habit.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .PLabel("HabitName")
                Text("\(habit.completedToday)/\(habit.goal) today")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .PLabel("completed count")
            }

            Spacer()

            ZStack {
                Circle()
                    .stroke(habit.color.opacity(0.2), lineWidth: 4)
                Circle()
                    .trim(from: 0, to: habit.progress)
                    .stroke(habit.color, style: StrokeStyle(lineWidth: 4, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                if habit.isCompletedToday {
                    Image(systemName: "checkmark")
                        .font(.caption.bold())
                        .foregroundColor(habit.color)
                        .PLabel("checkMark")
                }
            }
            .frame(width: 36, height: 36)

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.secondary)
            
        }
        .padding(16)
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
    }
}
