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
        case "nourrissons":
            return 0.7
        case "femmes enceintes":
            return 2.5
        case "personnes âgées":
            return 2
        case "sportifs":
            return 3
        default:
            return 0
        }
    }
    
    func updateType(name type: String) -> Double{
        switch type  {
        case "nourrissons":
            return 2.3332/1000
        case "femmes enceintes":
            return 8.36/1000
        case "personnes âgées":
            return 6.66/1000
        case "sportifs":
            return 1/100
        default:
            return 0.0
        }
        
    }
}
