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
    static let shared = PersistenceController()
    
    var container : NSPersistentContainer
    private(set) var backgroundContext : NSManagedObjectContext
    
    // MARK: - Init
     init(inMemory: Bool = false ){
        container = NSPersistentContainer(name: "SitiensModel")
         if inMemory {
             container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
         }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            print("Store loaded successfully at \(storeDescription.url?.absoluteString ?? "No URL")")
            
            self.backgroundContext = container.newBackgroundContext()
            self.backgroundContext.automaticallyMergesChangesFromParent = true
            self.container.viewContext.automaticallyMergesChangesFromParent = true
            
            
        }
    }
    
    var viewContext : NSManagedObjectContext {
        container.viewContext
        
    }
    
    func newBackgroundContext() -> NSManagedObjectContext {
        let context = container.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
}
