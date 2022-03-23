//
//  ChatsViewModel.swift
//  Chat App
//
//  Created by MAC108 on 15/03/22.
//

import Foundation
import FirebaseAuth

final class ChatsViewModel {
    
    //MARK: - Variables
    private let viewController: ChatsViewController
    
    //MARK: - Methods
    init(_ controller: ChatsViewController) {
        viewController = controller
    }
    
    func logOutUser() {
        do {
           try Auth.auth().signOut()
        } catch {
            print("Error logging out user: \(error.localizedDescription)")
        }
    }
    
    func fetchAllUsers() {
        FIRDatabaseManager.shared.getAllUsers { [weak self] result in
            guard let self = self, let result = result else { return }
            
            switch result {
            case .success(let users):
                self.viewController.users = users
                DispatchQueue.main.async {
                    self.viewController.tableView.reloadData()
                    self.viewController.activityIndicator.stopAnimating()
                }
                break
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.viewController.activityIndicator.stopAnimating()
                }
                break
            }
        }
    }
}
