//
//  DataManager.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import Alamofire

class DataManager {
    static let shared = DataManager()
    let JCDecauxUrl = "https://api.jcdecaux.com/vls/v1/stations?contract=Nantes"
    let JCDecauxApiKey = "97a7e4e1830bbd06f3d9041ce47a6cc64e175806"
    
   // func getData(completion: @escaping (JSON, Error?) -> ()) {
    func getData(){
        let param = ["apiKey": JCDecauxApiKey]
        
        Alamofire.request(JCDecauxUrl, method: .get, parameters: param, encoding: URLEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                if let reponse = response.result.value {
                    print(response)
//                    completion(JSON(reponse), nil)
                }
            case .failure(let error): break
//                completion(JSON.null, error)
            }
        }
    }
}
