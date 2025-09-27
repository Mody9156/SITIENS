//
//  HistoryRepository.swift
//  SITIENS
//
//  Created by Modibo on 07/05/2025.
//

import Foundation
import CoreData
import SwiftUI

struct HistoryRepository: HistoryProtocol {
    
     var context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = PersistenceController.shared.newBackgroundContext()) {
        self.context = context
    }
    
    func getHisoData()  throws -> [History] {
        let result: [History] = try context.performAndWait {
            let request: NSFetchRequest<History> = History.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
            return try context.fetch(request)
        }
        return result
    }

    func addtHisoData(name: String, quantity: String) throws {
        let dateFormatted = Date.now.formatted(date: .numeric, time: .shortened)
        
        try context.performAndWait {
            let newHistory = History(context: context)
            newHistory.name = name
            newHistory.quantity = quantity
            newHistory.date = dateFormatted
            try context.save()
        }
    }
    
    func deleteHistory(history: History) {
        let objectID = history.objectID
        context.performAndWait {
            if let object = try? context.existingObject(with: objectID) {
                context.delete(object)
                try? context.save()
            }
        }
    }
}
