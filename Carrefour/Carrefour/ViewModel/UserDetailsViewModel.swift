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
    
    var nameText: NSAttributedString {
        let nameText = NSMutableAttributedString(string: "Name: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        if let name = user.name {
            nameText.append(NSAttributedString(string: name))
        }
        return nameText
    }
    
    var followersText: NSAttributedString {
        let followersText = NSMutableAttributedString(string: "Followers: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        followersText.append(NSAttributedString(string: "\(user.followers ?? 0)"))
        return followersText
    }
    
    var followingText: NSAttributedString {
        let followingText = NSMutableAttributedString(string: "Following: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        followingText.append(NSAttributedString(string: "\(user.following ?? 0)"))
        return followingText
    }
    
    var bioText: NSAttributedString? {
        guard let bio = user.bio else {
            return nil
        }
        let bioText = NSMutableAttributedString(string: "Bio: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        bioText.append(NSAttributedString(string: bio))
        return bioText
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
