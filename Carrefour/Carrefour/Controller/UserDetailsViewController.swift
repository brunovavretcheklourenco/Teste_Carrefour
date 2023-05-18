//
//  UserDetailsViewController.swift
//  Carrefour
//
//  Created by exactaworks on 17/05/23.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController {
    
    var user: User
    
    private var overlayLoadingView: OverlayLoadingView?
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()        
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
        avatarImageView.clipsToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        setupUI()
        loadImage()
    }
    
    private func setupUI() {
        addAvatarImageView()
        addOverlayLoadingView()
        addNameLabel()
        addFollowersLabel()
        addFollowingLabel()
        addBioLabel()
    }
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private func addAvatarImageView() {
        view.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 200),
            avatarImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func addOverlayLoadingView() {
        overlayLoadingView = OverlayLoadingView(loadingText: "Loading...")
        if let overlayLoadingView = overlayLoadingView {
            view.addSubview(overlayLoadingView)
            overlayLoadingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                overlayLoadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                overlayLoadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                overlayLoadingView.topAnchor.constraint(equalTo: view.topAnchor),
                overlayLoadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
            overlayLoadingView.startLoading()
        }
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        let nameText = NSMutableAttributedString(string: "Name: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        if let name = user.name {
            nameText.append(NSAttributedString(string: name))
        }
        label.attributedText = nameText
        
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        let followersText = NSMutableAttributedString(string: "Followers: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        followersText.append(NSAttributedString(string: "\(user.followers ?? 0)"))
        label.attributedText = followersText
        
        return label
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        let followingText = NSMutableAttributedString(string: "Following: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        followingText.append(NSAttributedString(string: "\(user.following ?? 0)"))
        label.attributedText = followingText
        
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        let bioText = NSMutableAttributedString(string: "Bio: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        if let bio = user.bio {
            bioText.append(NSAttributedString(string: bio))
        }
        label.attributedText = bioText
        
        return label
    }()
    
    private func addNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20)
        ])
    }
    
    private func addFollowersLabel() {
        view.addSubview(followersLabel)
        followersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            followersLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            followersLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func addFollowingLabel() {
        view.addSubview(followingLabel)
        followingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            followingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            followingLabel.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func addBioLabel() {
        view.addSubview(bioLabel)
        bioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bioLabel.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 20)
        ])
    }
    
    private func loadImage() {
        guard let avatarURLString = user.avatar_url, let avatarURL = URL(string: avatarURLString) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: avatarURL), let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.avatarImageView.image = image
                    self?.overlayLoadingView?.stopLoading()
                    self?.overlayLoadingView?.removeFromSuperview()
                    self?.overlayLoadingView = nil
                }
            }
        }
    }
}
