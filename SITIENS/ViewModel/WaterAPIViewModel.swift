//
//  WaterAPIViewModel.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import Foundation
import CoreLocation

@Observable
class WaterAPIViewModel {
    let waterAPI : WaterAPI
    
    init(waterAPI: WaterAPI = WaterAPI()) {
        self.waterAPI = waterAPI
    }

    func showLocation() async throws  {
        do {
            let result = try await waterAPI.fetchWaterLocation()
             print("result:\(result)")
           print("other: \(result.count)")
            
        }catch{
            print("dommage il y a une erreur:\(error)")
        }
      
    }
    
    func geocode(city:String){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(city) { (placemarks, error) in
            if let error = error {
                print("Geocoding failed: \(error)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                return
            }
        }
        
    }
}
