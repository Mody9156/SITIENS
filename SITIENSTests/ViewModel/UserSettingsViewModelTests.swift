//
//  UserSettingsViewModelTests.swift
//  SITIENSTests
//
//  Created by Modibo on 14/05/2025.
//

import Testing
import XCTest
@testable import SITIENS

struct UserSettingsViewModelTests {

    @Test func updateTypeWithNewNameIsEgaltoNourrissons() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Nourrissons"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 2.3332/1000)
       
    }
    
    @Test func updateTypeWithNewNameIsEgaltoWomen() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Femmes enceintes"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 8.36/1000)
    }
    
    @Test func updateTypeWithNewNameIsEgaltoGrandFatherOrMother() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes âgées"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 6.66/1000)
    }
    
    @Test func updateTypeWithNewNameIsEgaltosportifs() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Sportifs"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.01)
    }

    @Test func updateTypeWithChildsAndTeenagers() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Enfants et adolescents"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.00836)
    }
    
    @Test func updateTypeWithHotEnvironment() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Travailleurs en environnement chaud"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.01)
    }
    
    @Test func updateTypeWitPeopleWithChronicIllnesses() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes souffrant de maladies chroniques"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.00666)
    }

    @Test func updateTypeWitPeopleWithOverweightOrObesePeople() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes en surpoids ou obèses"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.01)
    }
    
    @Test func updateTypeWitPeopleInHighAltitude() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Voyageurs ou personnes en altitude"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.01)
    }

    @Test func updateTypeWitPeopleOnMedication() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes sous traitement médicamenteux"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.00666)
    }

    @Test func updateTypeWithNewName() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "FakeName"
        //When
        let user = userSettingsViewModel.updateType(name: name)
        //Then
        #expect(user == 0.0)
    }
    
 
    @Test func updateWaterWhenResultIsEgalToNourrissons() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Nourrissons"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 0.7)
    }
    
    @Test func updateWaterWhenResultIsEgalToWomen() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Femmes enceintes"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 2.5)
    }
    @Test func updateWaterWhenResultIsEgalToGrandFatherOrMother() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes âgées"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 2)
    }
    
    @Test func updateWaterWhenResultIsEgalToSportifs() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Sportifs"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 3)
    }
    
    @Test func updateWaterWhenResultIsEgalToChildsAndTeenagers() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Enfants et adolescents"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 2.5)
    }
    
    @Test func updateWaterWhenResultIsEgalToHotEnvironment() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Travailleurs en environnement chaud"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 3)
    }
    
    @Test func updateWaterWhenResultIsEgalToPeopleWithChronicIllnesses() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes souffrant de maladies chroniques"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 2)
    }
    
    @Test func updateWaterWhenResultIsEgalToPeopleWithOverweightOrObesePeople() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes en surpoids ou obèses"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 3)
    }
    
    @Test func updateWaterWhenResultIsEgalToPeopleInHighAltitude() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Voyageurs ou personnes en altitude"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 3)
    }
    
    @Test func updateWaterWhenResultIsEgalToPeopleOnMedication() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "Personnes sous traitement médicamenteux"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 2)
    }
    
    @Test func updateWater() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        let name = "FakeName"
        //When
        let user = userSettingsViewModel.updateWater(type: name)
        //Then
        #expect(user == 0)
    }

}
