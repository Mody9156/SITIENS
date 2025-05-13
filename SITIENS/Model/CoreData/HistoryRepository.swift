//
//  HistoryRepository.swift
//  SITIENS
//
//  Created by Modibo on 07/05/2025.
//

import Foundation
import CoreData

struct HistoryRepository: DataProtocol {
    
    private var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.newBackgroundContext()) {
        self.context = context
    }
    
    func getHisoData()  throws -> [History] {
        var result: [History] = []
        
        try context.performAndWait {
            let request: NSFetchRequest<History> = History.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
            result = try context.fetch(request)
        }
        
        return result
    }

    func addtHisoData(name: String, quantity: String) throws {
        try context.performAndWait {
            let newHistory = History(context: context)
            newHistory.name = name
            newHistory.quantity = quantity
            try context.save()
        }
    }
}
