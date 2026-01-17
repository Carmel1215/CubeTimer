//
//  TimerView.swift
//  CubeTimer
//
//  Created by 김태환 on 1/13/26.
//

import SwiftUI

struct TimerScreen: View {
    @StateObject private var store: TimerStore = TimerStore()
    @Environment(\.modelContext) private var modelContext
    let recordStore: RecordStore = RecordStore()

    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            Text("\(store.formatText(time: store.elapsed))")
                .font(.system(size: 64, design: .monospaced))
                .bold()
                .foregroundStyle(store.timerState == .running ? .white : .black)
        }
        .contentShape(Rectangle())
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    guard store.timerState == .running else { return }
                    store.stop()
                    recordStore.saveRecord(Record(time: store.elapsed), in: modelContext)
                }
        )
        .gesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    store.ready()
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.prepare()
                    generator.impactOccurred()
                }
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onEnded { _ in
                    store.start()
                }
        )
    }

    var backgroundColor: Color {
        switch store.timerState {
        case .stopped: return .white
        case .ready: return .green
        case .running: return .black
        }
    }
}

#Preview {
    TimerScreen()
}
