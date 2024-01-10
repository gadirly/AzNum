//
//  UserService.swift
//  AzNum
//
//  Created by Babek Gadirli on 04.11.23.
//

import Foundation
import Firebase

enum UserError: Error {
    case UserServiceError
}

class UserService {
    
    static let shared = UserService()
    
    
    func fetchCurrentUser(uid: String, completion: @escaping (Result<User, Error>) -> ()) {
        USER_REF.child(uid).observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                completion(.failure(UserError.UserServiceError))
                return
            }
            
            let user = User(dictionary: value)
            completion(.success(user))
        }
    }
    
}
