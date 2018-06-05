//
//  ViewController.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        getContent()
    }

    func getContent(){
        DataManager.shared.getBikeStationData { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let bikeStation):
                for bike in bikeStation {
                    print(bike.name)
                }
            }
        }
    }
}

