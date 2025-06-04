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
    var analyseEau : [AnalyseEau] = []
    let waterAPI : WaterAPI
    var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 46.0, longitude: 2.0), // Centre de la France par défaut
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )
    
    var annotations: [IdentifiablePlace] = []
    
    init(waterAPI: WaterAPI = WaterAPI()) {
        self.waterAPI = waterAPI
    }
    
    func showLocation() async throws  {
        do {
            let result = try await waterAPI.fetchWaterLocation()
            
            self.analyseEau = result
            print("result:\(analyseEau)")
        }catch{
            print("dommage il y a une erreur:\(error)")
        }
    }

    
    func geocode() async {
        let geocoder = CLGeocoder()
        var newAnnotations: [IdentifiablePlace] = []
        let analyseWater = Array(Set(analyseEau.map{$0.nom_departement}))
        
        for city in analyseWater {
            do{
                let placemarks = try await geocoder.geocodeAddressString(city)
                
                for place in placemarks {
                    guard let location = place.location  else { continue }
                    print("📍 \(city): \(location.coordinate)")
                    newAnnotations
                        .append(IdentifiablePlace(location: location.coordinate))
                    try await Task.sleep(nanoseconds: 300_000_000)
                    self.region.center = location.coordinate
                }
              
            }
            catch{
                print("Erreur de géocodage pour \(city): \(error)")
            }
        }
      
        self.annotations = newAnnotations
    }
}
