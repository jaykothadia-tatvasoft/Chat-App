//
//  ChatsViewController.swift
//  Chat App
//
//  Created by MAC108 on 15/03/22.
//

import UIKit
import FirebaseAuth

class ChatsViewController: UIViewController {
    
    //MARK: - Outlets
    
    
    //MARK: - Variables
    private lazy var viewModel: ChatsViewModel = ChatsViewModel(self)
    private lazy var navigator: ChatsNavigator = ChatsNavigator(self)
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        print(Auth.auth().currentUser?.uid)
    }
    
    //MARK: - IB Action
    @IBAction private func didTappedLogoutBtn(_ sender: UIButton) {
        viewModel.logOutUser()
        navigator.popToRootVC()
    }
    
}
