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
            history =  try historyRepository.getHisoData()
        } catch {
            print("Fetching history failed: \(error)")
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
    

}
