//
//  DatabaseService.swift
//  tagit
//
//  Created by Eamon White on 12/3/17.
//  Copyright © 2017 EamonWhite. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DatabaseService: NSObject {
    var ref: DatabaseReference!
    
    override init() {
        ref = Database.database().reference()
    }
    
    func setUser(uid: String, username: String, email: String, firstName: String, lastName: String) {
        self.ref.child(uid).setValue(["username": username, "email": email, "firstName": firstName, "lastName": lastName])
    }
    
}
