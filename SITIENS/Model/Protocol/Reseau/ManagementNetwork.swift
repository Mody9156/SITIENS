//
//  ManagementReseau.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import Foundation

struct ManagementNetwork: APIManagement {
    private let session : URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    enum Failure: Swift.Error {
        case HTTPSThorwError
        
    }
    
    func fetchRequest(request: URLRequest) async throws ->  (
        Data,
        URLResponse
    ) {
        let (data,response) = try await session.data(for: request)
        
        guard let HTTPURLResponse = response as? HTTPURLResponse, (200...299).contains(HTTPURLResponse.statusCode) else {
            print("data:\(data)")
            print("data:\(response)")
            throw Failure.HTTPSThorwError
        }
        
        return (data,response)
    }
    
}
