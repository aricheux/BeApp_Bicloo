//
//  ViewController.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {
    
    let dataManager = DataManager()
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()

        getContent()
    }

    func getContent(){
        let realmBikeStation = realm.objects(BikeStation.self)
        
        if realmBikeStation.count == 0 {
            getBikeStationData()
        } else {
            //self.tableView.reloadData()
        }
    }
    
    func getBikeStationData(){
        dataManager.getBikeStationData { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let bikeData):
                self.updateRealmDataWith(bikeData)
            }
        }
    }
    
    func updateRealmDataWith(_ bikeData: [StationData]) {
        var bikeStation: [BikeStation] = []
        for bikeData in bikeData {
            bikeStation.append(BikeStation())
            bikeStation.last?.initWith(stationData: bikeData)
        }
        
        try! realm.write {
            realm.deleteAll()
            realm.add(bikeStation)
        }
    }
}

