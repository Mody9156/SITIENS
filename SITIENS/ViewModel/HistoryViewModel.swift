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
     var name: String = ""
     var quantity: String = ""
    var errorMessage = ""
    
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
    
    
    func showMessageError()  -> String {
        if name.isEmpty || quantity.isEmpty   {
            return "Veuillez remplire tout les champs"
        }
        return ""
    }
    
    func addHistory() throws {
        quantity = showMessageError()
        
        do {
           try historyRepository.addtHisoData(name: name, quantity: quantity)
        } catch {
            print("Fetching history failed: \(error)")
            throw FetchError.fetchFailed
        }
    }
    
    func fetchHistory() throws {
        do {
            history =  try historyRepository.getHisoData()
        } catch {
            print("Fetching history failed: \(error)")
            throw FetchError.fetchFailed
        }
    }
    
    
    
    func reload()  {
        try? fetchHistory()
    }
}
