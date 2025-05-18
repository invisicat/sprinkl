//
//  OverlayTimerView.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//

import SwiftUI


struct OverlayTimerView: View {
    @State private var timerState = TimerState.Stopped
    @State private var timer: OverTimer = OverTimer()
    
    @FocusState private var focusedTimeUnit: TimerUnits?
    
    private let timerPublisher = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var isEditing = false
    var body: some View {
        if isEditing {
            EditTimer(timer: $timer, focusedUnit: $focusedTimeUnit, isEditing: $isEditing)
        } else {
            TimerDisplay(timer: $timer, focusedUnit: $focusedTimeUnit, isEditing: $isEditing)
        }
        HStack {
            Button(OverTimer.getActionString(from: timerState)) {
                switch timerState {
                case .Paused:
                    timerState = .Running
                    isEditing = false
                case .Running:
                    timerState = .Paused
                case .Stopped:
                    timerState = .Running
                }
            }
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.black)
            .padding(8)
            .background(Color.white)
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
            
            Button("Short Break") {
                timerState = .Stopped
                timer.setTotal(900)
            }
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.black)
            .padding(8)
            .background(Color.white)
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()

            Button("Long Break") {
                timerState = .Stopped
                timer.setTotal(1500)
            }
            .font(.system(size: 18, weight: .medium))
            .foregroundColor(.black)
            .padding(8)
            .background(Color.white)
            .buttonStyle(.plain)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()
        }.onReceive(timerPublisher) { _ in
            if(timerState == .Running) {
                timer.decrement()
            }
            
            if(timer.isDone()) {
                timerState = .Stopped
            }
            
        }.onChange(of: isEditing) { oldValue, newValue in
            if(newValue) {
                timerState = .Paused
            } else {
                timerState = .Running
            }
        }
    }
}



#Preview {
    ZStack {
        Color.black.opacity(0.85).ignoresSafeArea()
        VStack {
            OverlayTimerView()
        }
    }
}
