//
//  TimerModel.swift
//  CubeTimer
//
//  Created by 김태환 on 1/13/26.
//

import Foundation
import Combine
import QuartzCore

enum TimerState {
    case ready
    case running
    case stopped
}

final class TimerStore: ObservableObject {
    
    @Published var timerState: TimerState = .stopped
    @Published var elapsed: Double = 0.0
    
    private var startTime: Double = 0
    private var displayTimer: Timer?
    
    func ready() {
        if timerState == .stopped {
            timerState = .ready
            elapsed = 0.0
            startTime = 0.0
        }
    }
    
    func start() {
        if timerState == .ready {
            timerState = .running
            startTime = CACurrentMediaTime()
            
            displayTimer?.invalidate()
            displayTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.elapsed = CACurrentMediaTime() - self.startTime
            }
        }
    }
    
    func stop() {
        if timerState == .running {
            timerState = .stopped
            displayTimer?.invalidate()
            elapsed = CACurrentMediaTime() - startTime
            
        }
    }
    
    func formatText(time: Double) -> String {
        return String(format: "%.3f", time)
    }
    // TODO: SwiftData 사용법 알아보기
}
