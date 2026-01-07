//
//  RecordModel.swift
//  CubeTimer
//
//  Created by 김태환 on 1/7/26.
//

import Foundation

struct RecordModel {
    
    let id: UUID
    let date: Date
    let time: Double
    
    init(time: Double) {
        self.id = UUID()
        self.date = Date()
        self.time = time
    }
}
