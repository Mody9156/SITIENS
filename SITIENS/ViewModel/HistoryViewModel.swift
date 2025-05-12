//
//  HistoryViewModel.swift
//  SITIENS
//
//  Created by Modibo on 12/05/2025.
//

import Foundation
import CoreData

@Observable class HistoryViewModel {
     var history = [History]()
    
    var viewContext: NSManagedObjectContext?
    private var historyRepository : DataProtocol
    
    init(viewContext: NSManagedObjectContext? = nil, historyRepository: DataProtocol = HistoryRepository() ) {
        self.viewContext = viewContext
        self.historyRepository = historyRepository
        
        try? fetchHistory()
    }
    
    enum FetchError: Error {
        case fetchFailed
    }
    
    func fetchHistory() throws {
        do {
            history = try historyRepository.getHisoData()
        } catch {
            print("Fetching history failed: \(error)")
            throw FetchError.fetchFailed
        }
    }
    
    func reload()  {
        try? fetchHistory()
    }
}
