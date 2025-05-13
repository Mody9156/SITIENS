//
//  HistoryRepository.swift
//  SITIENS
//
//  Created by Modibo on 07/05/2025.
//

import Foundation
import CoreData

struct HistoryRepository: @preconcurrency DataProtocol {
    
    var viewContext : NSManagedObjectContext?
    
    init(
        viewContext: NSManagedObjectContext? = PersistenceController.shared.container
            .viewContext) {
                self.viewContext = viewContext
            }
    
    func getHisoData() throws -> [History] {
        let result : [History] = []
        
        guard let context = viewContext else {
            throw NSError(
                domain: "DataError",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey: "Le contexte est nul."]
            )
        }
        
        context.performAndWait {
             let request : NSFetchRequest<History> = History.fetchRequest()
             request.sortDescriptors = [NSSortDescriptor(SortDescriptor<History>(\.name,order: .reverse))]
        }
        
        return result
    }
    
    @MainActor
    func addtHisoData(name: String,quantity : String) throws {
        
        guard let context = viewContext else {
            throw NSError(
                domain: "DataError",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey: "Le contexte est nul."]
            )
        }
        
       try context.performAndWait {
            let newHistorySession = History(context: context)
            newHistorySession.name = name
            newHistorySession.quantity = quantity
            
           try context.save()
        }
    }
    
}
