//
//  AuthService.swift
//  AzNum
//
//  Created by Babek Gadirli on 26.10.23.
//

import Foundation
import Firebase
import FirebaseAuth


struct AuthCredentials {
    let name: String
    let surname: String
    let email: String
    let password: String
}

struct AuthService {
    static func registerUser(withCredentials credentials: AuthCredentials, completion: @escaping (Error?) -> Void) {
        Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { result, error in
            if let error {
                print("DEBUG: Failed to register the user \(error.localizedDescription)")
                return
            }
            
            guard let uid = result?.user.uid else {return}
            
            let data: [String: Any] = ["uid": uid,
                                       "name": credentials.name,
                                       "surname": credentials.surname,
                                       "email": credentials.email]
            
            USER_REF.child(uid).setValue(data)
            
        }
    }
    
    static func loginUser(withEmail email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
