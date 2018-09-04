//
//  DTOBikeStation.swift
//  BeApp_Bicloo
//
//  Created by Antoine Richeux on 04/09/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//
import Foundation

/// Position structure to match to the JSON data
struct Position: Codable {
    var lat: Double
    var lng: Double
}

/// StationData structure to convert with codable
struct BikeStationDTO: Codable {
    var address: String
    var available_bike_stands: Int
    var available_bikes: Int
    var banking: Bool
    var bike_stands: Int
    var bonus: Bool
    var contract_name: String
    var last_update: Date?
    var name: String
    var number: Int
    var position: Position
    var status: String
}

extension BikeStationDTO {
    func toEntity() -> BikeStationEntity {
        let bikeStationEntity = BikeStationEntity()
        bikeStationEntity.initWith(stationData: self)
        
        return bikeStationEntity
    }
}
