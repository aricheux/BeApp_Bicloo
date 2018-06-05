//
//  UIImageView.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 05/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setupBorderLayer() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 4.0
    }
    
    func setBackgroundColorWith(rangeValue: Int, rangeMax: Int) {
        var color = UIColor()
        let percentage = (rangeValue * 100) / rangeMax
        if percentage == 0 {
            color = UIColor.red
        } else if percentage < 30 {
            color = UIColor.yellow
        } else {
            color = UIColor.green
        }
        self.backgroundColor = color
    }
}
