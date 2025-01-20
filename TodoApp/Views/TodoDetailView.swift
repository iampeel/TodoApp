//
//  TodoDetailView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI

// TodoItem의 상세 화면
struct TodoDetailView: View {
    @Environment(\.modelContext) private var modelContext // 데이터베이스 모델 컨텍스트
    @Environment(\.dismiss) private var dismiss // 현재 화면을 닫는 기능 제공

    var item: TodoItem // 현재 상세 화면에서 표시할 TodoItem

    @State private var showingEditView: Bool = false // 수정 화면 표시 여부를 관리하는 상태 변수

    var body: some View {
        NavigationStack {
            // TodoItem의 제목과 생성 날짜를 텍스트로 표시
            Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .toolbar {
                    // 삭제 버튼
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Delete") {
                            modelContext.delete(item) // 데이터베이스에서 TodoItem 삭제
                            dismiss() // 상세 화면 닫기
                        }
                    }
                    // 수정 버튼
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Edit") {
                            showingEditView = true // 수정 화면 표시
                        }
                    }
                }
                .navigationTitle(item.title) // 상단 네비게이션 제목 설정
                .sheet(isPresented: $showingEditView) {
                    // 수정 화면 호출
                    EditTodoView(todo: item)
                }
        }
    }
}

#Preview {
    // 미리 보기 화면: 테스트를 위해 가상의 TodoItem 사용
    TodoDetailView(item: TodoItem(title: "Hello, world!"))
}
