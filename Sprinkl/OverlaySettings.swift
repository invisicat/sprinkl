//
//  OverlaySettings.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/18/25.
//

import SwiftUI

class OverlaySettings : ObservableObject {
    @Published var opacity: Double = 0.75
    @Published var countVariant: CountVariant = .Clock
    
}
