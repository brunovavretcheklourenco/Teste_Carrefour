//
//  UserDetailsViewController.swift
//  Carrefour
//
//  Created by exactaworks on 17/05/23.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController {
    
    private var viewModel: UserDetailsViewModel
    private var repositories: [Repository] = []
    private let apiManager: GitHubAPIProtocol
    
    private var overlayLoadingView: OverlayLoadingView?
    private var tableView: UITableView!
    
    init(viewModel: UserDetailsViewModel, apiManager: GitHubAPIProtocol) {
        self.viewModel = viewModel
        self.apiManager = apiManager
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
        setupNavigationBar()
        setupUI()
        loadImage()
        loadRepositories()
    }
    
    private func setupNavigationBar() {
        self.title = "Perfil"
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        addAvatarImageView()
        addOverlayLoadingView()
        addNameLabel()
        addFollowersLabel()
        addFollowingLabel()
        addBioLabel()
        addRepositoriesLabel()
        addTableView()
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
        nameText.append(NSAttributedString(string: "\(viewModel.nameText )"))

        label.attributedText = nameText
        
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        let followersText = NSMutableAttributedString(string: "Followers: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        
        let followersCount = viewModel.followers
        let followersCountText = NSAttributedString(string: "\(followersCount)", attributes: [.font: UIFont.systemFont(ofSize: 16)])
        
        followersText.append(followersCountText)
        label.attributedText = followersText
        
        return label
    }()


    
    private lazy var followingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        let followingText = NSMutableAttributedString(string: "Following: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        followingText.append(NSAttributedString(string: "\(viewModel.following)"))
        label.attributedText = followingText
        
        return label
    }()
    
    private lazy var bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        
        let bioText = NSMutableAttributedString(string: "Bio: ", attributes: [.font: UIFont.boldSystemFont(ofSize: 16)])
        let bio = viewModel.bioText
        label.attributedText = bio
        
        return label
    }()
    
    private lazy var repositoriesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Repositórios"
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
    
    private func addRepositoriesLabel() {
        view.addSubview(repositoriesLabel)
        repositoriesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            repositoriesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repositoriesLabel.topAnchor.constraint(equalTo: bioLabel.bottomAnchor, constant: 80)
        ])
    }
    
    private func addTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: repositoriesLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadImage() {
        guard let avatarURLString = viewModel.avatar, let avatarURL = URL(string: avatarURLString) else { return }
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
    
    private func loadRepositories() {
        if let username = viewModel.login {
            apiManager.getUserRepositories(username: username) { [weak self] repositories, error in
                if let repositories = repositories {
                    DispatchQueue.main.async {
                        if repositories.isEmpty {
                            self?.repositories = []
                            self?.tableView.reloadData()
                        } else {
                            self?.repositories = repositories
                            self?.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
                        }
                    }
                } else if let error = error {
                    print("Error loading repositories: \(error)")
                }
            }
        } else {
            print("No username available.")
        }
    }
}

extension UserDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.isEmpty ? 1 : repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if repositories.isEmpty {
            let emptyCell = UITableViewCell(style: .default, reuseIdentifier: nil)
            emptyCell.textLabel?.text = "Não há repositórios"
            return emptyCell
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            
            let repository = repositories[indexPath.row]
            cell.textLabel?.text = repository.name
            cell.detailTextLabel?.text = repository.language
            cell.detailTextLabel?.textColor = .gray
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
