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
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContent()
        getContent()
    }
    
    func setupContent() {
        setupTableView()
    }
    
    func setupTableView(){
        tableView.accessibilityIdentifier = "bikeStationTable"
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "SegmentedControlCell", bundle: nil), forCellReuseIdentifier: "SegmentedControlCell")
        tableView.register(UINib(nibName: "BikeStationCell", bundle: nil), forCellReuseIdentifier: "BikeStationCell")
        // Add Refresh Control to Table View
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(refreshStationData(_:)), for: .valueChanged)
    }
    
    func getContent(){
        let realmBikeStation = realm.objects(BikeStation.self)
        if realmBikeStation.count == 0 {
            getBikeStationData()
        } else {
            //let array = realmBikeStation.filter("name CONTAINS 'A'")
            self.realmBikeStations = Array(realmBikeStation)
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
    
    @objc func refreshStationData(_ sender: Any) {
        self.getBikeStationData()
        self.refreshControl?.endRefreshing()
    }
    
    @objc func segmentControlChanged(_ sender: UISegmentedControl) {
        
        if let segmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex) {
            var resultBikeStation = realm.objects(BikeStation.self)
            if sender.selectedSegmentIndex > 0 {
                resultBikeStation = resultBikeStation.filter("status CONTAINS '\(segmentTitle)'")
            }
            self.realmBikeStations = Array(resultBikeStation)
            self.tableView.reloadData()
        }
    }
}

// UITableView datasource and delegate method
extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 100
        default:
            return CGFloat()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.realmBikeStations.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SegmentedControlCell", for: indexPath) as! SegmentedControlCell
            cell.segmentControl.addTarget(self, action: #selector(self.segmentControlChanged(_:)), for: .valueChanged)
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "BikeStationCell", for: indexPath) as! BikeStationCell
            cell.setupBorder()
            cell.setupContentWith(bikeStation: self.realmBikeStations[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textChanged")
        let text = searchText.uppercased()
        
        var resultBikeStation = realm.objects(BikeStation.self)
        resultBikeStation = resultBikeStation.filter("address CONTAINS '\(text)'")
        self.realmBikeStations = Array(resultBikeStation)
        self.tableView.reloadData()
    }
}

