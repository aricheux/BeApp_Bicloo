//
//  BikeStationEntity.swift
//  BeApp_Bicloo
//
//  Created by Antoine Richeux on 04/09/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import RealmSwift

class BikeStationEntity: Object {
    @objc dynamic var address: String = ""
    @objc dynamic var available_bike_stands: Int = 0
    @objc dynamic var available_bikes: Int = 0
    @objc dynamic var banking: Bool = false
    @objc dynamic var bike_stands: Int = 0
    @objc dynamic var bonus: Bool = false
    @objc dynamic var contract_name: String = ""
    @objc dynamic var last_update: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var number: Int = 0
    @objc dynamic var latidude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var status: String = ""
    
    /// Initialize the object with the station data from API
    func initWith(stationData: BikeStationDTO) {
        self.address = stationData.address
        self.available_bike_stands = stationData.available_bike_stands
        self.available_bikes = stationData.available_bikes
        self.banking = stationData.banking
        self.bike_stands = stationData.bike_stands
        self.address = stationData.address
        self.bonus = stationData.bonus
        self.contract_name = stationData.contract_name
        self.name = stationData.name
        self.latidude = stationData.position.lat
        self.longitude = stationData.position.lng
        self.status = stationData.status
        // Formattage de la date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm' le 'dd/MM/y"
        self.last_update = "Mis à jour à " + dateFormater.string(from: Date())
        if let _lastUpdate = stationData.last_update {
            self.last_update = "Mis à jour à " + dateFormater.string(from: _lastUpdate)
        }
    }
}
