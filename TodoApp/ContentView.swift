//
//  ContentView.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var todos: [TodoItem]  //01 Item을 삭제하고 TodoItem 만들었으니깐

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(todos) { item in  //01 todos으로 이름 변경했으니깐
                    NavigationLink {
                        Text("Item at \(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.createdAt, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = TodoItem(title: "New Item") //01
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(todos[index])  //01
            }
        }
    }
}

#Preview {  //01
    ContentView()
        .modelContainer(for: TodoItem.self, inMemory: true)
}
