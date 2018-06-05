//
//  BikeStationCell.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

class BikeStationCell: UITableViewCell {
    
    
    @IBOutlet weak var stationName: UILabel!
    @IBOutlet weak var stationStatus: UILabel!
    @IBOutlet weak var parkingAvailable: UILabel!
    @IBOutlet weak var bikeAvailable: UILabel!
    @IBOutlet weak var bikeImage: UIImageView!
    @IBOutlet weak var parkingImage: UIImageView!
    @IBOutlet weak var bankingImage: UIImageView!
    @IBOutlet weak var updatedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupContentWith(bikeStation: BikeStation) {
        self.stationName.text = bikeStation.name
        self.stationStatus.text = bikeStation.status
        self.parkingAvailable.text = " \(bikeStation.available_bike_stands)"
        self.bikeAvailable.text = " \(bikeStation.available_bikes) / \(bikeStation.bike_stands)"
        self.updatedDate.text = bikeStation.last_update
        self.bikeImage.backgroundColor = UIColor.red
        self.parkingImage.backgroundColor = UIColor.red
        self.bankingImage.backgroundColor = UIColor.red
    }
    
}
