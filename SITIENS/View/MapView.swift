//
//  MapView.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State var waterAPIViewModel : WaterAPIViewModel
    var body: some View {
        VStack {
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
            }
            .onAppear{
                let result = waterAPIViewModel
                Task{
                    try await result.showLocation()
                }
                
            }
            .mapControlVisibility(.hidden)
        }
    }
}

#Preview {
    MapView(waterAPIViewModel: WaterAPIViewModel())
}
