//
//  MapView.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map{
            Marker(
                "Paris",
                coordinate: CLLocationCoordinate2D(latitude: 48.862725, longitude: 2.287592)
                
            )
            .tint(.orange)
            Marker("Lyon", coordinate: CLLocationCoordinate2D(latitude: 45.7578137, longitude: 4.8320114))
                                .tint(.blue)
            Marker(
                "Marseille",
                coordinate: CLLocationCoordinate2D(
                    latitude:43.2961743,
                    longitude: 5.3699525
                )
            )
        } .mapControlVisibility(.hidden)
        
        
    }
}

#Preview {
    MapView()
}
