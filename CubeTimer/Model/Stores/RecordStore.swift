//
//  RecordStore.swift
//  CubeTimer
//
//  Created by 김태환 on 1/17/26.
//

import Foundation
import SwiftData

class RecordStore {
    func saveRecord(_ record: Record, in context: ModelContext) {
        context.insert(record)
    }
}
