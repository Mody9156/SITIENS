//
//  WaterAPIViewModel.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import Foundation
import CoreLocation
import MapKit

@Observable
class WaterAPIViewModel {
    let waterAPI : WaterAPI
    var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 46.0, longitude: 2.0), // Centre de la France par défaut
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    var annotation: IdentifiablePlace? = nil
    
    
    init(waterAPI: WaterAPI = WaterAPI()) {
        self.waterAPI = waterAPI
    }
    
    func showLocation() async throws  {
        do {
            let result = try await waterAPI.fetchWaterLocation()
           
        
            
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
            
            guard let placemarks = placemarks, !placemarks.isEmpty else {
                      print("No placemarks found")
                      return
                  }
             
            for placemarks in placemarks {
                if let location = placemarks.location {
                    let place =  IdentifiablePlace(location: location.coordinate)
                    self.annotation = place
                }
            }
            
            if let firtsLocation = placemarks.first?.location {
                self.region.center = firtsLocation.coordinate
                
            }
//
//            guard  let location = placemarks.location
//                   
//            else {
//                print("No placemark found")
//                return
//            }
//            print("location:\(location)")
//                self.region.center = location.coordinate
                
        }
        
    }
}
