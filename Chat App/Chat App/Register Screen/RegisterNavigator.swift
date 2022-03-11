//
//  RegisterNavigator.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import Foundation
import UIKit

final class RegisterNavigator {
    
    // MARK: - Variables
    private let controller : RegisterViewController
    
    // MARK: - Methods
    init(_ viewController : RegisterViewController) {
        controller = viewController
    }
    
    func popVC() {
        controller.navigationController?.popViewController(animated: true)
    }
}
