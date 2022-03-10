//
//  LoginViewController.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    //MARK: - Varibles
    private lazy var navigator: LoginNavigator = LoginNavigator(self)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        emailTextField.addShadowWithRoundCorners()
        passwordTextField.addShadowWithRoundCorners()
    }
    
    //MARK: - IB Action
    @IBAction private func backBtnTapped(_ sender: UIButton) {
        navigator.goBack()
    }
    
}
