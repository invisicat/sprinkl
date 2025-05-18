//
//  EditTimer.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI

struct EditTimer: View {
    @Binding var timer: OverTimer
    @FocusState.Binding var focusedUnit: TimerUnits?
    @Binding var isEditing: Bool
    
    @State var hours: String
    @State var minutes: String
    @State var seconds: String
    
    init(timer: Binding<OverTimer>, focusedUnit: FocusState<TimerUnits?>.Binding, isEditing: Binding<Bool>) {
        self._timer = timer
        self._focusedUnit = focusedUnit
        self._isEditing = isEditing
        

        let t = timer.wrappedValue;
        
        self._hours   = State(initialValue: t.getStrByUnit(.hours))
        self._minutes = State(initialValue: t.getStrByUnit(.minutes))
        self._seconds = State(initialValue: t.getStrByUnit(.seconds))
    }
    
    var body: some View {
        HStack {
            TextField("", text: $hours)
                .font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
                .foregroundStyle(.white)
                .frame(width: 85)
                .textFieldStyle(.plain)
                .focused($focusedUnit, equals: .hours)
                .onChange(of: hours, { oldValue, newValue in
                    var filtered = newValue.filter { "0123456789".contains($0) }
                    
                     if filtered.count > 2 {
                        filtered = String(filtered.prefix(2))
                    }
                    if hours != filtered {
                        hours = filtered
                    }
                })
                .multilineTextAlignment(.center)
                .onSubmit {
                    handleInputSubmit(unit: .hours, num: Int(hours) ?? 0)
                }
            Text(":").font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
            TextField("", text: $minutes)
                .font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
                .foregroundStyle(.white)
                .frame(width: 85)
                .focused($focusedUnit, equals: .minutes)
                .textFieldStyle(.plain)
                .multilineTextAlignment(.center)
                .onChange(of: minutes, { oldValue, newValue in
                    var filtered = newValue.filter { "0123456789".contains($0) }
                    
                     if filtered.count > 2 {
                        filtered = String(filtered.prefix(2))
                    }
                    if minutes != filtered {
                        minutes = filtered
                    }
                })
                .onSubmit {
                    handleInputSubmit(unit: .minutes, num: Int(minutes) ?? 0)
                }
            Text(":").font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
            TextField("", text: $seconds)
                .font(.system(size: 64, weight: .medium, design: .rounded).monospacedDigit())
                .foregroundStyle(.white)
                .frame(width: 85)
                .textFieldStyle(.plain)
                .focused($focusedUnit, equals: .seconds)
                .multilineTextAlignment(.center)
                .onChange(of: seconds, { oldValue, newValue in
                    var filtered = newValue.filter { "0123456789".contains($0) }
                    
                     if filtered.count > 2 {
                        filtered = String(filtered.prefix(2))
                    }
                    if seconds != filtered {
                        seconds = filtered
                    }
                })
                .onSubmit {
                    handleInputSubmit(unit: .seconds, num: Int(seconds) ?? 0)
                }
            
        }
    }
    
    func handleInputSubmit(unit: TimerUnits, num: Int) {
        timer.setByUnit(unit, num)
        isEditing = false
    }
}
