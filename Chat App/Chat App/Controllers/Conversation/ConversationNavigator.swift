//
//  ConversationNavigator.swift
//  Chat App
//
//  Created by MAC108 on 17/03/22.
//

import Foundation

final class ConversationNaviator {
    
    //MARK: - Variables
    private let viewController: ConversationViewController
    
    //MARK: -  Methods
    init(_ viewController: ConversationViewController) {
        self.viewController = viewController
    }
    
    func popVC() {
        self.viewController.navigationController?.popViewController(animated: true)
    }
}
