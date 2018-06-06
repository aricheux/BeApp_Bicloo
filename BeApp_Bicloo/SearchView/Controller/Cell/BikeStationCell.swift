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
    @IBOutlet weak var bikeImage: UIImageView!
    @IBOutlet weak var bikeAvailable: UILabel!
    @IBOutlet weak var parkingImage: UIImageView!
    @IBOutlet weak var parkingAvailable: UILabel!
    @IBOutlet weak var bankingImage: UIImageView!
    @IBOutlet weak var updatedDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = UIEdgeInsetsInsetRect(contentView.frame, UIEdgeInsetsMake(0, 8, 2, 8))
    }
    
    func setupBorder() {
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
    }
    
    func setupContentWith(bikeStation: BikeStation) {
        self.stationName.text = bikeStation.name
        self.stationStatus.text = bikeStation.status
        if bikeStation.status == "OPEN" {
            self.stationStatus.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            self.stationStatus.textColor = UIColor.red
        }
        self.bikeAvailable.text = " \(bikeStation.available_bikes) / \(bikeStation.bike_stands)"
        self.parkingAvailable.text = "\(bikeStation.available_bike_stands)"
        self.updatedDate.text = bikeStation.last_update
        
        setupImageViewWith(bikeStation: bikeStation)
    }
    
    func setupImageViewWith(bikeStation: BikeStation) {
        self.bikeImage.setupBorderLayer()
        self.bikeImage.setBackgroundColorWith(rangeValue: bikeStation.available_bikes, rangeMax: bikeStation.bike_stands)
        self.parkingImage.setupBorderLayer()
        self.parkingImage.setBackgroundColorWith(rangeValue: bikeStation.available_bike_stands, rangeMax: bikeStation.bike_stands)
        self.bankingImage.setupBorderLayer()
        if bikeStation.banking {
            self.bankingImage.image = #imageLiteral(resourceName: "banking")
        } else {
            self.bankingImage.image = #imageLiteral(resourceName: "noBanking")
        }
    }
    
}
