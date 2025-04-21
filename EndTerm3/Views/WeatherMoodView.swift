//
//  WeatherMoodViewer.swift
//  EndTerm3
//
//  Created by Siddhesh Mutha on 21/04/25.
//

import SwiftUI

struct WeatherMoodView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = WeatherViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                // background will be set according to the mood
                if let mood = viewModel.moodTheme {
                    LinearGradient(gradient: Gradient(colors: [mood.color.opacity(0.4), mood.color.opacity(0.9)]),
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                } else {
                    Color.blue.opacity(0.3).ignoresSafeArea()
                }

                VStack(spacing: 20) {
                    Text("WeatherMood 🌤️")
                        .font(.largeTitle.bold())
                        .foregroundColor(.white)
                        .shadow(radius: 5)

                    Spacer()

                    // while the data is coming , have a Loader view (could be better with animation )
                    // note - improve ProgressView
                    if let location = locationManager.location {
                        if viewModel.weatherData == nil {
                            ProgressView("Fetching weather...")
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .onAppear {
                                    viewModel.fetchWeather(lat: location.latitude, lon: location.longitude)
                                }
                        }
                    } else if let error = locationManager.locationError {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                    } else {
                        ProgressView("Getting location...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .onAppear {
                                locationManager.startUpdatingLocation()
                            }
                    }

                    // Show weather and Mood
                    if let weather = viewModel.weatherData,
                       let mood = viewModel.moodTheme {

                        VStack(spacing: 12) {
                            Text(weather.weather.first?.description.capitalized ?? "Weather Info")
                                .font(.title2)
                                .foregroundColor(.white)

                            Text(String(format: "%.1f°C", weather.main.temp - 273.15))
                                .font(.system(size: 48, weight: .bold))
                                .foregroundColor(.white)

                            Text(mood.mood)
                                .font(.title)
                                .bold()
                                .padding(.vertical, 4)
                                .padding(.horizontal, 16)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                                .foregroundColor(.black)

                            Text("“\(mood.quote)”")
                                .italic()
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal)

                            if let playlist = playlistLink(for: mood.mood) {
                                Link(destination: playlist) {
                                    Label("Vibe with Playlist", systemImage: "music.note")
                                        .padding()
                                        .background(.thinMaterial)
                                        .clipShape(Capsule())
                                        .foregroundColor(.black)
                                }
                            }
                        }
                        .padding(.bottom, 30)
                    }

                    // Animation
                    if let mood = viewModel.moodTheme?.mood {
                        WeatherAnimationView(mood: mood)
                            .frame(height: 200)
                    }

                    Spacer()

                    // Mood History Navigation
                    NavigationLink(destination: MoodHistoryView(history: viewModel.moodHistory)) {
                        Text("📖 Mood History")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                    }

                    Spacer()
                }
                .padding(.top)
            }
        }
    }
}

struct WeatherMoodView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherMoodView()
    }
}
#Preview {
    WeatherMoodView()
}
