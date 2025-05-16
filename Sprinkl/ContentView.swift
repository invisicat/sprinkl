//
//  ContentView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/16/25.
//

import SwiftUI
import AppKit // Required for NSWindow, NSHostingView, NSWindowDelegate, etc.

// Helper class to act as the window delegate
class WindowDelegateHandler: NSObject, NSWindowDelegate {
    var onWindowWillClose: (() -> Void)?

    func windowWillClose(_ notification: Notification) {
        // This is called when the window is about to close.
        // We execute the closure provided by ContentView to update its state.
        onWindowWillClose?()
    }
}

struct ContentView: View {
    @State private var mainContentOpacity: Double = 0
    // Keep a reference to the overlay window to manage it
    @State var overlayWindow: NSWindow?
    @State var windowDelegateHandler: WindowDelegateHandler?

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack {
                Text("Sprinkl!")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.white)

                Button("Open Full-Screen Overlay") {
                    print("Opening full-screen overlay window...")
                    openOverlayWindow()
                }
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .buttonStyle(.plain)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            Button("") {
                print("Closing window from content view.")
                overlayWindow?.close()
            }
            .keyboardShortcut(.escape, modifiers: [])
            .frame(width: 0, height: 0) // Make it take no space
            .opacity(0) // Make it invisible
            .allowsHitTesting(false) // Ensure it doesn't interfere with other gestures
        }
        .opacity(mainContentOpacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                mainContentOpacity = 1
            }
        }
    }

    // Function to open the OverlayView in a new, full-screen, semi-transparent window
    func openOverlayWindow() {
        // Prevent opening multiple overlay windows if one is already open and visible
            if let existingWindow = overlayWindow, existingWindow.isVisible {
                print("Attemping to open overlay window.")
                existingWindow.makeKeyAndOrderFront(nil) // Bring to front if already open
                return
            } else {
                print("?FODKSDJFGSKLDFJG:L")
            }
        
        // Define the window to cover the entire main screen
        let newWindow = NSWindow(
            contentRect: NSScreen.main?.frame ?? .zero, // Full screen
            styleMask: [.borderless, .fullSizeContentView], // Borderless window
            backing: .buffered,
            defer: false
        )
        
        // Create and configure the delegate
        let delegate = WindowDelegateHandler()
        delegate.onWindowWillClose = {
            print("Delegate: Overlay window will close.")
            // Ensure UI updates and state changes are on the main thread.
            DispatchQueue.main.async {
                // Check if the window being closed is the one we are tracking
                // (self.overlayWindow might have changed if new windows are created rapidly,
                //  though `newWindow` capture should be specific to this instance)
                if self.overlayWindow === newWindow {
                    self.overlayWindow = nil
                    self.windowDelegateHandler = nil // Release the delegate handler
                    print("Delegate: overlayWindow set to nil")
                } else {
                    print("Delegate: Warning - windowWillClose called for an unexpected window instance or overlayWindow was already nilled.")
                }
            }
        }
        
        self.windowDelegateHandler = delegate // Keep the delegate alive as long as the window might exist
        newWindow.delegate = self.windowDelegateHandler
        self.overlayWindow = newWindow
                
        // Set collection behavior for better full-screen and spaces integration
        newWindow.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .transient]


        // Create the SwiftUI view for the overlay, passing the window instance
        let overlayContentView = OverlayView(window: newWindow)

        // Create an NSHostingView to host the SwiftUI view
        let hostingView = NSHostingView(rootView: overlayContentView)

        newWindow.isReleasedWhenClosed = false // Ensures window is deallocated when closed
        newWindow.level = .popUpMenu
        newWindow.isOpaque = false // Allows the window to be transparent
        newWindow.backgroundColor = .clear
        newWindow.contentView = hostingView
        newWindow.makeKeyAndOrderFront(nil)
    }
}

#Preview {
    ContentView()
}
