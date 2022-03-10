//
//  RegisterViewController.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import UIKit

class RegisterViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Varibles
    private lazy var navigator: RegisterNavigator = RegisterNavigator(self)
    
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
