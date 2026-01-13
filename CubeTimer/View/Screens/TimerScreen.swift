//
//  TimerView.swift
//  CubeTimer
//
//  Created by 김태환 on 1/13/26.
//

import SwiftUI

struct TimerScreen: View {
    
    enum TimerState {
        case ready
        case running
        case stopped
    }
    
    @State private var timerState: TimerState = .stopped

    @GestureState private var isTouching = false

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            Text("00:00:00")
                .font(.system(size: 64, design: .monospaced))
                .bold()
                .foregroundStyle(timerState == .running ? .white : .black)
        }
        .contentShape(Rectangle())
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    if timerState == .running {
                        timerState = .stopped
                    }
                }
        )
        .gesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    if timerState == .stopped {
                        timerState = .ready
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.prepare()
                        generator.impactOccurred()
                    }
                }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .updating($isTouching) { _, state, _ in
                    state = true // 터치 중
                }
                .onEnded { _ in
                    if timerState == .ready {
                        timerState = .running
                    }
                }
        )
    }

    var backgroundColor: Color {
        switch timerState {
        case .stopped: return .white
        case .ready: return .green
        case .running: return .black
        }
    }
}

#Preview {
    TimerScreen()
}
