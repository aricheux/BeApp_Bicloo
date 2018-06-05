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

        setupTableView()
        getContent()
    }
    
    func setupTableView(){
        tableView.accessibilityIdentifier = "bikeStationTable"
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "SearchCell")
        tableView.register(UINib(nibName: "SegmentedControlCell", bundle: nil), forCellReuseIdentifier: "SegmentedControlCell")
        tableView.register(UINib(nibName: "BikeStationCell", bundle: nil), forCellReuseIdentifier: "BikeStationCell")
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

// UITableView datasource and delegate method
extension SearchViewController {

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 60
        case 2:
            return 100
        default:
            return CGFloat()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return self.realmBikeStations.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentedControlCell", for: indexPath) as! SegmentedControlCell
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeStationCell", for: indexPath) as! BikeStationCell
            cell.setupBorder()
            cell.setupContentWith(bikeStation: self.realmBikeStations[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
}

