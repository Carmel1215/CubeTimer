//
//  RecordsViewModel.swift
//  CubeTimer
//
//  Created by 김태환 on 1/7/26.
//

import Foundation
import Combine

final class RecordsViewModel: ObservableObject {
    
    @Published var records: [RecordModel] = []
    
    func addRecord(record: RecordModel) {
        records.append(record)
    }
    
    func deleteRecord(id: UUID) {
        records.removeAll { $0.id == id }
    }
    
    func reset() {
        records.removeAll()
    }
}
