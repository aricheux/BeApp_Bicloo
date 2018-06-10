//
//  DataManager.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import Alamofire


/// Completion of the network request
///
/// - success: share the bike data when the request is done.
/// - failure: share the error if they have an error.
enum requestResult {
    case success([StationData]), failure(Error)
}

/// API client to get the JSON Data
class DataManager {
    let JCDecauxUrl = "https://api.jcdecaux.com/vls/v1/stations?contract=Nantes"
    let JCDecauxApiKey = "97a7e4e1830bbd06f3d9041ce47a6cc64e175806"
    
    /// Get the bike station data form JCDecaux API
    func getBikeStationData(completion: @escaping (requestResult) -> ()) {
        let param = ["apiKey": JCDecauxApiKey]
        
        Alamofire.request(JCDecauxUrl, method: .get, parameters: param, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let data = response.data {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .millisecondsSince1970
                    let bikeStation = try! decoder.decode([StationData].self, from: data)
                    completion(.success(bikeStation))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
