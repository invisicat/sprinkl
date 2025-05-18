//
//  SprinklApp.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/16/25.
//

import SwiftUI

@main
struct SprinklApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
        Window("Overlay", id: "overlay") {
            OverlayView()
        }.windowStyle(.hiddenTitleBar)
    }
}
