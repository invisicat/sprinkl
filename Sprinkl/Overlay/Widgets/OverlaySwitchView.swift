//
//  OverlaySwitchView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI

struct OverlaySwitchView: View {
    @EnvironmentObject var settings: OverlaySettings
    
    var body: some View {
        VStack {
            Picker("", selection: $settings.countVariant) {
                Image(systemName: "clock")
                    .resizable()
                    .scaledToFit()
                    .tag(CountVariant.Clock)
                Image(systemName: "light.beacon.max")
                    .resizable()
                    .scaledToFit()
                    .tag(CountVariant.Timer)
                // Text("Stopwatch").tag(CountVariant.Stopwatch) // If you add more
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
        .padding(.top) // Add some padding at the top of the VStack
    }
}

#Preview {
    @Previewable @State var selectVariant: CountVariant = .Clock
    
    OverlaySwitchView().environmentObject(OverlaySettings()).padding(20)
}
