//
//  ViewController.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

/// Class to handle the search view
class SearchViewController: UITableViewController {
    /// Connexion to the search bar in the tableView
    @IBOutlet weak var searchBar: UISearchBar!
    /// manager to get the data with network request
    let dataManager = DataManager()
    /// A Realm instance who represents a Realm database.
    let realm = try! Realm()
    /// Array to convert json data to bike station data
    var realmBikeStations: [BikeStationEntity] = []
    /// pop-up to show a message to the user
    let popUp = MessagePopUp()
    // Bag
    let bag = DisposeBag()
    
    /// Do action when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        getContent()
    }
    
    /// Configure and setup table view feature
    func setupTableView(){
        tableView.accessibilityIdentifier = "bikeStationTable"
        tableView.tableFooterView = UIView()
        tableView.register(UINib(nibName: "SegmentedControlCell", bundle: nil), forCellReuseIdentifier: "SegmentedControlCell")
        tableView.register(UINib(nibName: "BikeStationCell", bundle: nil), forCellReuseIdentifier: "BikeStationCell")
        // update data when user refresh table view
        self.refreshControl?.addTarget(self, action: #selector(refreshStationData(_:)), for: .valueChanged)
    }
    
    /// Get bike station data from realm database or send the request
    func getContent(){
        let realmBikeStation = realm.objects(BikeStationEntity.self)
        
        if realmBikeStation.count == 0 {
            getBikeStationData()
        } else {
            self.realmBikeStations = Array(realmBikeStation)
            self.tableView.reloadData()
        }
    }
    
    /// Send the request to get the bike data and handle the result
    func getBikeStationData(){
        
        BikeStationRestManager.shared.getBikeStationObservable()
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (_bikeStation) in
            self.writeRealmDataWith(_bikeStation)
            self.tableView.reloadData()
        })
        .disposed(by: bag)
    }
    
    /// Write bike station data to the realm database
    func writeRealmDataWith(_ bikeData: [BikeStationEntity]) {
        self.realmBikeStations = bikeData
        
        try! realm.write {
            realm.deleteAll()
            realm.add(bikeData)
        }
    }
    
    /// Handle the pull to refresh gesture
    @objc func refreshStationData(_ sender: Any) {
        self.getBikeStationData()
        self.refreshControl?.endRefreshing()
    }
    
    /// Handle the segment control when the value changed
    @objc func segmentControlChanged(_ sender: UISegmentedControl) {
        var resultBikeStation = realm.objects(BikeStationEntity.self)
        
        if sender.selectedSegmentIndex == 1 {
            resultBikeStation = resultBikeStation.filter("status CONTAINS 'OPEN'")
        } else if sender.selectedSegmentIndex == 2 {
            resultBikeStation = resultBikeStation.filter("status CONTAINS 'CLOSED'")
        }
        self.realmBikeStations = Array(resultBikeStation)
        
        self.tableView.reloadData()
    }
    
    /// Dismiss keyboard when the user tap outside the search bar.
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchBar.endEditing(true)
    }
}

// UITableView datasource and delegate method
extension SearchViewController {
    
    /// Set the height row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 60
        case 1:
            return 110
        default:
            return CGFloat()
        }
    }
    
    /// Set the number of section
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    /// Set the number of row by section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return self.realmBikeStations.count
        }
        return 1
    }
    
    /// Configure all cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "SegmentedControlCell", for: indexPath) as! SegmentedControlCell
            cell.selectionStyle = .none
            cell.segmentControl.addTarget(self, action: #selector(self.segmentControlChanged(_:)), for: .valueChanged)
            return cell
            
        case 1:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "BikeStationCell", for: indexPath) as! BikeStationCell
            cell.setupContentWith(bikeStation: self.realmBikeStations[indexPath.row])
            return cell
            
        default:
            return UITableViewCell()
            
        }
    }
    
    /// Push to the detail view when a row is pushed with the bike station data
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard : UIStoryboard = UIStoryboard(name: "DetailView", bundle:nil)
        let detailView = mainStoryboard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        detailView.detailStation = self.realmBikeStations[indexPath.row]
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

/// Handle UISearchBarDelegate method
extension SearchViewController: UISearchBarDelegate {
    
    /// Update the table view the search text changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var resultBikeStation = realm.objects(BikeStationEntity.self)
        if !searchText.isEmpty {
            resultBikeStation = resultBikeStation.filter("name CONTAINS '\(searchText)'")
        }
        self.realmBikeStations = Array(resultBikeStation)
        self.tableView.reloadData()
    }
}

