//
//  WeatherViewModel.swift
//  EndTerm3
//
import Foundation
import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherResponse?
    @Published var weatherError: String?
    @Published var moodTheme: MoodTheme?
    @Published var playlistLink: URL?
    @Published var moodHistory: [MoodEntry] = []
    
    private let weatherAPIKey = "81c0d7b52123edd95977d805d69ce188"
    
    func fetchWeather(lat: Double, lon: Double) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(weatherAPIKey)"
        
        guard let url = URL(string: urlString) else {
            self.weatherError = "Invalid URL"
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.weatherError = "Failed to fetch weather: \(error.localizedDescription)"
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.weatherError = "No data received"
                }
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    self.weatherData = decodedResponse
                    if let weatherCondition = decodedResponse.weather.first?.main {
                        self.moodTheme = moodFor(weather: weatherCondition)
                        self.playlistLink = WeatherMoodMaker.playlistLink(for: self.moodTheme?.mood ?? "")
                        
                        let newEntry = MoodEntry(mood: self.moodTheme?.mood ?? "Unknown", quote: self.moodTheme?.quote ?? "", date: Date(), weather: "")
                        self.moodHistory.insert(newEntry, at: 0)
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.weatherError = "Failed to decode response: \(error.localizedDescription)"
                }
            }
        }
        
        task.resume()
    }
}
