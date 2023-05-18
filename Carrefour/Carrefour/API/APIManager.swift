//
//  APIManager.swift
//  Carrefour
//
//  Created by exactaworks on 17/05/23.

import Alamofire
import Foundation

protocol GitHubAPIProtocol {
    func getUsers(completion: @escaping ([User]?, Error?) -> Void)
    func searchUsers(query: String, completion: @escaping ([User]?, Error?) -> Void)
    func getUser(username: String, completion: @escaping (User?, Error?) -> Void)
    func getUserRepositories(username: String, completion: @escaping ([Repository]?, Error?) -> Void)
}

class GitHubAPI: GitHubAPIProtocol {
    static let baseURL = "https://api.github.com"
    private let session: Session
    
    init(session: Session = Session.default) {
        self.session = session
    }
    
    func getUsers(completion: @escaping ([User]?, Error?) -> Void) {
        let url = GitHubAPI.baseURL + "/users"
        
        session.request(url).responseDecodable(of: [User].self) { response in
            switch response.result {
            case .success(let users):
                completion(users, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    //Não utilizado
    func searchUsers(query: String, completion: @escaping ([User]?, Error?) -> Void) {
        let url = GitHubAPI.baseURL + "/search/users"
        let parameters: [String: Any] = [
            "q": query
        ]
        
        session.request(url, parameters: parameters).responseDecodable(of: SearchResult.self) { response in
            switch response.result {
            case .success(let result):
                completion(result.items, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getUser(username: String, completion: @escaping (User?, Error?) -> Void) {
        let url = GitHubAPI.baseURL + "/users/" + username
        
        session.request(url).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let user):
                completion(user, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getUserRepositories(username: String, completion: @escaping ([Repository]?, Error?) -> Void) {
        let url = GitHubAPI.baseURL + "/users/" + username + "/repos"
        
        session.request(url).responseDecodable(of: [Repository].self) { response in
            switch response.result {
            case .success(let repositories):
                completion(repositories, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}

// MARK: - Extensions

extension GitHubAPIProtocol {
    func getUserDetails(username: String, completion: @escaping (User?, Error?) -> Void) {
        getUser(username: username, completion: completion)
    }
    
    func getUserRepositories(username: String, completion: @escaping ([Repository]?, Error?) -> Void) {
        getUserRepositories(username: username, completion: completion)
    }
}
