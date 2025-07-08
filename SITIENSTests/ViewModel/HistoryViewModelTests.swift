//
//  HistoryViewModelTests.swift
//  SITIENSTests
//
//  Created by Modibo on 15/05/2025.
//

import Testing
@testable import SITIENS
import Foundation

struct HistoryViewModelTests {

    @Test func showMessageErrorWhenThere_areError() async throws {
        //Given
        let historyViewModel = HistoryViewModel()
        historyViewModel.name = "FakeName"
        historyViewModel.quantity = "1"
        //When
        let history = historyViewModel.showMessageError()
        //Then
        #expect(history?.isEmpty == nil, "There are not error")
    }
    
    @Test func showMessageErrorWhenThere_areNotName() async throws {
        //Given
        let historyViewModel = HistoryViewModel()
        historyViewModel.name = ""
        historyViewModel.quantity = "1"
        //When
        let history = historyViewModel.showMessageError()
        //Then
        #expect(history == "Veuillez remplir tous les champs.")
    }
    @Test func showMessageErrorWhenThere_areNotQuantity() async throws {
        //Given
        let historyViewModel = HistoryViewModel()
        historyViewModel.name = "fakeName"
        historyViewModel.quantity = ""
        //When
        let history = historyViewModel.showMessageError()
        //Then
        #expect(history == "Veuillez remplir tous les champs.")
    }
    
    @Test func whenAddNewHistory() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)
        historyViewModel.name = "fakeName"
        historyViewModel.quantity = "44"
        //When
        try historyViewModel.addHistory()
        
        //Then
        #expect(mocksDataProtocol.messageError.isEmpty == true)
    }
    
    @Test func whenAddNewHistoryWithError() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        mocksDataProtocol.messageError = "error"
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)
        mocksDataProtocol.name = ""
        mocksDataProtocol.quantity = ""
        
        //When//Then
        #expect(throws: HistoryViewModel.FetchError.fetchFailed, performing: {
            try historyViewModel.addHistory()
            #expect(mocksDataProtocol.messageError == "There is no data")
        })
    }
    
    @Test func whenAddNewHistoryThrowError() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        mocksDataProtocol.messageError = "error"
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)
        mocksDataProtocol.throwError = true
        historyViewModel.name = "fakeName"
        historyViewModel.quantity = "44"
        //When
        try historyViewModel.addHistory()
        
        //Then
        #expect(mocksDataProtocol.messageError == "There are some errors")
    }
    
    @Test func whenISfetchHistoryShowData() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)

        historyViewModel.name = "fakeName"
        historyViewModel.quantity = "44"
        
        //When
         try historyViewModel.fetchHistory()
        
        //Then
        #expect(mocksDataProtocol.messageError.isEmpty == true)
        
    }

    @Test func whenISfetchHistoryShowDataThrowErrorsWhenNameOrQuantityIsEMpty() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)
        mocksDataProtocol.throwError = true
        //When//Then
        #expect(throws: HistoryViewModel.FetchError.fetchFailed, performing: {
            try historyViewModel.fetchHistory()
            #expect(mocksDataProtocol.messageError == "There are not data")
        })
        
    }
    
    @Test func whenISfetchHistoryShowDataThrowErrors() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)
        mocksDataProtocol.throwError = true
        historyViewModel.name = "fakeName"
        historyViewModel.quantity = "44"
        //When//Then
        #expect(throws: HistoryViewModel.FetchError.fetchFailed, performing: {
            try historyViewModel.fetchHistory()
            #expect(mocksDataProtocol.messageError == "There are some errors")
        })
        
    }
    
    @Test func whenReloadFetchHistory() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)
        historyViewModel.name = "fakeName"
        historyViewModel.quantity = "44"
        
        //when
        let _ =  historyViewModel.reload()
        
        //Then
        #expect(historyViewModel.errorMessage.isEmpty == true)
    }
    
    @Test func whenReloadFetchHistoryThrowError() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)
        mocksDataProtocol.throwError = true
        
        //when
        let _ =  historyViewModel.reload()
        
        //Then
        #expect(historyViewModel.errorMessage.isEmpty == false)
    }
    
  
    
    
    @Test func whenDeleteElementsHistory() async throws {
        //Given
        let mocksDataProtocol = MocksDataProtocol()
        let historyViewModel = HistoryViewModel(historyRepository: mocksDataProtocol)

        historyViewModel.name = "fakeName"
        historyViewModel.quantity = "44"
        
        func delet<T>(from array : [T]) -> [T] {
            var result  = array
            return result
        }
        
        let index = IndexSet([2,4])
        
        //When
        let result: () =  historyViewModel.deleteHistory(at: index)
        
        print("other result = \(result)")

        //Then
      
    }
}


//func deleteHistory(at offsets: IndexSet) {
//    offsets.forEach { offset in
//        guard offset < history.count else { return }
//        let historyToDelete = history[offset]
//        //            viewContext.delete(historyToDelete)
//        historyRepository.deleteHistory(history: historyToDelete)
//        print("historyToDelete : \(historyToDelete)")
//    }
//    
//    do{
//        try fetchHistory()
//        print("Greate job vous avez supprimer les elements du tableaux")
//    }catch{
//        print("there are error ")
//    }
//}
