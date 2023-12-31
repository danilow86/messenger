//
//  DatabaseManager.swift
//  Messenger
//
//  Created by danilo on 21/10/2023.
//

import Foundation
import FirebaseDatabase


final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

//Mark: - Account Mgmt

extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping((Bool) -> Void)){
        
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    ///Inserts new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAdress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
    
    public struct ChatAppUser{
        let firstName: String
        let lastName: String
        let emailAdress: String
        //let profilePictureUrl: String
    }
}

