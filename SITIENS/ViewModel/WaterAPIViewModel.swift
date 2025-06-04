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
            print("result:\(analyseEau)")
        }catch{
            print("dommage il y a une erreur:\(error)")
        }
    }

    
    func geocode() async {
        let geocoder = CLGeocoder()
        
        for city in analyseEau {
            do{
                //                geocoder
                //                    .geocodeAddressString(city.nom_commune) { (placemarks, error) in
                //
                //                    if let error = error {
                //                        print("Geocoding failed: \(error)")
                //                        return
                //                    }
                //
                //                    guard let placemarks = placemarks else {
                //                        print("Pas de placemarks trouvés.")
                //                        return
                //                    }
                //
                //                    guard let location = placemarks.first,
                //                          let location = location.location
                //                    else {
                //                        print("Aucun résultat trouvé pour le géocodage.")
                //                        return
                //
                //                    }
                //
                //                        let place = IdentifiablePlace(location: location.coordinate)
                //                        self.annotation = place
                //                        self.region.center = location.coordinate
                //
                //                }
                
                let placemarks =  try await geocoder.geocodeAddressString(city.nom_commune)
                
                guard let location = placemarks.first?.location
                else {
                    print("Aucun emplacement trouvé pour \(city.nom_commune)")
                    continue
                    
                }
                
                let place = [IdentifiablePlace(location: location.coordinate)]
                
                self.annotation = place
                self.region.center = location.coordinate
                
                try await Task.sleep(nanoseconds: 300_000_000)
                
            }
            catch{
                print("Erreur de géocodage pour \(city.nom_commune): \(error)")
            }
        }
        
    }
}
