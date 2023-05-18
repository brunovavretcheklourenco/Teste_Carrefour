//
//  ViewController.swift
//  Carrefour
//
//  Created by exactaworks on 15/05/23.
//

import UIKit

class MainViewController: UIViewController, ViewCodeProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "Login"
    }
    
    func buildView() {
        view.backgroundColor = .white
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {
        setupUserListButton()
        setupCadastroButton()
    }
    
    func setupUserListButton() {
        let userListButton = makeButton(title: "Entrar")
        userListButton.addTarget(self, action: #selector(goToUserList), for: .touchUpInside)
        view.addSubview(userListButton)
        
        NSLayoutConstraint.activate([
            userListButton.centerXAnchor.constraint(equalTo: viewBackgroundHolder.centerXAnchor),
            userListButton.centerYAnchor.constraint(equalTo: viewBackgroundHolder.centerYAnchor, constant: -30),
            userListButton.widthAnchor.constraint(equalToConstant: 200),
            userListButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupCadastroButton() {
        let cadastroButton = makeButton(title: "Cadastro")
        cadastroButton.addTarget(self, action: #selector(showCadastroAlert), for: .touchUpInside)
        view.addSubview(cadastroButton)
        
        NSLayoutConstraint.activate([
            cadastroButton.centerXAnchor.constraint(equalTo: viewBackgroundHolder.centerXAnchor),
            cadastroButton.centerYAnchor.constraint(equalTo: viewBackgroundHolder.centerYAnchor, constant: 30),
            cadastroButton.widthAnchor.constraint(equalToConstant: 200),
            cadastroButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func makeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }
    
    @objc func showCadastroAlert() {
        let alertController = UIAlertController(title: "Cadastro", message: "Possível fluxo de cadastro", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func goToUserList() {
        DispatchQueue.global().async {
            let userListVC = UserListViewController()
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(userListVC, animated: true)
            }
        }
    }
    
    func setupHierarchy() {
        view.addSubview(imageBackground)
        view.addSubview(viewBackgroundHolder)
        addCarrefourLogo()
    }
    
    func addCarrefourLogo() {
        let carrefourImageView = UIImageView(image: UIImage(named: "carrefour"))
        carrefourImageView.translatesAutoresizingMaskIntoConstraints = false
        carrefourImageView.contentMode = .scaleAspectFit
        view.addSubview(carrefourImageView)
        
        NSLayoutConstraint.activate([
            carrefourImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carrefourImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            carrefourImageView.widthAnchor.constraint(equalToConstant: 300),
            carrefourImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // imageBackground
            imageBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageBackground.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            // viewBackgroundHolder
            viewBackgroundHolder.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 500),
            viewBackgroundHolder.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            viewBackgroundHolder.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            viewBackgroundHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewBackgroundHolder.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    lazy var imageBackground: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "mercado"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var viewBackgroundHolder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.6
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
}
