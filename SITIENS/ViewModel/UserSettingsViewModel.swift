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
    func uptateQuanittyOfWater(name type: String) -> Int{
        switch type  {
        case "Nourrissons":
            return 2
        case "Femmes enceintes":
            return 8
        case "Personnes âgées":
            return 6
        case "Sportifs":
            return 1
        case "Enfants et adolescents":
            return 8
        case "Travailleurs en environnement chaud":
            return 1
        case "Personnes souffrant de maladies chroniques":
            return 6
        case "Personnes en surpoids ou obèses":
            return 1
        case "Voyageurs ou personnes en altitude":
            return 1
        case "Personnes sous traitement médicamenteux":
            return 6
        default:
            return 0
        }
  
    }
//    "Petit – 200 ml","Moyen – 300 ml",  "Grand – 500 ml"
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
