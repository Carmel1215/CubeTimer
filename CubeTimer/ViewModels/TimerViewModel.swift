//
//  CubeTimerViewModel.swift
//  CubeTimer
//
//  Created by 김태환 on 1/3/26.
//

import Foundation
import Combine
import QuartzCore

enum TimerState {
    case idle
    case ready
    case running
    case stopped
}

final class TimerViewModel: ObservableObject {
    
    @Published var state: TimerState = .idle
    @Published var elapsed: Double = 0.0
    
    private var startTime: Double = 0
    private var displayTimer: Timer?
    
    func ready() {
        state = .ready
    }
    
    func startFromReady() {
        start()
    }
    
    func start() {
        startTime = CACurrentMediaTime()
        state = .running
        
        displayTimer?.invalidate()
        displayTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.elapsed = CACurrentMediaTime() - self.startTime
        }
    }
    
    func stop() {
        displayTimer?.invalidate()
        elapsed = CACurrentMediaTime() - startTime
        state = .stopped
    }
    
    func reset() {
        elapsed = 0
        state = .idle
    }
}
