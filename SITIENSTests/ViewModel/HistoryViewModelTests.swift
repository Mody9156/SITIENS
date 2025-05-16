//
//  HistoryViewModelTests.swift
//  SITIENSTests
//
//  Created by Modibo on 15/05/2025.
//

import Testing
@testable import SITIENS

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
        historyViewModel.name = ""
        historyViewModel.quantity = ""
        
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
        
        //When
        try historyViewModel.addHistory()
        
        //Then
        #expect(mocksDataProtocol.messageError == "There are some errors")
    }

}
