//
//  AddTodoView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI

struct AddTodoView: View {
    // 데이터 저장소에 접근할 수 있는 환경 변수
    @Environment(\.modelContext) private var modelContext
    // 나를 호출한 뷰에서 닫기 기능을 동작 시키는 환경 변수(클로저)
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                }
            }
            .navigationTitle("New Todo")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let todo = TodoItem(title: title)
                        modelContext.insert(todo)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddTodoView()
}
