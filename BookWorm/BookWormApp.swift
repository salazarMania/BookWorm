//
//  BookWormApp.swift
//  BookWorm
//
//  Created by SANIYA KHATARKAR on 24/07/24.
//

import SwiftUI

@main
struct BookWormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
