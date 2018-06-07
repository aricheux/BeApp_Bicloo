//
//  UIImageView.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import UIKit
import FlatUIColors

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
    
    override func layoutSubviews() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 4.0
    }
    
    func setBackgroundColorWith(rangeValue: Int, rangeMax: Int) {
        var color = UIColor()
        let percentage = (rangeValue * 100) / rangeMax
        if percentage == 0 {
            color = FlatUIColors.alizarin()
        } else if percentage < 30 {
            color = FlatUIColors.sunflower()
        } else {
            color = FlatUIColors.emerald()
        }
        self.backgroundColor = color
    }
}
