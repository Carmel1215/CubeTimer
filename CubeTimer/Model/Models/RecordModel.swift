//
//  RecordModel.swift
//  CubeTimer
//
//  Created by 김태환 on 1/17/26.
//

import Foundation

struct Record {
    let id: UUID
    let createdAt: Date
    let time: Double
    
    init (id: UUID = UUID(), createdAt: Date = Date(), time: Double) {
        self.id = id
        self.createdAt = createdAt
        self.time = time
    }
}
