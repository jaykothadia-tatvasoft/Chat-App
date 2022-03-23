//
//  ConversationViewController.swift
//  Chat App
//
//  Created by MAC108 on 17/03/22.
//

import UIKit
import FirebaseAuth

class ConversationViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    
    
    //MARK: - Variables
    private lazy var viewModel: ConversationViewModel = ConversationViewModel(self)
    private lazy var navigator: ConversationNaviator = ConversationNaviator(self)
    var messages: [MessageModel] = [MessageModel]()
    var receiverUser: UserModel?
    var roomID = ""
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageTextField.withRoundCorners()
        self.tableView.register(SenderTableViewCell.nib, forCellReuseIdentifier: SenderTableViewCell.identifier)
        self.tableView.register(ReceiverTableViewCell.nib, forCellReuseIdentifier: ReceiverTableViewCell.identifier)
        self.tableView.register(UINib(nibName: "DateTableViewCell", bundle: nil), forCellReuseIdentifier: "DateTableViewCell")
        
        if let receiverUser = receiverUser {
            self.titleLbl.text = "\(receiverUser.firstName) \(receiverUser.lastName)"
            
            viewModel.findRoomId()
        }
        
    }
    
    
    //MARK: - IB Action
    @IBAction func didTapBackBtn(_ sender: UIButton) {
        self.navigator.popVC()
        FIRDatabaseManager.shared.removerListner(forRoom: self.roomID)
    }
    
    @IBAction func didTapSend(_ sender: UIButton) {
        self.messageTextField.resignFirstResponder()
        if let messageBody = self.messageTextField.text {
            if messageBody.isEmpty {
                self.showAlert(title: "No message typed", message: "Please type a message")
            } else {
                viewModel.sendMessage(body: messageBody)
            }
        }
        
        
        self.messageTextField.text = ""
    }
    
}


extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messages[indexPath.row].senderId == Auth.auth().currentUser?.uid {
            let cell = tableView.dequeueReusableCell(withIdentifier: SenderTableViewCell.identifier, for: indexPath) as! SenderTableViewCell
            cell.messageLbl.text = self.messages[indexPath.row].body
            cell.timeLbl.text = "\(self.messages[indexPath.row].time)"
            return cell
        } else if messages[indexPath.row].senderId != "" {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReceiverTableViewCell.identifier, for: indexPath) as! ReceiverTableViewCell
            cell.messageLbl.text = self.messages[indexPath.row].body
            cell.timeLbl.text = "\(self.messages[indexPath.row].time)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableViewCell", for: indexPath) as! DateTableViewCell
            cell.dateLbl.text = messages[indexPath.row].date
            return cell
        }
    }
}
