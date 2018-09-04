//
//  DetailViewController.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import MapKit

/// Handle the detail view
class DetailViewController: UIViewController {
    /// Bike station object from search view
    var detailStation = BikeStationEntity()
    /// Connexion to all component of the view
    @IBOutlet weak var stationStatus: UILabel!
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationAddress: UILabel!
    @IBOutlet weak var bikeAvailable: UILabel!
    @IBOutlet weak var parkingAvailable: UILabel!
    @IBOutlet weak var bikeImage: CustomImageView!
    @IBOutlet weak var parkingImage: CustomImageView!
    @IBOutlet weak var bankingText: UILabel!
    @IBOutlet weak var bankingImage: CustomImageView!
    @IBOutlet weak var updatedDate: UILabel!
    
    /// Do action when the view is loaded
    override func viewDidLoad() {
        super.viewDidLoad()

        setupContent()
    }

    /// Setup all component with the detail bike station object
    func setupContent() {
        if detailStation.status == "OPEN" {
            stationStatus.text = "OUVERTE"
            stationStatus.textColor = UIColor.green
        } else {
            stationStatus.text = "FERMEE"
            stationStatus.textColor = UIColor.red
        }
        stationName.text = detailStation.name
        stationAddress.text = detailStation.address.lowercased()
        bikeAvailable.text = String(format: "%02d" + " / " + "%02d", detailStation.available_bikes, detailStation.bike_stands)
        parkingAvailable.text = String(format: "%02d" + " / " + "%02d", detailStation.available_bike_stands, detailStation.bike_stands)
        bikeImage.setBackgroundColorWith(rangeValue: detailStation.available_bikes, rangeMax: detailStation.bike_stands)
        parkingImage.setBackgroundColorWith(rangeValue: detailStation.available_bike_stands, rangeMax: detailStation.bike_stands)
        if detailStation.banking {
            bankingImage.backgroundColor = UIColor.green
            bankingText.text = "Guichet disponible"
        } else {
            bankingImage.backgroundColor = UIColor.red
            bankingText.text = "Guichet indisponible"
        }
        updatedDate.text = detailStation.last_update
    }
    
    /// Open plans app with position of the bike station
    @IBAction func openMapForPlace() {
        let latitude = detailStation.latidude
        let longitude = detailStation.longitude
        
        let regionDistance:CLLocationDistance = 2000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = detailStation.name
        mapItem.openInMaps(launchOptions: options)
    }
}
