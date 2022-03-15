//
//  LoginViewModel.swift
//  Chat App
//
//  Created by MAC108 on 11/03/22.
//

import Foundation
import FirebaseAuth

final class LoginViewModel {
    
    //MARK: - Variables
    private let viewController: LoginViewController
    
    
    //MARK: - Methods
    init(_ controller: LoginViewController) {
        viewController = controller
    }
    
    var validateUserEntries: Bool {
        guard let email = viewController.emailTextField.text,
              let password = viewController.passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
                  viewController.showAlert(title: "Empty fields", message: "Please enter all values")
                  return false
              }
        
        if password.count < 6 {
            viewController.showAlert(title: "Short password!!!", message: "Password should have atleast 6 characters")
            return false
        } else if !email.isValidEmail {
            viewController.showAlert(title: "Invalid Email", message: "Please enter a valid email")
            return false
        } else {
            return true
        }
    }
    
    func loginUser(completion: @escaping ((_ success: Bool) -> Void)) {
        
        guard let email = viewController.emailTextField.text,
              let password = viewController.passwordTextField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, authError in
            guard authResult != nil, authError == nil else {
                print(authError?.localizedDescription as Any)
                return
            }
            completion(true)
        }
    }
}
