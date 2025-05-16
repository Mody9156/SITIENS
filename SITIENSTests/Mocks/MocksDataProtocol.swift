//
//  MocksDataProtocol.swift
//  SITIENSTests
//
//  Created by Modibo on 15/05/2025.
//

import Testing
@testable import SITIENS
import CoreData

struct MockHistory {
    var name : String
    var quantity : String
    var date : String
}

enum HistoryError: Error {
    case emptyData
}

class MocksDataProtocol : HistoryProtocol {
    var historyManager : [History] = []
    var throwError : Bool = false
    var messageError : String = ""
    var name : String = ""
    var quantity : String = ""
    var date : String = ""

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
        historyManager.name = name
        historyManager.quantity = quantity
        historyManager.date = date
        
        return historyManager
    }
//    description.type = NSInMemoryStoreType // Detruit la sauegarde en memeoire
    
    func getHisoData() throws -> [SITIENS.History] {
        var  history: [History] = []
        guard  name.isEmpty || quantity.isEmpty || date.isEmpty else {
             messageError = "There are not data"
            return history
        }
        
        guard !throwError else {
             messageError = "There are some errors"
            return history
        }
        
        let data = createHistors(context: createInMemoryManagedObjectContext(), name: name, quantity: quantity, date: date)
        
        return [data]
    }

    func addtHisoData(name: String, quantity: String) throws {
        self.name = name
        self.quantity = quantity
        
        guard  !name.isEmpty || !quantity.isEmpty  else {
            messageError = "There is no data"
            throw HistoryViewModel.FetchError.fetchFailed
            
        }
        if throwError {
            messageError = "There are some errors"
        }else{
            messageError = ""
        }
    }

}
