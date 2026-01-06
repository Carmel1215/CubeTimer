//
//  ContentView.swift
//  CubeTimer
//
//  Created by 김태환 on 1/3/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("타이머", systemImage: "timer") {
                TimerView()
            }
            Tab("기록", systemImage: "list.bullet") {
                RecordsView()
            }
            Tab("설정", systemImage: "gearshape") {
                SettingsView()
            }
        }
    }
}

#Preview {
    ContentView()
}
