//
//  OverlayOpacityView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI

struct OverlayOpacityView: View {
    @EnvironmentObject var settings: OverlaySettings
    
    var body: some View {
        VStack {
            HStack {
                Slider(
                    value: $settings.opacity,
                    in: 0.25...1,
                )
                .tint(.white)
                Text("\(settings.opacity, format: .percent.precision(.fractionLength(0)))")
            }.frame(width: 200)
            HStack {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) { // You can customize the animation
                        settings.opacity = (settings.opacity - 0.25).clamped(range: 0.25...1)
                    }
                }, label: {
                    Image(systemName: "light.min")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(2)
                })
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(DarkButtonStyle())

                Spacer()
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) { // You can customize the animation
                        settings.opacity = 1
                    }
                }, label: {
                    Image(systemName: "light.max")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(2)
                })
                .buttonBorderShape(.roundedRectangle)
                .buttonStyle(DarkButtonStyle())
            }.frame(width: 200)
        }
    }
}

#Preview {
    // Create a wrapper view for the preview to hold the @State
    struct OverlayOpacityPreviewWrapper: View {
        // Use @State to provide a mutable binding for the preview
        @State private var previewOpacity: Double = 0.75 // Initial value for the preview

        var body: some View {
            // Provide a background for the preview context so the OverlayOpacityView is visible
            ZStack {
                Color.blue.opacity(0.5).ignoresSafeArea() // Example background like a desktop
                
                OverlayOpacityView()
                // You can add more styling to the preview wrapper if needed
            }
            .frame(width: 300, height: 200) // Give the preview a reasonable size
        }

        }
    return OverlayOpacityPreviewWrapper()
}

