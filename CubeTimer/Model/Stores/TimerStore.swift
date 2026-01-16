//
//  TimerModel.swift
//  CubeTimer
//
//  Created by 김태환 on 1/13/26.
//

import Foundation
import Combine

enum TimerState {
    case ready
    case running
    case stopped
}

final class TimerStore: ObservableObject {
    
    @Published var timerState: TimerState = .stopped
    // TODO: 타이머 시간 측정 로직
    // TODO: SwiftData 사용법 알아보기
}
