//
//  ChatsNavigator.swift
//  Chat App
//
//  Created by MAC108 on 15/03/22.
//

import Foundation
import UIKit

final class ChatsNavigator {
  
    //MARK: - Variables
    private let viewController: ChatsViewController
    
    //MARK: - Methods
    init(_ controller: ChatsViewController) {
        viewController = controller
    }
    
    func popToRootVC() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let window = appDelegate.window {
                let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RootNavController")
                window.rootViewController = rootVC
                window.makeKeyAndVisible()
            }
        }
    }
    
    func pushToConversationVC(with user: UserModel?) {
        guard let user = user else {
            return
        }
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
        vc.receiverUser = user
        self.viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
