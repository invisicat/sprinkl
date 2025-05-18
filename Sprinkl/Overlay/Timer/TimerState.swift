//
//  TimerState.swift
//  Sprinkl
//
//  Created by Andy Lyek on 5/17/25.
//


enum TimerState {
    case Paused
    case Running
    case Stopped
}

enum TimerUnits {
    case seconds
    case minutes
    case hours
}

struct OverTimer {
    private var totalSeconds: Int = 600;
    
    mutating func increment() {
        totalSeconds += 1
    }
    
    mutating func decrement() {
        if(totalSeconds > 0) {
            totalSeconds -= 1
        }
    }
    
    func getTotalByUnit(_ unit: TimerUnits) -> Int {
        switch unit {
        case .seconds:
            return totalSeconds
        case .minutes:
            return totalSeconds / 60
        case .hours:
            return totalSeconds / 3600
        }
    }
    
    func getByUnit(_ unit: TimerUnits) -> Int {
        switch unit {
        case .seconds:
            totalSeconds % 60
        case .minutes:
            (totalSeconds % 3600) / 60
        case .hours:
            totalSeconds / 3600
        }
    }
    
    func getStrByUnit(_ unit: TimerUnits) -> String {
        return String(format: "%02d", getByUnit(unit))
    }
    
    mutating func setByUnit(_ unit: TimerUnits, _ value: Int) {
        switch unit {
        case .seconds:
            let oldMinutes = totalSeconds / 60
            let oldHours = totalSeconds / 3600
            totalSeconds = value + (oldMinutes * 60) + (oldHours * 3600)
        case .minutes:
            let oldHours = totalSeconds / 3600
            let oldSeconds = totalSeconds % 60
            totalSeconds = value * 60 + oldSeconds + (oldHours * 3600)
        case .hours:
            let oldMinutes = (totalSeconds % 3600) / 60
            let oldSeconds = totalSeconds % 60
            totalSeconds = value * 3600 + oldMinutes * 60 + oldSeconds
        }
    }
    
    mutating func setTotal(_ value: Int) {
        totalSeconds = value
    }
    
    func time() -> String {
        return formatTime(totalSeconds: totalSeconds)
    }
    
    func isDone() -> Bool {
        return totalSeconds <= 0
    }
    
    func formatTime(totalSeconds: Int) -> String {
        let hours = getByUnit(.hours)
        let minutes = getByUnit(.minutes)
        let seconds = getByUnit(.seconds)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    static func getActionString(from: TimerState) -> String {
        switch from {
            case .Paused:
            return "Resume"
        case .Running:
            return "Pause"
        case .Stopped:
            return "Start"
        }
    }
}
