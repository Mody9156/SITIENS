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
            let json = JSONDecoder()
            let result = try json.decode(AnalyseEauResponse.self, from: data)
            return result.data
        }catch{
            print("Erreur de décodage ❌: \(error.localizedDescription)")
              
              // Plus détaillé :
              if let decodingError = error as? DecodingError {
                  switch decodingError {
                  case .typeMismatch(let type, let context):
                      print("Type mismatch for type \(type), context: \(context)")
                  case .valueNotFound(let value, let context):
                      print("Valeur manquante: \(value), contexte: \(context)")
                  case .keyNotFound(let key, let context):
                      print("Clé manquante: \(key), contexte: \(context)")
                  case .dataCorrupted(let context):
                      print("Données corrompues, contexte: \(context)")
                  default:
                      print("Erreur inconnue: \(decodingError)")
                  }
              }
            throw Failure.error
        }
    }
}
