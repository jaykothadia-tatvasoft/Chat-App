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
    
    func pushToChatsVC() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let window = appDelegate.window {
                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatsNavController")
                window.rootViewController = rootVC
                window.makeKeyAndVisible()
            }
        }
    }
    
    func popVC() {
        controller.navigationController?.popViewController(animated: true)
    }
}
