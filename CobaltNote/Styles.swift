// MARK: Styles.swift
import SwiftUI

// Define a new color palette for the Frutiger Aero aesthetic
extension Color {
    static let frutigerBlue = Color(red: 0.0, green: 0.5, blue: 1.0)
    static let lushGreen = Color(red: 0.0, green: 0.0, blue: 0.3)
}

// A custom button style for that classic glossy, 3D look
struct FrutigerAeroButtonStyle: ButtonStyle {
    var color: Color = .frutigerBlue
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline.bold())
            .foregroundColor(.white)
            .padding(12)
            .padding(.horizontal, 10)
            .background(
                ZStack {
                    // Main button color with a subtle gradient
                    LinearGradient(
                        colors: [color.opacity(0.8), color],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    
                    // The classic diagonal "shine" overlay
                    LinearGradient(
                        colors: [.white.opacity(0.6), .white.opacity(0.1), .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            )
            .clipShape(Capsule())
            .overlay(
                // A subtle border to give it a plastic edge
                Capsule()
                    .stroke(.white.opacity(0.5), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.3), radius: 5, y: 3)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}
