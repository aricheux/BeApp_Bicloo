//
//  StationData
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation

struct Position: Codable {
    var lat: Double
    var lng: Double
}

struct StationData: Codable {
    var address: String
    var available_bike_stands: Int
    var available_bikes: Int
    var banking: Bool
    var bike_stands: Int
    var bonus: Bool
    var contract_name: String
    var last_update: Date
    var name: String
    var number: Int
    var position: Position
    var status: String
}
