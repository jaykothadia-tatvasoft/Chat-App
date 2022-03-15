//
//  FIRDatabaseManager.swift
//  Chat App
//
//  Created by MAC108 on 15/03/22.
//

import Foundation
import FirebaseDatabase

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
}
 
