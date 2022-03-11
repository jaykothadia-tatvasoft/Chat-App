//
//  ViewController.swift
//  Chat App
//
//  Created by MAC108 on 10/03/22.
//

import UIKit

class IntroViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var registerButton: UIButton!
    
    //MARK: - Variables
    private lazy var navigator: IntroNavigator = IntroNavigator(self)
    
    //MARK: - Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: -  IB Action
    @IBAction private func loginBtnTapped(_ sender: UIButton) {
        self.navigator.pushToLoginVc()
    }
    
    @IBAction private func registerBtnTapped(_ sender: UIButton) {
        self.navigator.pushToRegisterVc()
    }


}

