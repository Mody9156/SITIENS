//
//  DataProtocol.swift
//  SITIENS
//
//  Created by Modibo on 07/05/2025.
//

import Foundation

protocol DataProtocol {
    func getHisoData()  throws -> [History]
    func addtHisoData(name: String,quantity : String) throws
}
