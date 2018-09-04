//
//  MessagePopUp.swift
//  P10_Reciplease
//
//  Created by RICHEUX Antoine on 07/05/2018.
//  Copyright © 2018 Richeux Antoine. All rights reserved.
//

import UIKit

/// Enumeration to know the user choice in the UIAlertController
///
/// - OkPushed: Button ok is pushed
/// - RetryPushed: Button retry is push
/// - CancelPushed: Button cancel is push
enum PopUpChoice {
    case OkPushed, RetryPushed, CancelPushed
}

/// Enumeration to define component of the UIAlertController
///
/// - OkButton: Ok button is added in the UIAlertController
/// - RetryButton: Retry and Cancel button are added in the UIAlertController
enum PopUpType {
    case OkButton, RetryButton
}

/// Class to handle the message pop-up
class MessagePopUp {
    /// Show a pop-up with custom title, message and button
    func showMessageWith(_ title: String, _ message: String, _ viewController: UIViewController, _ typeButton: PopUpType, completion: @escaping (PopUpChoice) -> ()) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if typeButton == .OkButton {
            alertVC.addAction(UIAlertAction(title: "Ok", style: .default){ _ in
                completion(.OkPushed)
            })
        } else {
            alertVC.addAction(UIAlertAction(title: "Réessayer", style: .default){ _ in
                completion(.RetryPushed)
            })
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .destructive){ _ in
                completion(.CancelPushed)
            })
        }
        
        viewController.present(alertVC, animated: true, completion: nil)
    }
}
