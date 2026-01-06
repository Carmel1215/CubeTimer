import SwiftUI

struct TimerView: View {

    @StateObject private var vm = TimerViewModel()

    // 0.5초 성공 여부 (ready 상태)
    @State private var isReady = false

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()

            Text(timeText)
                .font(.system(size: 72, weight: .bold, design: .monospaced))
                .foregroundStyle(.gray)
        }

        // ⏹ running 중 탭 → stop
        .highPriorityGesture(
            TapGesture()
                .onEnded {
                    if vm.state == .running {
                        vm.stop()
                    }
                }
        )

        // 🟢 0.5초 지나면 ready (초록)
        .simultaneousGesture(
            LongPressGesture(minimumDuration: 0.5)
                .onEnded { _ in
                    if vm.state == .idle || vm.state == .stopped {
                        vm.ready()
                        isReady = true
                    }
                }
        )

        // ✋ 손 떼는 순간 start
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

    var timeText: String {
        String(format: "%.3f", vm.elapsed)
    }

    var backgroundColor: Color {
        if isReady {
            return .green
        }

        if vm.state == .running {
            return .black
        }

        return .white
    }
}

#Preview {
    TimerView()
}
