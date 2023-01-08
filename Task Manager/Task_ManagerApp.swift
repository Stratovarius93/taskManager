//
//  Task_ManagerApp.swift
//  Task Manager
//
//  Created by Juan Carlos Catagña Tipantuña on 25/12/22.
//

import SwiftUI

@main
struct Task_ManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
