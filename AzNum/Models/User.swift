//
//  User.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import Foundation

struct User {
    let id: String?
    let email: String
    let name: String
    let surname: String
    
    init(dictionary: [String: Any]) {
        self.id = dictionary["uid"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.surname = dictionary["surname"] as? String ?? ""
    }
    
}
