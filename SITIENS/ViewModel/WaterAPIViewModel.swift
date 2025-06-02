//
//  WaterAPIViewModel.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import Foundation

@Observable
class WaterAPIViewModel {
    let waterAPI : WaterAPI
    
    init(waterAPI: WaterAPI = WaterAPI()) {
        self.waterAPI = waterAPI
    }
    
    func showLocation() async throws {
     let result = try await waterAPI.fetchWaterLocation()
      print("result:\(result)")
    }
}
