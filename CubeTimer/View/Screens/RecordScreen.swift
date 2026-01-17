//
//  RecordsScreen.swift
//  CubeTimer
//
//  Created by 김태환 on 1/16/26.
//

import SwiftUI
import SwiftData

struct RecordScreen: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Record.createdAt, order: .reverse)
    private var records: [Record]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(records, id: \.id) { r in
                    HStack {
                        Text("\(r.time)")
                            .font(.headline)
                        
                        Spacer()
                        
                        Text(r.createdAt, style: .date)
                            .foregroundStyle(.secondary)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("Records")
            .toolbar {
                EditButton()
            }
            
        }
    }
    
    private func delete(_ indexSet: IndexSet) {
        for index in indexSet {
            modelContext.delete(records[index])
        }
    }
}

