//
//  WaterAPI.swift
//  SITIENS
//
//  Created by Modibo on 02/06/2025.
//

import Foundation

struct WaterAPI {
    var APIManagement : APIManagement
    
    init(APIManagement: APIManagement = ManagementNetwork()) {
        self.APIManagement = APIManagement
    }
    
    enum Failure : Error {
        case statueCodeError
        case error
    }
    
    func fetchURL() -> URLRequest {
        let url = URL(string: "https://hubeau.eaufrance.fr/api/v1/qualite_eau_potable/resultats_dis?size=20")!
        var request =  URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    func fetchWaterLocation() async throws -> [AnalyseEau] {
        let request = fetchURL()
        let (data,response) = try await APIManagement.fetchRequest(request: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw Failure.statueCodeError
        }
        
        do{
            let result = try JSONDecoder().decode(AnalyseEauResponse.self, from: data)
            return result.data
        }catch{
            print("Erreur de décodage : \(error)")
            throw Failure.error
        }
        
       
      
    }
}
