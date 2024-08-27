//
//  DataController.swift
//  BookWorm
//
//  Created by SANIYA KHATARKAR on 24/07/24.
//

import CoreData
import Foundation

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
