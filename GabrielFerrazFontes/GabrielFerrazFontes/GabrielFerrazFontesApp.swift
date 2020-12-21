//
//  GabrielFerrazFontesApp.swift
//  GabrielFerrazFontes
//
//  Created by Ferraz on 20/12/20.
//

import SwiftUI

@main
struct GabrielFerrazFontesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
