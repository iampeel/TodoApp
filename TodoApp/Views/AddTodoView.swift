//
//  AddTodoView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI

// 새로운 Todo를 추가하는 화면
struct AddTodoView: View {
    @Environment(\.modelContext) private var modelContext // 데이터 저장소에 접근하는 환경 변수
    @Environment(\.dismiss) private var dismiss // 현재 화면을 닫는 기능 제공
    
    @State private var title: String = "" // 사용자가 입력한 제목을 저장하는 상태 변수

    var body: some View {
        NavigationStack {
            // 입력 폼 구성
            Form {
                Section {
                    TextField("Title", text: $title) // 제목을 입력받는 텍스트 필드
                }
            }
            .navigationTitle("New Todo") // 상단 제목 설정
            .toolbar {
                // 취소 버튼
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss() // 화면 닫기
                    }
                }
                // 저장 버튼
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        let todo = TodoItem(title: title) // 사용자가 입력한 제목으로 TodoItem 생성
                        modelContext.insert(todo) // 데이터 저장소에 새 TodoItem 추가
                        dismiss() // 화면 닫기
                    }
                }
            }
        }
    }
}

#Preview {
    // 미리 보기 화면: AddTodoView를 시각적으로 테스트
    AddTodoView()
}
