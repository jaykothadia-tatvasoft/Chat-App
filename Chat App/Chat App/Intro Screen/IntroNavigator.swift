//
//  IntroNavigator.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import Foundation
import UIKit

final class IntroNavigator {
    
    // MARK: - Variables
    private let controller : IntroViewController
    
    // MARK: - Methods
    init(_ viewController : IntroViewController) {
        controller = viewController
    }
    
    func goToLoginVc() {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        controller.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func goToRegisterVc() {
        let destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        controller.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
