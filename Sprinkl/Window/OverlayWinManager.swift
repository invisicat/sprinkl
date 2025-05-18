//
//  WindowManager.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/18/25.
//

import AppKit
import SwiftUI

class AlwaysKeyWindow : NSWindow {
    override var canBecomeMain: Bool { return true }
    override var canBecomeKey: Bool { return true }
}

// Helper class to act as the window delegate
class WindowDelegateHandler: NSObject, NSWindowDelegate {
    var onWindowWillClose: (() -> Void)?
    
    func windowWillClose(_ notification: Notification) {
        // This is called when the window is about to close.
        // We execute the closure provided by ContentView to update its state.
        onWindowWillClose?()
    }
}


class OverlayWinManager {
    static let shared = OverlayWinManager()
    private var customWindow: NSWindow?
    private var winDelegate: WindowDelegateHandler?
    let overlaySettings = OverlaySettings()

    func open() {
        if customWindow == nil {
            let window = AlwaysKeyWindow(
                contentRect: NSScreen.main?.frame ?? .zero,
                styleMask: [.borderless, .fullSizeContentView],
                backing: .buffered,
                defer: false,
            )
            
            let delegate = WindowDelegateHandler()
            delegate.onWindowWillClose = {
                print("Delegate: Overlay window will close.")
                DispatchQueue.main.async {
                    self.customWindow = nil
                    self.winDelegate = nil
                }
            }
            self.winDelegate = delegate

            window.isReleasedWhenClosed = false
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
            window.level = .popUpMenu
            window.isOpaque = true
            window.backgroundColor = .clear
            
            // Create and configure the delegate

            window.makeKeyAndOrderFront(nil)
            self.customWindow = window
            let view = OverlayView(window: customWindow).environmentObject(overlaySettings)
            let hosting = NSHostingController(rootView: view)
            self.customWindow?.contentView = hosting.view
            self.customWindow?.delegate = self.winDelegate
        } else {
            customWindow?.makeKeyAndOrderFront(nil)
        }
    }
}
