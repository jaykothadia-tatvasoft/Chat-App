//
//  LoginViewController.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Varibles
    private lazy var navigator: LoginNavigator = LoginNavigator(self)
    private lazy var viewModel: LoginViewModel = LoginViewModel(self)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        emailTextField.addShadowWithRoundCorners()
        passwordTextField.addShadowWithRoundCorners()
    }
    
    //MARK: - IB Action
    @IBAction private func backBtnTapped(_ sender: UIButton) {
        navigator.popVC()
    }
     
    
    @IBAction private func loginBtnTapped(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text, !email.isEmpty, !password.isEmpty else {
            self.showAlert(title: "Empty fields", message: "Please enter all values")
            return
        }
        
        viewModel.loginUser { [weak self] success in
            guard let self = self else { return }
            if success {
                self.navigator.pushToChatsVC()
            }
        }
    }
}
