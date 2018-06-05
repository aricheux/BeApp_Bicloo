//
//  BikeStation.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import RealmSwift

class BikeStation: Object {
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
    @objc dynamic var lattidude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var status: String = ""
    
    func initWith(stationData: StationData) {
        self.address = stationData.address
        self.available_bike_stands = stationData.available_bike_stands
        self.available_bikes = stationData.available_bikes
        self.banking = stationData.banking
        self.bike_stands = stationData.bike_stands
        self.address = stationData.address
        self.bonus = stationData.bonus
        self.contract_name = stationData.contract_name
        self.name = stationData.name
        self.lattidude = stationData.position.lat
        self.longitude = stationData.position.lng
        self.status = stationData.status
        // Formattage de la date
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH:mm' le 'dd/MM/y"
        self.last_update = "Mise à jour à " + dateFormater.string(from: stationData.last_update)
    }
}
