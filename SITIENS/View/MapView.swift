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
                        annotationItems: waterAPIViewModel.annotation
                    ){ place in
                        MapMarker(
                            coordinate: place.location,
                            tint: .red
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
