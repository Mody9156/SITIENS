//
//  HistoryRepository.swift
//  SITIENS
//
//  Created by Modibo on 07/05/2025.
//

import Foundation
import CoreData

struct HistoryRepository: DataProtocol {
    
    var viewContext : NSManagedObjectContext
    
    init(
        viewContext: NSManagedObjectContext = PersistenceController.shared.container
            .viewContext) {
                self.viewContext = viewContext
            }
    
    func getHisoData() throws -> [History] {
//       try getContext()
        
        var result : [History] = []
        
        try viewContext.performAndWait {
             let request : NSFetchRequest<History> = History.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
            result = try viewContext.fetch(request)
        }
        
        return result
    }

    func addtHisoData(name: String,quantity : String) throws {

       try viewContext.performAndWait {
            let newHistorySession = History(context: viewContext)
            newHistorySession.name = name
            newHistorySession.quantity = quantity
            
           try viewContext.save()
        }
    }
    
//    private func getContext() throws -> NSManagedObjectContext {
//        if  viewContext == nil  {
//            throw NSError(
//                domain: "DataError",
//                code: 1001,
//                userInfo: [NSLocalizedDescriptionKey: "Le contexte est nul."]
//            )
//        }
//        return viewContext
//    }
}
