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

}
