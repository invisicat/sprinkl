//
//  TimerDisplay.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI

struct TimerDisplay: View {
    @Binding var timer: OverTimer
    @FocusState.Binding var focusedUnit: TimerUnits?
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            Text(timer.getStrByUnit(.hours))
                .font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
                .onTapGesture {
                    focusedUnit = .hours
                    isEditing = true
                }
            Text(":")
                .font(.system(size: 64, weight: .medium, design: .rounded))
            Text(timer.getStrByUnit(.minutes))
                .font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
                .onTapGesture {
                    focusedUnit = .minutes
                    isEditing = true
                }
            Text(":")
                .font(.system(size: 64, weight: .medium, design: .rounded))
            Text(timer.getStrByUnit(.seconds))
                .font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
                .onTapGesture {
                    focusedUnit = .seconds
                    isEditing = true
                }
        }
    }
}
