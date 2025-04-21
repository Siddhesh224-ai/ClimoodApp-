//
//  MoodHistoryView.swift
//  EndTerm3
//
import SwiftUI

struct MoodHistoryView: View {
    let history: [MoodEntry]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                ForEach(history) { entry in
                    let moodTheme = moodFor(weather: entry.weather)

                    MoodHistoryRow(entry: entry, moodTheme: moodTheme)
                        .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .navigationTitle("📖 Mood History")
        .background(
            LinearGradient(
                colors: [.white, .gray.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

struct MoodHistoryRow: View {
    let entry: MoodEntry
    let moodTheme: MoodTheme

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(moodTheme.color.opacity(0.6))
                .frame(width: 20, height: 20)

            VStack(alignment: .leading, spacing: 6) {
                Text(entry.mood)
                    .font(.headline)
                    .foregroundColor(.primary)

                Text("“\(entry.quote)”")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(entry.date, style: .date)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
