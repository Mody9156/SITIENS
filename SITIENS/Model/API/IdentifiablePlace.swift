//
//  IdentifiablePlace.swift
//  SITIENS
//
//  Created by Modibo on 03/06/2025.
//

import Foundation
import CoreLocation

struct IdentifiablePlace : Identifiable {
    let id = UUID()
    let location : CLLocationCoordinate2D
}
