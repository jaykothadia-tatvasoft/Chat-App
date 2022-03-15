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
}
