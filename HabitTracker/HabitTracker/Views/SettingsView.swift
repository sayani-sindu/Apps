import SwiftUI

struct SettingsView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = true
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                                .frame(width: 60, height: 60)
                            Text("🧑‍💻")
                                .font(.title)
                        }
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Habit Tracker")
                                .font(.headline)
                                .PLabel("Habit Tracker")
                            Text("Build better habits daily")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .PLabel("text")
                        }
                    }
                    .padding(.vertical, 8)
                }

                Section("Preferences") {
                    Toggle("Daily Reminders", isOn: $notificationsEnabled)
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                }

                Section("Data") {
                    Button(role: .destructive) {
                        // placeholder
                    } label: {
                        Label("Reset All Habits", systemImage: "trash")
                            .PLabel("Reset")
                    }
                }

                Section("About") {
                    HStack {
                        Text("Version")
                            .PLabel("version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                            .PLabel("Version number")
                    }
                    HStack {
                        Text("Built with")
                        Spacer()
                        Text("SwiftUI")
                            .foregroundColor(.secondary)
                            .PLabel("Lang")
                    }
                    Button("Show Onboarding Again") {
                        hasCompletedOnboarding = false
                    }
                    .PLabel("Onboarding")
                }
            }
            .navigationTitle("Settings")
        }
    }
}
