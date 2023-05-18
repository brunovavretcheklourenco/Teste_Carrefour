//
//  UserDetailsViewModel.swift
//  Carrefour
//
//  Created by exactaworks on 18/05/23.
//

import Foundation
import UIKit

class UserDetailsViewModel {
    private let user: User
    
    var nameText: String {
        return user.name ?? ""
    }
    
    var avatar: String? {
        guard let avatar = user.avatar_url else {
            return nil
        }
        return avatar
    }
    
    var followers: Int {
        return user.followers ?? 0
    }

    
    var following: Int {
        return user.following ?? 0
    }
    
    var bioText: NSAttributedString? {
        guard let bio = user.bio else {
            return nil
        }
        let bioText = NSMutableAttributedString(string: "Bio: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        bioText.append(NSAttributedString(string: bio))
        return bioText
    }
    
    var login: String? {
        guard let login = user.login else {
            return nil
        }
        return login
    }
    
    init(user: User) {
        self.user = user
    }
    
    func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let avatarURLString = user.avatar_url, let avatarURL = URL(string: avatarURLString) else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: avatarURL), let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
