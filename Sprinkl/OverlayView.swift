//
//  OverlayView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/16/25.
//

import SwiftUI
import AppKit // Required for NSApplication, NSWindow

struct OverlayView: View {
    // Store a weak reference to the window that hosts this view.
    // This will be passed in during initialization.
    weak var window: NSWindow?
    
    // State for content animation (e.g., fade in)
    @State private var contentOpacity: Double = 0
    @State private var bgOpacity: Double = 0.75;
    @FocusState private var isFocus: Bool

    var body: some View {
        ZStack {
            // This ZStack is the content of the transparent window.
            // This color provides the actual semi-transparent background effect.
            Color.black.opacity(bgOpacity) // Adjust opacity as desired (e.g., 75% black)
                .ignoresSafeArea() // Ensure it covers the entire screen area
                .onTapGesture {
                    // Optional: Close the overlay when its background is clicked.
                    print("Overlay background tapped, closing window.")
                    // Use the passed-in window reference to close
                    self.window?.close()
                }

            VStack {
                Text("Lock tf in.")
                    .font(.system(size: 72, weight: .bold, design: .rounded)) // Larger, clear font
                    .foregroundColor(.white.opacity(0.9)) // White text, slightly transparent for softer look
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2) // Subtle shadow for readability
                Text("00:00:00")
                    .font(.system(size: 64, weight: .medium, design: .rounded))
                HStack {
                    Button("Pause") {
                        print("Pause Timer")
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(Color.white)
                    .buttonStyle(.plain)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                    
                    Button("Short Break") {
                        print("Pause Timer")
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(Color.white)
                    .buttonStyle(.plain)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
            
                    Button("Long Break") {
                        print("Pause Timer")
                    }
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .padding(8)
                    .background(Color.white)
                    .buttonStyle(.plain)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                }
                VStack {
                    HStack {
                        Slider(
                            value: $bgOpacity,
                            in: 0.25...1,
                        )
                        Text("\(bgOpacity, format: .percent.precision(.fractionLength(0)))")
                    }.frame(width: 200)
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) { // You can customize the animation
                                bgOpacity = (bgOpacity - 0.25).clamped(range: 0.25...1)
                            }
                        }, label: {
                           Image(systemName: "moonphase.last.quarter.inverse")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 18, height: 25)
                               .padding(2)
                       })
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: .infinity))
                        .tint(.white)
                        .foregroundStyle(.white)
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) { // You can customize the animation
                                bgOpacity = 1
                            }
                        }, label: {
                           Image(systemName: "moonphase.last.quarter.inverse")
                               .resizable()
                               .scaledToFit()
                               .frame(width: 18, height: 25)
                               .padding(2)
                       })
                        .buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: .infinity))
                        .tint(.white)
                        .foregroundStyle(.white)
                    }.frame(width: 200)
                }
            }
            .opacity(contentOpacity)

            Button("") {
                print("Closing Overlay from overlay View.")
                self.window?.close()
            }
            .focusable()
            .focused($isFocus)
            .keyboardShortcut(.escape, modifiers: [])
            .frame(width: 0, height: 0) // Make it take no space
            .opacity(0) // Make it invisible
            .allowsHitTesting(false) // Ensure it doesn't interfere with other gestures
        }
        // The window itself is made transparent by ContentView.
        // This view's ZStack provides the actual visible semi-transparent background.
        .onAppear {
            // Animate the content opacity when the view appears
            withAnimation(.easeIn(duration: 0.8).delay(0.2)) { // Slight delay for a smoother effect
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
        // Pass nil for the window in the preview context as it's not being hosted by a real window here.
        OverlayView(window: nil)
    }
}
