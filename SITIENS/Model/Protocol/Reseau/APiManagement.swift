//
//  APiManagement.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import Foundation

protocol APIManagement {
    func fetchRequest(request:URLRequest) async throws -> (Data, URLResponse)
}
