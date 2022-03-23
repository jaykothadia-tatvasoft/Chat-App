//
//  ConversationViewModel.swift
//  Chat App
//
//  Created by MAC108 on 17/03/22.
//

import Foundation
import FirebaseAuth

final class ConversationViewModel {
    
    //MARK: - Variables
    private let viewController: ConversationViewController
    private var isNewConversation = true
    
    //MARK: -  Methods
    init(_ viewController: ConversationViewController) {
        self.viewController = viewController
    }
    
    func findRoomId() {
        guard let receiver = self.viewController.receiverUser else {
            return
        }
        
        var roomID = (Auth.auth().currentUser?.uid ?? "") + receiver.uid
        
        FIRDatabaseManager.shared.getChatRoomOnce(withId: roomID) { [weak self] success in
            guard let self = self else {
                return
            }
            if success {
                self.viewController.roomID = roomID
                print("Room found")
                self.loadMessages(from: roomID)
            } else {
                roomID = receiver.uid + (Auth.auth().currentUser?.uid ?? "")
                FIRDatabaseManager.shared.getChatRoomOnce(withId: roomID) { success in
                    if success {
                        self.viewController.roomID = roomID
                        print("Room found receiver + sender")
                        self.loadMessages(from: roomID)
                    } else {
                        self.isNewConversation = true
                    }
                }
            }
        }
    }
    
    func sendMessage(body: String) {
        
        guard let receiver = self.viewController.receiverUser, let senderId = Auth.auth().currentUser?.uid else {
            return
        }
        
        var roomID = ""
        
        if self.viewController.roomID != "" {
            roomID = self.viewController.roomID
        } else {
            roomID = (Auth.auth().currentUser?.uid ?? "") + receiver.uid
        }
        
        let message = MessageModel(senderId: senderId,
                                   timeStamp: String(Date().timeIntervalSince1970),
                                   body: body, date: "", time: "")
        FIRDatabaseManager.shared.sendMessage(message: message, room: roomID)
        
        if self.isNewConversation {
            self.loadMessages(from: roomID)
            self.isNewConversation = false
        }
        
    }
    
    func loadMessages(from roomID: String) {
        FIRDatabaseManager.shared.attachListnerTo(room: roomID) { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let messageData):
                DispatchQueue.main.async {
                    self.viewController.messages = messageData
                    self.viewController.tableView.reloadData()
                    let indexPath = IndexPath(row: self.viewController.messages.count - 1, section: 0)
                    self.viewController.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
}
