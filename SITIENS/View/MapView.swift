//
//  MapView.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapView: View {
    @State var waterAPIViewModel : WaterAPIViewModel
    
    var body: some View {
                VStack {
                   
                    Map(
                        coordinateRegion: $waterAPIViewModel.region,
                        annotationItems: waterAPIViewModel.annotations
                    ){ place in
                        MapMarker(
                            coordinate: place.location,
                            tint: .blue
                        )
                            
                        }
                        .frame(height: 400)
                }
                .onAppear{
                    let result = waterAPIViewModel
                   
                    Task{
                        
                        try await result.showLocation()
                        await result.geocode()
                    }
                }
    }
    }
#Preview {
   
    MapView(
        waterAPIViewModel: WaterAPIViewModel(waterAPI: WaterAPI())
    )
}
