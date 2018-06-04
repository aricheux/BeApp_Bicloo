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
        
        DataManager.shared.getData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

