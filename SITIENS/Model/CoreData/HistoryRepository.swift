//
//  HistoryRepository.swift
//  SITIENS
//
//  Created by Modibo on 07/05/2025.
//

import Foundation
import CoreData

struct HistoryRepository: DataProtocol {
    
    let viewContext : NSManagedObjectContext
    
    init(
        viewContext: NSManagedObjectContext = PersistenceController.shared.container
            .viewContext) {
                self.viewContext = viewContext
            }
    
    func getHisoData() throws -> [History] {
        let result : [History] = []
        
         viewContext.performAndWait {
             let request : NSFetchRequest<History> = History.fetchRequest()
             request.sortDescriptors = [NSSortDescriptor(SortDescriptor<History>(\.name,order: .reverse))]
        }
        
        return result
    }
    
    func addtHisoData(name: String,quantity : String) throws {
       try? viewContext.performAndWait {
            let newHistorySession = History(context: viewContext)
            newHistorySession.name = name
            newHistorySession.quantity = quantity
            
           try viewContext.save()
        }
    }
    
}
