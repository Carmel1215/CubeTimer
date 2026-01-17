//
//  CubeTimerApp.swift
//  CubeTimer
//
//  Created by 김태환 on 1/3/26.
//

import SwiftUI
import SwiftData

@main
struct CubeTimerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Record.self)
    }
}
