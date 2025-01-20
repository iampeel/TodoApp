//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Jungman Bae on 1/20/25.
//

import SwiftUI
import SwiftData

@main
struct TodoAppApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TodoItem.self, //01 Item을 삭제하고 TodoItem 만들었으니깐
        ])
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: false,
                                                    cloudKitDatabase: .automatic)  //01

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
