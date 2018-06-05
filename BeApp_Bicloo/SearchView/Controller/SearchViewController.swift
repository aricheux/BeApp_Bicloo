//
//  ViewController.swift
//  BeApp_Bicloo
//
//  Created by RICHEUX Antoine on 04/06/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        getContent()
    }

    func getContent(){
        dataManager.getBikeStationData { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let bikeStation):
                print(bikeStation)
            }
        }
    }
}

