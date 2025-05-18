//
//  OverlaySettingsView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI


struct OverlaySettingsButton: View {
    
    @State private var isSettings: Bool = false
    var body: some View {
        HStack {
            Button(action: {
                isSettings.toggle()
            }, label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                    .padding(2)
            })
            .buttonStyle(DarkButtonStyle())
            .popover(isPresented: $isSettings,
                     attachmentAnchor: .point(.top), // Example anchor, adjust as needed
                     ) { // Places arrow at the bottom of the button
                OverlaySettingsView().padding(30)
            }

        }
    }
}

struct OverlaySettingsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding(20)
    }
}

#Preview {
    VStack {
        OverlaySettingsView()
        OverlaySettingsButton().padding(10)
    }
}
