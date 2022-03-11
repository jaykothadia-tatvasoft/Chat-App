//
//  LoginNavigator.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import Foundation
import UIKit

final class LoginNavigator {
    
    // MARK: - Variables
    private let controller : LoginViewController
    
    // MARK: - Methods
    init(_ viewController : LoginViewController) {
        controller = viewController
    }
    
    func popVC() {
        controller.navigationController?.popViewController(animated: true)
    }
}
