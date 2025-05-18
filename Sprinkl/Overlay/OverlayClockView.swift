//
//  OverlayClockView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI

enum FormatType: String {
    case hmsa = "h:mm:ss a"
    case hms = "h:mm:ss"
    case hm = "h:mm"
    case hma = "h:mm a"
}

func getCurrentTimeStr(format: FormatType = .hmsa) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = format.rawValue
    return formatter.string(from: Date())
}

struct OverlayClockView: View {
    @State private var text: String = getCurrentTimeStr()
    @State private var dateFormat: FormatType = .hmsa
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        Text(text)
            .font(.system(size: 84, weight: .medium, design: .rounded).monospacedDigit())
            .onReceive(timer) { _ in
                updateTimer()
            }
    }
    
    func updateTimer() {
        text = getCurrentTimeStr(format: dateFormat)
    }
}

#Preview {
    OverlayClockView()
}
