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
    //indiqué la quantité en fonction du type de verre ⛔️
    //créer un struct avec par exemple quantity && name pour la picture
    //
//    func uptateQuanittyOfWater(quantityWater  : String,chooseBottle:String) -> Int {
//        let quantityWater = updateWater(type: quantityWater)
//        let updateWater = quantityWater * 100
//        
////        format: .number.precision(.fractionLength(1))
//        
//        let limit = 300.0
//        let BootleOfWater = quantityWaterNumber(chooseBottle: chooseBottle)
//       
//        let resultOfQuanittyOfWater =  updateWater / BootleOfWater
//        
//        
//        let resultOfType =  limit / resultOfQuanittyOfWater
//
//        print("quantityWater : \(updateWater)")
//        print("limit : \(limit)")
//        print("BootleOfWater : \(BootleOfWater)")
//        print("resultOfQuanittyOfWater : \(resultOfQuanittyOfWater)")
//        print("resultOfType : \(resultOfType)")
//        print("quantityWater +  resultOfType : \( resultOfType / quantityWater )")
//
//        return Int(resultOfType / updateWater )
//    }

    func quantityWaterNumber(chooseBottle:String,name:String) -> Double {
        let name = updateWater(type name:name)
        let updateQuantity = name * 1000
        
         switch chooseBottle {
        case "Petit – 200 ml" :
             200
        case "Moyen – 300 ml" :
             300
        case "Grand – 500 ml" :
             500
        default :
             0
        }
        return updateQuantity / chooseBottle
        
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
