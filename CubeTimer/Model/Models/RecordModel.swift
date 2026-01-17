//
//  RecordModel.swift
//  CubeTimer
//
//  Created by 김태환 on 1/17/26.
//

import Foundation
import SwiftData

@Model
final class Record {
    var id: UUID
    var createdAt: Date
    var time: Double
    
    init (id: UUID = UUID(), createdAt: Date = Date.now, time: Double) {
        self.id = id
        self.createdAt = createdAt
        self.time = time
    }
}
