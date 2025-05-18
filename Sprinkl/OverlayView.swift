//
//  OverlayView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/16/25.
//

import SwiftUI
import AppKit // Required for NSApplication, NSWindow

enum CountVariant: String, CaseIterable {
    case Clock
    case Timer
    
    func iconName() -> String {
        if(self == .Clock) {
            return "clock"
        } else {
            return "light.beacon.max"
        }
    }
}

@ViewBuilder
func CountView(variant: CountVariant) -> some View {
    Group {
        switch(variant) {
        case .Clock:
            OverlayClockView()
                .transition(.asymmetric(
                    insertion: .move(edge: .leading).combined(with: .opacity),
                    removal: .move(edge: .trailing).combined(with: .opacity)
                ))
            
        case .Timer:
            OverlayTimerView()
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity), // Different insertion edge
                    removal: .move(edge: .leading).combined(with: .opacity)   // Different removal edge
                ))
        }
    }
    .animation(.easeInOut(duration: 0.35), value: variant)

}

struct OverlayView: View {
    // Store a weak reference to the window that hosts this view.
    // This will be passed in during initialization.
    weak var window: NSWindow?
    
    // State for content animation (e.g., fade in)
    @State private var contentOpacity: Double = 0
    @EnvironmentObject var settings: OverlaySettings
    
    @FocusState private var isFocus: Bool

    var body: some View {
        ZStack {
            // This ZStack is the content of the transparent window.
            // This color provides the actual semi-transparent background effect.
            Color.black
                .opacity(settings.opacity)
                .ignoresSafeArea()
                .onTapGesture {
                    self.window?.close()
                }

            VStack {
                Text("Lock tf in.")
                    .font(.system(size: 72, weight: .bold, design: .rounded)) // Larger, clear font
                    .foregroundColor(.white.opacity(0.9)) // White text, slightly transparent for softer look
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2) // Subtle shadow for readability
                CountView(variant: settings.countVariant)
            }
            .opacity(contentOpacity)
            VStack {
                Spacer()
                HStack {
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) { // You can customize the animation
                                print("ok")
                            }
                        }, label: {
                            ZStack {
                                Image(systemName: "music.note")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                    .padding(2)
                            }
                        })
                        .buttonStyle(DarkButtonStyle())
                        .padding()
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) { // You can customize the animation
                                print("ok")
                            }
                        }, label: {
                            ZStack {
                                Image(systemName: "gear")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 36, height: 36)
                                    .padding(2)
                            }
                        })
                        .buttonStyle(DarkButtonStyle())
                        .padding(.vertical)
                    }
                    Spacer()
                    VStack {
                        OverlaySwitchView()
                            .frame(width: 120, height: 30)
                            .padding(.bottom, 20)
                        OverlayOpacityView()
                            .opacity(contentOpacity)
                    }
                    .padding(20) // Padding from the window edges
                }
            }

            Button("") {
                print("Closing by esc.")
                self.window?.close()
            }
            .focusable()
            .focused($isFocus)
            .keyboardShortcut(.escape, modifiers: [])
            .frame(width: 0, height: 0)
            .opacity(0)
            .allowsHitTesting(false)
        }
        .onAppear {
            withAnimation(.easeIn(duration: 0.8).delay(0.2)) {
                contentOpacity = 1
                isFocus = true
            }
        }
    }
}

#Preview {
    // Previewing a view that expects a window can be tricky.
    // For the preview, we can pass nil or a dummy window if necessary,
    // but the close functionality won't work in the preview without a real window.
    ZStack {
        Color.purple.ignoresSafeArea() // Simulate a desktop or other content behind
        OverlayView(window: nil)
            .environmentObject(OverlaySettings())
    }
}

