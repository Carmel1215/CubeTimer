//
//  SettingsView.swift
//  CubeTimer
//
//  Created by 김태환 on 1/6/26.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var timerVM = TimerViewModel()
    @ObservedObject var recordsVM: RecordsViewModel
    @State private var isReady = false
    
    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            Text(timeText)
                .font(.system(size: 66, weight: .bold, design: .monospaced))
                .foregroundStyle(foregroundColor)
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    if timerVM.state == .running {
                        let record = timerVM.stop()
                        recordsVM.addRecord(record: record)
                    }
                }
        )
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    if timerVM.state == .idle || timerVM.state == .stopped {
                        timerVM.ready()
                        isReady = true
                        let haptic = UIImpactFeedbackGenerator(style: .medium)
                        haptic.impactOccurred()
                    }
                }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onEnded { _ in
                    if isReady && timerVM.state == .ready {
                        isReady = false
                        timerVM.startFromReady()
                    }
                }
        )
    }
    
    // MARK: - UI 표시할 것들
    
    // 연산 프로퍼티
    var timeText: String {
        String(format: "%.3f", timerVM.elapsed)
    }
    
    var backgroundColor: Color {
        switch timerVM.state {
        case .idle: return .white
        case .ready: return .green
        case .running: return .black
        // case .stopped: return .red // ???: 쓸 지는 모르겠음. 애초에 stopped가 필요한가?
        default: return .white
        }
    }
    
    var foregroundColor: Color {
        switch timerVM.state {
        case .running: return .white
        default: return .black
        }
    }
}
