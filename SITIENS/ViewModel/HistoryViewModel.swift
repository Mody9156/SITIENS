//
//  HistoryViewModel.swift
//  SITIENS
//
//  Created by Modibo on 12/05/2025.
//

import Foundation
import CoreData
import SwiftUICore

@Observable class HistoryViewModel {
     var history = [History]()
     var name: String
     var quantity: String
    var errorMessage = ""
    
    var viewContext: NSManagedObjectContext?
    var historyRepository : HistoryProtocol
    
    init(viewContext: NSManagedObjectContext? = nil, historyRepository: HistoryProtocol = HistoryRepository() ,name: String = "", quantity: String = "") {
        self.viewContext = viewContext
        self.historyRepository = historyRepository
        self.name = name
        self.quantity = quantity
        
        try?  fetchHistory()
    }
    
    enum FetchError: Error {
        case fetchFailed
    }
    
    
    func showMessageError()  -> String? {
        if name.isEmpty || quantity.isEmpty   {
            return "Veuillez remplir tous les champs."
        }
        return nil
    }
    
    func addHistory() throws {
        if let erreor =  showMessageError(){
             errorMessage = erreor
             
        }

        do {
            
           try historyRepository.addtHisoData(name: name, quantity: quantity)
            print("result : \(name) \(quantity)")
        } catch {
            print("Fetching history failed: \(error)")
            throw FetchError.fetchFailed
        }
    }
    
    func fetchHistory()  throws {
        do {
            history = try historyRepository.getHisoData()
        } catch {
            throw FetchError.fetchFailed
        }
    }
    
    
    
    func reload() {
        do{
            try  fetchHistory()
        }catch {
            errorMessage = "Échec du rechargement des données : \(error.localizedDescription)"
        }
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { offset in
            guard offset < history.count else { return }
            let historyToDelete = history[offset]
            viewContext?.delete(historyToDelete)
        }
        
        do{
          try  viewContext?.save()
          try  fetchHistory()
        }catch{
            print("there are error ")
        }
    }
}
