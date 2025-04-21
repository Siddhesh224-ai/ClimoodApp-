//
//  WeatherAnimationView.swift
//  EndTerm3
//
import SwiftUI

struct WeatherAnimationView: View {
    var mood: String

    var body: some View {
        ZStack {
            switch mood.lowercased() {
            case "cozy 🌧":
                RainView()
            case "peaceful ❄️":
                SnowView()
            case "energetic ☀️":
                SunView()
            default:
                EmptyView()
            }
        }
        .frame(height: 200)
        .transition(.opacity)
    }
}

struct RainView: View {
    var body: some View {
        GeometryReader { geo in
            ForEach(0..<40, id: \.self) { i in
                RainDrop(x: .random(in: 0...geo.size.width),
                         delay: Double.random(in: 0...2),
                         height: geo.size.height)
            }
        }
    }
}

struct RainDrop: View {
    let x: CGFloat
    let delay: Double
    let height: CGFloat

    @State private var y: CGFloat = -20

    var body: some View {
        Circle()
            .frame(width: 3, height: 10)
            .foregroundColor(.blue.opacity(0.5))
            .position(x: x, y: y)
            .onAppear {
                withAnimation(Animation.linear(duration: 1.5).repeatForever().delay(delay)) {
                    y = height + 20
                }
            }
    }
}

struct SnowView: View {
    var body: some View {
        GeometryReader { geo in
            ForEach(0..<30, id: \.self) { _ in
                Circle()
                    .frame(width: 6)
                    .foregroundColor(.white.opacity(0.7))
                    .position(
                        x: .random(in: 0...geo.size.width),
                        y: .random(in: 0...geo.size.height)
                    )
                    .blur(radius: 1)
            }
        }
    }
}

struct SunView: View {
    @State private var rotate = false

    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(gradient: Gradient(colors: [.yellow, .orange]),
                                   center: .center,
                                   startRadius: 10,
                                   endRadius: 100)
                )
                .frame(width: 120, height: 120)
                .blur(radius: 5)

            ForEach(0..<12) { i in
                Capsule()
                    .fill(Color.yellow)
                    .frame(width: 4, height: 20)
                    .offset(y: -70)
                    .rotationEffect(.degrees(Double(i) / 12 * 360))
            }
        }
        .rotationEffect(.degrees(rotate ? 360 : 0))
        .animation(Animation.linear(duration: 20).repeatForever(autoreverses: false), value: rotate)
        .onAppear {
            rotate = true
        }
    }
}
