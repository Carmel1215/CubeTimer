//
//  RecordsScreen.swift
//  CubeTimer
//
//  Created by 김태환 on 1/16/26.
//

import SwiftUI
import SwiftData

struct RecordScreen: View {
    @Query(sort: \Record.createdAt, order: .reverse)
    private var records: [Record]
    
    var body: some View {
        NavigationStack {
            List(records) { r in
                HStack {
                    Text("\(r.time)")
                        .font(.headline)
                    
                    Spacer()
                    
                    Text(r.createdAt, style: .date)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Records")
        }
    }
}

