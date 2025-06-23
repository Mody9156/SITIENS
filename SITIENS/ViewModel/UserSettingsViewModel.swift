//
//  UserSettingsViewModel.swift
//  SITIENS
//
//  Created by Modibo on 18/04/2025.
//

import Foundation

@Observable
class UserSettingsViewModel{
    
    func updateWater(type name:String) -> CGFloat{
        switch name  {
        case "Nourrissons":
            return 0.7
        case "Femmes enceintes":
            return 2.5
        case "Personnes âgées":
            return 2
        case "Sportifs":
            return 3
        case "Enfants et adolescents":
            return 2.5
        case "Travailleurs en environnement chaud":
            return 3
        case "Personnes souffrant de maladies chroniques":
            return 2
        case "Personnes en surpoids ou obèses":
            return 3
        case "Voyageurs ou personnes en altitude":
            return 3
        case "Personnes sous traitement médicamenteux":
            return 2
        default:
            return 0
        }
    }
    
    func updateType(name type: String) -> Double{
        switch type  {
        case "Nourrissons":
            return 2.3332/1000
        case "Femmes enceintes":
            return 8.36/1000
        case "Personnes âgées":
            return 6.66/1000
        case "Sportifs":
            return 1/100
        case "Enfants et adolescents":
            return 8.36/1000
        case "Travailleurs en environnement chaud":
            return 1/100
        case "Personnes souffrant de maladies chroniques":
            return 6.66/1000
        case "Personnes en surpoids ou obèses":
            return 1/100
        case "Voyageurs ou personnes en altitude":
            return 1/100
        case "Personnes sous traitement médicamenteux":
            return 6.66/1000
        default:
            return 0.0
        }
        
    }
    
        func uptateQuanittyOfWater(quantityWater  : String,chooseBottle:String) -> Int {
            let quantityWater = updateWater(type: quantityWater)
            let BootleOfWater = quantityWaterNumber(chooseBottle: chooseBottle)
            let updateWater = quantityWater * 1000
            let limit = 300
    
    
            return 10
        }
    
    func quantityWaterNumber(chooseBottle:String) -> Int {
        
        switch chooseBottle {
        case "Petit – 200 ml" :
            return  200
        case "Moyen – 300 ml" :
            return 300
        case "Grand – 500 ml" :
            return 500
        default :
            return  0
        }
    }
    
    
    
    
    func showNumberOfGlass(chooseBottle:String, name:String) -> Double {
        let waterQuantity = quantityWaterNumber(chooseBottle:chooseBottle)// 2
        let updatedProfile = updateWater(type :name)// 2 000
        let totalMl = updatedProfile * 1_000
        let result =  totalMl / CGFloat(waterQuantity)  // 2 000 / 200 = 10
        
        return result
    }
    
    func uptateQuanittyOfWater2(quantityWater : String,chooseBottle:String) -> Int {
        let quantity = updateWater(type: quantityWater)
            let update = quantity * 1000

            let limit = 300
            let bottle = quantityWaterNumber(chooseBottle: chooseBottle)
            let waterUnits = Int(update) / bottle
            let result = limit / waterUnits
        
        return Int(CGFloat(result))
    }

    func chooseBottleOfWater(name type: String) -> String {
        switch type {
        case "Petit – 200 ml" :
            return "SmallGlace"
        case "Moyen – 300 ml" :
            return "MediumGlace"
        case "Grand – 500 ml" :
            return "LargeGlace"
        default :
            return ""
        }
    }
    
}
