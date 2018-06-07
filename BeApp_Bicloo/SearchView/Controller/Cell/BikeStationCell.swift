//
//  BikeStationCell.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit
import FlatUIColors

class BikeStationCell: UITableViewCell {

    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationStatus: UILabel!
    @IBOutlet weak var bikeImage: CustomImageView!
    @IBOutlet weak var bikeAvailable: UILabel!
    @IBOutlet weak var parkingImage: CustomImageView!
    @IBOutlet weak var parkingAvailable: UILabel!
    @IBOutlet weak var bankingImage: CustomImageView!
    @IBOutlet weak var updatedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupContentWith(bikeStation: BikeStation) {
        self.stationName.text = bikeStation.name
        self.stationStatus.text = bikeStation.status
        if bikeStation.status == "OPEN" {
            self.stationStatus.textColor = FlatUIColors.emerald()
        } else {
            self.stationStatus.textColor = FlatUIColors.alizarin()
        }
        self.bikeAvailable.text = " \(bikeStation.available_bikes) / \(bikeStation.bike_stands)"
        self.parkingAvailable.text = "\(bikeStation.available_bike_stands)"
        self.updatedDate.text = bikeStation.last_update
        self.bikeImage.setBackgroundColorWith(rangeValue: bikeStation.available_bikes, rangeMax: bikeStation.bike_stands)
        self.parkingImage.setBackgroundColorWith(rangeValue: bikeStation.available_bike_stands, rangeMax: bikeStation.bike_stands)
        if bikeStation.banking {
            self.bankingImage.image = #imageLiteral(resourceName: "banking")
        } else {
            self.bankingImage.image = #imageLiteral(resourceName: "noBanking")
        }
    }
    
}
