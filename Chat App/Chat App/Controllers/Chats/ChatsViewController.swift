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
    @IBOutlet weak var tableView: UITableView!
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        return indicator
    }()
    
    //MARK: - Variables
    private lazy var viewModel: ChatsViewModel = ChatsViewModel(self)
    private lazy var navigator: ChatsNavigator = ChatsNavigator(self)
    var users: [UserModel]?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.tableView.register(ChatsTableViewCell.nib, forCellReuseIdentifier: ChatsTableViewCell.identifier)
        
        //activityIndicator.isHidden = false
        
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        viewModel.fetchAllUsers()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        activityIndicator.center = self.view.center
    }
    
    //MARK: - IB Action
    @IBAction private func didTappedLogoutBtn(_ sender: UIButton) {
        viewModel.logOutUser()
        navigator.popToRootVC()
        print(Auth.auth().currentUser?.uid)
    }
    
}

extension ChatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatsTableViewCell.identifier, for: indexPath) as! ChatsTableViewCell
        cell.user = users?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigator.pushToConversationVC(with: users?[indexPath.row])
    }
}
