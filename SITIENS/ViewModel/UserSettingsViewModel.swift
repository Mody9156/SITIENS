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
    
    
}
