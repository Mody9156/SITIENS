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
    
    var annotation: [IdentifiablePlace] = []
    
    init(waterAPI: WaterAPI = WaterAPI()) {
        self.waterAPI = waterAPI
    }
    
    func showLocation() async throws  {
        do {
            let result = try await waterAPI.fetchWaterLocation()
            
            self.analyseEau = result
//            print("result:\(analyseEau)")
        }catch{
            print("dommage il y a une erreur:\(error)")
        }
    }

    
    func geocode() async {
        let geocoder = CLGeocoder()
        var newAnnotations: [IdentifiablePlace] = []
        
        for city in analyseEau {
            do{
                let placemarks = try await geocoder.geocodeAddressString(city.nom_commune)
                guard let location = placemarks.first?.location else { continue }
                print("📍 \(city.nom_commune): \(location.coordinate)")
                newAnnotations
                    .append(IdentifiablePlace(location: location.coordinate))
                try await Task.sleep(nanoseconds: 300_000_000)
            }
            catch{
                print("Erreur de géocodage pour \(city.nom_commune): \(error)")
            }
        }
        self.annotation = newAnnotations
    }
}
