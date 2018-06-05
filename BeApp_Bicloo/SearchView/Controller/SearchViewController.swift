//
//  ViewController.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import RealmSwift

class SearchViewController: UITableViewController {
    
    let dataManager = DataManager()
    let realm = try! Realm()
    var realmBikeStations: [BikeStation] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        getContent()
    }

    func getContent(){
        let realmBikeStation = realm.objects(BikeStation.self)
        if realmBikeStation.count == 0 {
            getBikeStationData()
        } else {
            self.realmBikeStations = Array(realm.objects(BikeStation.self))
            self.tableView.reloadData()
        }
    }
    
    func getBikeStationData(){
        dataManager.getBikeStationData { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let bikeData):
                self.writeRealmDataWith(bikeData)
                self.tableView.reloadData()
            }
        }
    }
    
    func writeRealmDataWith(_ bikeData: [StationData]) {
        self.realmBikeStations.removeAll()
        for bikeData in bikeData {
            self.realmBikeStations.append(BikeStation())
            self.realmBikeStations.last?.initWith(stationData: bikeData)
        }
        
        try! realm.write {
            realm.deleteAll()
            realm.add(self.realmBikeStations)
        }
    }
}

extension SearchViewController {    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.realmBikeStations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = self.realmBikeStations[indexPath.row].name
        
        return cell
    }
}

