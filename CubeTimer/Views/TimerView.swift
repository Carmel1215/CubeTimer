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
            Color.gray
                .ignoresSafeArea() // FIXME: 현재 상태에 따라 색깔 변경
            
            Text(timeText)
                .font(.system(size: 66, weight: .bold, design: .monospaced))
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
    
    
}
