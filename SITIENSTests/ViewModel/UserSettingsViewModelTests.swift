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
    
    @Test func UpdateQuantityOfWater() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        
        //When
        let user = userSettingsViewModel.uptateQuanittyOfWater(
            quantityWater: "Nourrissons",
            chooseBottle: "Petit – 200 ml"
        )
      
        //Then
        #expect(user == 3.5)
    }

    @Test func uantityWaterNumberIsMiddleBottle() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        //When
        let user = userSettingsViewModel.quantityWaterNumber(chooseBottle: "Moyen – 300 ml")
        
        //Then
        #expect(user == 300)
    }
    
    @Test func uantityWaterNumberIsLargeBottle() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        //When
        let user = userSettingsViewModel.quantityWaterNumber(chooseBottle: "Grand – 500 ml")
        
        //Then
        #expect(user == 500)
    }
    
    @Test func uantityWaterNumberIsEmpty() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        //When
        let user = userSettingsViewModel.quantityWaterNumber(chooseBottle: "")
        
        //Then
        #expect(user == 0)
    }
    
    
    @Test func showNumberOfGlassForDrink() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        
        //When
        let user = userSettingsViewModel.showNumberOfGlass(chooseBottle: "Grand – 500 ml", name: "Nourrissons")
        //Then
        #expect(user == 0.7142857142857143)
    }
    
    @Test func uptateQuanittyOfWaterAndWhenQuantityWaterIsEgalToZero() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        
        //When
        let user = userSettingsViewModel.uptateQuanittyOfWater2(
            quantityWater:"Nil",
            chooseBottle: "Grand – 500 ml"
        )
        
        //Then
        #expect(user == 0 )
        
    }
    
    @Test func uptateQuanittyOfWaterAndWhenBottleIsEmpty() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        
        //When
        let user = userSettingsViewModel.uptateQuanittyOfWater2(
            quantityWater:"Nourrissons",
            chooseBottle: "Nil"
        )
        
        //Then
        #expect(user == 0 )
        
    }
    
    @Test func uptateQuanittyOfWaterAndWhenBottleIsEmptyAndQuantityWater() async throws {
        //Given
        let userSettingsViewModel = UserSettingsViewModel()
        
        //When
        let user = userSettingsViewModel.uptateQuanittyOfWater2(
            quantityWater:"Nil",
            chooseBottle: "Nil"
        )
        
        //Then
        #expect(user == 0 )
        
    }
//    func uptateQuanittyOfWater(quantityWater  : String,chooseBottle:String) -> Double {
//        let waterQuantity = quantityWaterNumber(chooseBottle:chooseBottle)
//        let updatedProfile = updateWater(type :quantityWater)
//        let totalMl = updatedProfile * 1000
//        let result =  totalMl / CGFloat(waterQuantity)
//        
//        return result
//    }
    
    
    
    
//    func quantityWaterNumber(chooseBottle:String) -> Int {
//        
//        switch chooseBottle {
//        case "Petit – 200 ml" :
//            return  200
//        case "Moyen – 300 ml" :
//            return 300
//        case "Grand – 500 ml" :
//            return 500
//        default :
//            return  0
//        }
//    }
    
    
//    func updateWater(type name:String) -> CGFloat{
//        switch name  {
//        case "Nourrissons":
//            return 0.7
//        case "Femmes enceintes":
//            return 2.5
//        case "Personnes âgées":
//            return 2
//        case "Sportifs":
//            return 3
//        case "Enfants et adolescents":
//            return 2.5
//        case "Travailleurs en environnement chaud":
//            return 3
//        case "Personnes souffrant de maladies chroniques":
//            return 2
//        case "Personnes en surpoids ou obèses":
//            return 3
//        case "Voyageurs ou personnes en altitude":
//            return 3
//        case "Personnes sous traitement médicamenteux":
//            return 2
//        default:
//            return 0
//        }
//    }
}
