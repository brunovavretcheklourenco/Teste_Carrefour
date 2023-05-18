//
//  UserListViewModel.swift
//  Carrefour
//
//  Created by exactaworks on 18/05/23.
//

import Foundation

class UserListViewModel {
    private let api: GitHubAPIProtocol
    
    init(api: GitHubAPIProtocol = GitHubAPI()) {
        self.api = api
    }
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        api.getUsers { users, error in
            completion(users, error)
        }
    }
    
    func getUserDetails(for user: User, completion: @escaping (User?, Error?) -> Void) {
        guard let username = user.login else {
            completion(nil, nil)
            return
        }
        
        api.getUser(username: username) { userDetails, error in
            completion(userDetails, error)
        }
    }
}
