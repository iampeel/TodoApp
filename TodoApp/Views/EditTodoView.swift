//
//  ContentView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext // 데이터 저장소에 접근하기 위한 환경 변수
    @Query private var todos: [TodoItem] // TodoItem을 데이터베이스에서 자동으로 가져오는 쿼리
    
    @State private var showingAddTodo = false // 새로운 Todo 추가 화면 표시 여부를 제어하는 상태 변수

    var body: some View {
        NavigationStack { // 뷰 계층을 관리하며 화면 간 탐색 기능 제공
            List {
                ForEach(todos) { item in // todos 리스트를 순회하여 각 아이템을 표시
                    NavigationLink { // 특정 아이템의 상세 화면으로 이동
                        TodoDetailView(item: item) // Todo의 상세 정보를 보여주는 화면으로 연결
                    } label: {
                        Text("\(item.title) at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))") // 제목과 생성 날짜를 표시
                    }
                }
                .onDelete(perform: deleteItems) // 스와이프 동작으로 아이템을 삭제하는 기능 연결
            }
            .navigationTitle("Todo List") // 상단 제목 설정
            .toolbar { // 상단 툴바 설정
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton() // 편집 버튼 추가 (삭제 모드 활성화 가능)
                }
                ToolbarItem {
                    Button(action: {
                        showingAddTodo = true // 추가 버튼 눌렀을 때 모달 표시
                    }) {
                        Label("Add Item", systemImage: "plus") // 버튼에 텍스트와 아이콘 추가
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddTodo) { // 추가 화면을 모달 형식으로 표시
            AddTodoView() // Todo 추가 화면 뷰 호출
        }
    }

    // 삭제 동작을 수행하는 함수
    private func deleteItems(offsets: IndexSet) {
        withAnimation { // 삭제 동작에 애니메이션 추가
            for index in offsets {
                modelContext.delete(todos[index]) // 데이터 저장소에서 해당 아이템 삭제
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true) // 미리보기 환경에서 메모리 기반 데이터 모델 사용
}
