//
//  Model.swift
//  EndTerm3
//
import SwiftUI

struct WeatherResponse: Decodable {
    let weather: [Weather]
    let main: Main

    struct Weather: Decodable {
        let main: String
        let description: String
    }

    struct Main: Decodable {
        let temp: Double
    }
}

struct MoodEntry: Identifiable, Codable {
    let id = UUID()
    let mood: String
    let quote: String
    let date: Date
    let weather: String
}


struct MoodTheme {
    let mood: String
    let quote: String
    let color: Color
}

func moodFor(weather: String) -> MoodTheme {
    switch weather.lowercased() {
    case "clear":
        return MoodTheme(mood: "Energetic ☀️", quote: "Shine bright today!", color: .yellow)
    case "clouds":
        return MoodTheme(mood: "Chill ☁️", quote: "Even the clouds can't hide your light.", color: .gray)
    case "rain":
        return MoodTheme(mood: "Cozy 🌧", quote: "Rain brings growth.", color: .blue)
    case "snow":
        return MoodTheme(mood: "Peaceful ❄️", quote: "Let it snow, let it go.", color: .white)
    default:
        return MoodTheme(mood: "Open 🌈", quote: "Anything is possible today.", color: .purple)
    }
}

func playlistLink(for mood: String) -> URL? {
    switch mood {
    case "Energetic ☀️":
        return URL(string: "https://open.spotify.com/playlist/37i9dQZF1DXdPec7aLTmlC")
    case "Chill 🌧":
        return URL(string: "https://open.spotify.com/playlist/37i9dQZF1DX4E3UdUs7fUx")
    case "Peaceful ❄️":
        return URL(string: "https://open.spotify.com/playlist/37i9dQZF1DWUvZBXGjNCU4")
    default:
        return nil
    }
}

