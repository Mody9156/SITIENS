//
//  HydrationActivationViewModelTests.swift
//  SITIENSTests
//
//  Created by Modibo on 14/05/2025.
//
import Testing
import XCTest
@testable import SITIENS

struct HydrationActivationViewModelTests {

    @Test func formatTimerWhenAddNewElement() async throws {
        //Gieven
        let hydrationActivationViewModel = HydrationActivationViewModel()
        let secondes = 10
        //When
        let fomatTimer = hydrationActivationViewModel.formatTimer(secondes)
        
        //Then
        #expect(fomatTimer == "00:00:10")
    }
    
    @Test func formatTimerWhenAddNewHour() async throws {
        //Gieven
        let hydrationActivationViewModel = HydrationActivationViewModel()
        let hours = 7200
        //When
        let fomatTimer = hydrationActivationViewModel.formatHour(hours)
        
        //Then
        #expect(fomatTimer == " 2")
    }
    
    @Test func whenPlayingSound() async throws {
        //Gieven
        let hydrationActivationViewModel = HydrationActivationViewModel()
        let sound = "asphalt-sizzle"
        //When
        let fomatTimer : () = hydrationActivationViewModel.playingSound(audioFile: sound)
        
        //Then
        
    }

}
