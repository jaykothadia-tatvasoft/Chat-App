//
//  UIViewController + Alerts.swift
//  Chat App
//
//  Created by MAC108 on 11/03/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    //MARK: - Alerts
    public func showAlert(title: String, message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
}
