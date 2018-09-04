//
//  UIImageView.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import UIKit

/// Handle the custom image view for all image view in the app
class CustomImageView: UIImageView {
    
    override init(image: UIImage?) {
        super.init(image: image)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /// Setup border of the custom view
    override func layoutSubviews() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 4.0
    }
    
    /// Setup the background color with the pourcentage value
    func setBackgroundColorWith(rangeValue: Int, rangeMax: Int) {
        var color = UIColor()
        let percentage = (rangeValue * 100) / rangeMax
        if percentage == 0 {
            color = UIColor.green
        } else if percentage < 30 {
            color = UIColor.yellow
        } else {
            color = UIColor.red
        }
        self.backgroundColor = color
    }
}
