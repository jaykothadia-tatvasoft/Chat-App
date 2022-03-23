//
//  FIRDatabaseManager.swift
//  Chat App
//
//  Created by MAC108 on 15/03/22.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

final class FIRDatabaseManager {
    
    //MARK: - Variables
    static let shared = FIRDatabaseManager()
    private let database = Database.database().reference()
    
    
    //MARK: - Methods
    
    public func insertUser(with user: UserModel) {
        database.child("users").child(user.uid).setValue(["first_name": user.firstName,
                                                          "last_name": user.lastName,
                                                          "email": user.email])
    }
    
    public func getAllUsers(completion: @escaping (((Result<[UserModel], FetchError>)?) -> Void)) {
        
        database.child("users").observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: [String:String]] else {
                (completion(.failure(.badQuery)))
                return
            }
            
            print("New user added")

            var users = [UserModel]()
            for (uid , fields) in value {
                if uid != Auth.auth().currentUser?.uid {
                    if let firstName = fields["first_name"], let lastName = fields["last_name"] {
                        let user = UserModel(uid: uid, firstName: firstName, lastName: lastName, email: "")
                        users.append(user)
                    }
                }
            }
            completion(.success(users))
        }
    }
    
    public func sendMessage(message: MessageModel, room: String) {
        database.child("chats").child(room).childByAutoId().setValue(["senderUID": message.senderId,
                                                                      "timeStamp": message.timeStamp,
                                                                      "messageBody": message.body]) { error, dbReference in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
    public func getChatRoomOnce(withId roomId: String, completion: @escaping ((Bool) -> Void)) {
        let queryRef = database.child("chats").child(roomId)
        queryRef.observeSingleEvent(of: .value) { snapshot in
            if snapshot.childrenCount == 0 {
                completion(false)
            } else {
                print(snapshot.children)
                completion(true)
                //self.attachListnerTo(room: roomId)
            }
        }
    }
    
    public func attachListnerTo(room roomID: String, completion: @escaping ((Result<[MessageModel], FetchError>) -> Void)) {
        let observeQuery = database.child("chats").child(roomID).queryOrdered(byChild: "timeStamp")
        
        observeQuery.observe(.value) { snapshot in
            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                completion(.failure(.errorInFetchingMessages))
                return
            }
            
            var messages = [MessageModel]()
            var previousDate = "0"
            
            for child in children {
                
                guard let data = child.value as? [String : String] else {
                    return
                }
                if let senderUID = data["senderUID"],
                   let timeStamp = data["timeStamp"],
                   let body = data["messageBody"] {
                    
                    let date = Date(timeIntervalSince1970: Double(timeStamp) ?? 0.0)
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeStyle = .short
                    dateFormatter.dateStyle = .none
                    let mTime = dateFormatter.string(from: date) //time
                    
                    dateFormatter.timeStyle = .none
                    dateFormatter.dateStyle = .short
                    dateFormatter.dateFormat = "dd/MM/yy"
                    let mDate = dateFormatter.string(from: date) //date
                    let index = mDate.index(mDate.startIndex, offsetBy: 2)
                    if String(mDate.prefix(upTo: index)) != previousDate {
                        print("Same date", previousDate)
                        messages.append(MessageModel(senderId: "", timeStamp: "", body: "", date: mDate, time: ""))
                    }
                    previousDate = String(mDate.prefix(upTo: index))
                    messages.append(MessageModel(senderId: senderUID, timeStamp: timeStamp, body: body, date: mDate, time: mTime))
                }
            }
            
            completion(.success(messages))
        }
    }
    
    public func removerListner(forRoom roomID: String) {
        if roomID == "" {
            return
        } else {
            database.child("chats").child(roomID).removeAllObservers()
        }
    }
}

enum FetchError: Error {
    case badQuery
    case errorInFetchingMessages
}
 
