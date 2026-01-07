//
//  SettingsView.swift
//  CubeTimer
//
//  Created by 김태환 on 1/6/26.
//

import SwiftUI

struct TimerView: View {
    
    @StateObject private var vm = TimerViewModel()
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
                    if vm.state == .running {
                        vm.stop()
                    }
                }
        )
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    if vm.state == .idle || vm.state == .stopped {
                        vm.ready()
                        isReady = true
                    }
                }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onEnded { _ in
                    if isReady && vm.state == .ready {
                        isReady = false
                        vm.startFromReady()
                    }
                }
        )
    }
    
    // MARK: - UI 표시할 것들
    
    // 연산 프로퍼티
    var timeText: String {
        String(format: "%.3f", vm.elapsed)
    }
    
    
}

#Preview {
    TimerView()
}
