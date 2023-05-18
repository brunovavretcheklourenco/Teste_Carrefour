//
//  HomeViewController.swift
//  Carrefour
//
//  Created by exactaworks on 17/05/23.
//

import Foundation
import UIKit

class UserListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Busca"
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private var overlayLoadingView: OverlayLoadingView?
    private var isSearchBarExpanded = false
    
    private var users: [User] = []
    private var allUsers: [User] = []
    
    private let viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel = UserListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getAllUsers()
    }
    
    private func setupUI() {
        setupSearchBar()
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = .default
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        navigationItem.titleView = searchBar
    }
    
    private func showLoadingOverlay() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            guard self.overlayLoadingView == nil else { return }
            
            self.overlayLoadingView = OverlayLoadingView(loadingText: "Loading...")
            self.view.addSubview(self.overlayLoadingView!)
            self.overlayLoadingView?.startLoading()
            
            self.overlayLoadingView?.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                self.overlayLoadingView!.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.overlayLoadingView!.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.overlayLoadingView!.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.overlayLoadingView!.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        }
    }
    
    private func hideLoadingOverlay() {
        DispatchQueue.main.async { [weak self] in
            self?.overlayLoadingView?.stopLoading()
            self?.overlayLoadingView?.removeFromSuperview()
            self?.overlayLoadingView = nil
        }
    }
    
    private func getAllUsers() {
        showLoadingOverlay()
        
        viewModel.getUsers { [weak self] users, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error: \(error)")
                    self?.hideLoadingOverlay()
                }
            } else if let users = users {
                DispatchQueue.main.async {
                    self?.users = users
                    self?.allUsers = users
                    self?.tableView.reloadData()
                    self?.hideLoadingOverlay()
                }
            }
        }
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let user = users[indexPath.row]
        cell.textLabel?.text = user.login
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedUser = users[indexPath.row]
        showUserDetails(selectedUser)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func showUserDetails(_ user: User) {
        viewModel.getUserDetails(for: user) { [weak self] userDetails, error in
            if let userDetails = userDetails {
                DispatchQueue.main.async {
                    let apiManager = GitHubAPI()
                    let viewModel = UserDetailsViewModel(user: userDetails)
                    let userDetailsViewController = UserDetailsViewController(viewModel: viewModel, apiManager: apiManager)
                    self?.navigationController?.pushViewController(userDetailsViewController, animated: true)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    
}

extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(with: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = nil
        performSearch(with: nil)
    }
    
    private func performSearch(with searchText: String?) {
        if let searchText = searchText, !searchText.isEmpty {
            users = allUsers.filter { $0.login?.range(of: searchText, options: .caseInsensitive) != nil }
        } else {
            users = allUsers
        }
        
        tableView.reloadData()
    }
}
