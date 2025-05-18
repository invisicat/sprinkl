//
//  ContentView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/16/25.
//

import SwiftUI
import AppKit // Required for NSWindow, NSHostingView, NSWindowDelegate, etc.


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
                    OverlayWinManager.shared.open()
                }
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .buttonStyle(.plain)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
        .opacity(mainContentOpacity)
        .onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                mainContentOpacity = 1
            }
        }
    }
    
}

#Preview {
    ContentView()
}
