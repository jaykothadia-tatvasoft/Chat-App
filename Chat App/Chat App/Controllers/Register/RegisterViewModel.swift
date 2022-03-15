//
//  RegisterViewModel.swift
//  Chat App
//
//  Created by MAC108 on 11/03/22.
//

import Foundation
import FirebaseAuth

final class RegisterViewModel {
    
    //MARK: - Variables
    private let viewController: RegisterViewController
    
    //MARK: - Methods
    init(_ controller: RegisterViewController) {
        viewController = controller
    }
    
    var validateUserEntries: Bool {
        guard let email = viewController.emailTextField.text,
              let password = viewController.passwordTextField.text,
              let firstName = viewController.firstNameTextField.text,
              let lastName = viewController.lastNameTextField.text,
              !firstName.isEmpty,
              !lastName.isEmpty,
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
    
    func registerUser(completion: @escaping ((_ success: Bool) -> Void)) {
        
        guard let email = viewController.emailTextField.text,
              let password = viewController.passwordTextField.text,
              let firstName = viewController.firstNameTextField.text,
              let lastName = viewController.lastNameTextField.text else { return }
        
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, authError in
            
            guard let self = self else { return }
            
            guard authError == nil, let authResult = authResult else {
                self.viewController.showAlert(title: "Oops!!!", message: authError!.localizedDescription)
                return
            }
            
            let user = UserModel(uid: authResult.user.uid as String,
                                 firstName: firstName,
                                 lastName: lastName,
                                 email: email)
            
            FIRDatabaseManager.shared.insertUser(with: user)
            
            Auth.auth().signIn(withEmail: email, password: password) { loginResult, loginError in
                guard loginResult != nil, loginError == nil else { return }
                completion(true)
            }
        }
    }

}
