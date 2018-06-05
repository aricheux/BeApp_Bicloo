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
        
        let bike = realm.objects(BikeStation.self)
        print(bike.count)

        getContent()
    }

    func getContent(){
        dataManager.getBikeStationData { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let bikeStation):
                let bike = BikeStation()
                bike.initWith(stationData: bikeStation[0])
                self.saveBikeStationToCore(bike)
            }
        }
    }
    
    func saveBikeStationToCore(_ bikeStation: BikeStation) {
        
        try! realm.write {
            realm.deleteAll()
            realm.add(bikeStation)
        }
    }
}

