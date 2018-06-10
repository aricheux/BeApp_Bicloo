//
//  StationData
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation

/// Position structure to match to the JSON data
struct Position: Codable {
    var lat: Double
    var lng: Double
}

/// StationData structure to convert with codable
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
    
    /// Handle the decoder of codable
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address = try values.decode(String.self, forKey: .address)
        available_bike_stands = try values.decode(Int.self, forKey: .available_bike_stands)
        available_bikes = try values.decode(Int.self, forKey: .available_bikes)
        banking = try values.decode(Bool.self, forKey: .banking)
        bike_stands = try values.decode(Int.self, forKey: .bike_stands)
        bonus = try values.decode(Bool.self, forKey: .bonus)
        contract_name = try values.decode(String.self, forKey: .contract_name)
        last_update = Date()
        if let dateUpdate = try? values.decode(Date.self, forKey: .last_update) {
            last_update = dateUpdate
        }
        name = try values.decode(String.self, forKey: .name)
        number = try values.decode(Int.self, forKey: .number)
        position = try values.decode(Position.self, forKey: .position)
        status = try values.decode(String.self, forKey: .status)
    }
}

