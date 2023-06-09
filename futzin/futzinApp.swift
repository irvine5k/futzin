//
//  futzinApp.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import SwiftUI

@main
struct futzinApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
