//
//  BikeStationCell.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

class BikeStationCell: UITableViewCell {
    
    
    @IBOutlet weak var bikeStationName: UILabel!
    @IBOutlet weak var bikeImage: UIImageView!
    
    @IBOutlet weak var updatedDate: UILabel!
    @IBOutlet weak var bikeStationStatus: UILabel!
    @IBOutlet weak var bankingImage: UIImageView!
    @IBOutlet weak var parkingAvailable: UILabel!
    @IBOutlet weak var parkingImage: UIImageView!
    @IBOutlet weak var bikeAvailable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
