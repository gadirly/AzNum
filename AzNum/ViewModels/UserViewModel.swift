//
//  UserViewModel.swift
//  AzNum
//
//  Created by Babek Gadirli on 04.11.23.
//

import Firebase

class UserViewModel {
    
    var user: User?
    let uid = Auth.auth().currentUser?.uid ?? ""
    
    func getCurrentUser(completion: @escaping () -> ()) {
        UserService.shared.fetchCurrentUser(uid: uid) { result in
            switch result {
            case .success(let user):
                self.user = user
                completion()
            case .failure(let error):
                print("DEBUG: Failed to get current user data \(error)")
                completion()
            }
        }
    }
    
    
}
