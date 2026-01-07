//
//  RecordsView.swift
//  CubeTimer
//
//  Created by 김태환 on 1/6/26.
//

import SwiftUI

struct RecordsView: View {
    
    @ObservedObject var recordsVM: RecordsViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(recordsVM.records, id: \.id) { record in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(String(format: "%.3f", record.time))
                                    .font(.system(.title3, design: .monospaced))
                                    .bold()
                                
                                Text(record.date, style: .date)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(10) // FIXME: 길게 눌러 선택하면 Radius가 적용되지 않고 직사각형이 잠시 보이는 문제
                        .glassEffect(in: .rect(cornerRadius: 16))
                        .contextMenu {
                            Button {
                                // TODO: 수정 로직
                            } label: {
                                Label("수정", systemImage: "pencil")
                            }
                            Button(role: .destructive) {
                                let haptic = UIImpactFeedbackGenerator(style: .medium)
                                haptic.impactOccurred()
                                recordsVM.deleteRecord(id: record.id)
                            } label: {
                                Label("삭제", systemImage: "trash")
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("기록")
        }
    }
}
