//
//  NantesAPI.swift
//  TestRxMoya
//
//  Created by Antoine Richeux on 03/09/2018.
//  Copyright © 2018 Antoine Richeux. All rights reserved.
//

import Foundation
import Moya

enum BikeStationAPI {
    case bikeStation
}

extension BikeStationAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: "https://api.jcdecaux.com")!
    }
    
    var path: String {
        return "/vls/v1/stations"
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return Task.requestCompositeData(bodyData: Data(), urlParameters: [
            "apiKey": JCDecauxApiKey,
            "contract": "Nantes"
            ])
    }
    
    var headers: [String: String]? {
        return [:]
    }
    
}
