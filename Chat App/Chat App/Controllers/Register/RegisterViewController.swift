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
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    //MARK: - Varibles
    private lazy var navigator: RegisterNavigator = RegisterNavigator(self)
    private lazy var viewModel: RegisterViewModel = RegisterViewModel(self)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        emailTextField.addShadowWithRoundCorners()
        passwordTextField.addShadowWithRoundCorners()
        firstNameTextField.addShadowWithRoundCorners()
        lastNameTextField.addShadowWithRoundCorners()
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        
        //passwordTextField.isSecureTextEntry = true
    }
    
    //MARK: - IB Action
    @IBAction private func backBtnTapped(_ sender: UIButton) {
        navigator.popVC()
    }
    
    @IBAction private func registerBtnTapped(_ sender: UIButton) {
        if viewModel.validateUserEntries {
            viewModel.registerUser { [weak self] success in
                guard let self = self else {return}
                if success {
                    self.navigator.pushToChatsVC()
                }
            }
        } else {
            return
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    //restricts numerical entry in textFields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == firstNameTextField) || (textField == lastNameTextField) {
            let allowedLetters = CharacterSet.letters
            let allowedWhiteSpace = CharacterSet.whitespaces
            let characterSet = CharacterSet(charactersIn: string)
            return allowedLetters.isSuperset(of: characterSet) || allowedWhiteSpace.isSuperset(of: characterSet)
        }else{
            return true
        }
    }
}
