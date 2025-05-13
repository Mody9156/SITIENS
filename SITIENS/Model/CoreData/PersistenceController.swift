//
//  PersistenceController.swift
//  SITIENS
//
//  Created by Modibo on 27/04/2025.
//

import Foundation
import CoreData

struct PersistenceController{
    
    // MARK: - Properties
    nonisolated(unsafe) static let shared = PersistenceController()
    var container : NSPersistentContainer
    let backgroundContext : NSManagedObjectContext
    
    // MARK: - Init
     init(inMemory: Bool = false ){
        container = NSPersistentContainer(name: "SitiensModel")
        backgroundContext = container.newBackgroundContext()
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        self.backgroundContext.automaticallyMergesChangesFromParent = true
    }
}
