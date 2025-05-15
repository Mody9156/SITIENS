//
//  MocksDataProtocol.swift
//  SITIENSTests
//
//  Created by Modibo on 15/05/2025.
//

import Testing
@testable import SITIENS
import CoreData

class MocksDataProtocol : HistoryProtocol {
    let historyManager : [History] = []
    var throwError : Bool = false
    
    
    func createInMemoryManagedObjectContext () -> NSManagedObjectContext {
        let persistentContainer = NSPersistentContainer(name: "SITIENS")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                       fatalError("Erreur lors de la création du store in-memory : \(error)")
                   }
        }
        return persistentContainer.viewContext
    }
    
    
    func createHistors(context:NSManagedObjectContext,name:String,quantity:String,date:String) -> History {
        let historyManager = History(context: context)
        historyManager.name = "FakeName"
        historyManager.quantity = "55"
        historyManager.date = "2 March 2025"
        
        return historyManager
    }
    
    func getHisoData() throws -> [SITIENS.History] {
        
        return historyManager
    }

    func addtHisoData(name: String, quantity: String) throws {
        
    }



}
