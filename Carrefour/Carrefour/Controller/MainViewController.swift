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
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() {
        self.view.backgroundColor = .white
    }
    
    func setupHierarchy() {
        self.view.addSubview(imageBackground)
        self.view.addSubview(viewBackgroundHolder)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //imageBackground
            imageBackground.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imageBackground.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            //viewBackgroundHolder
            viewBackgroundHolder.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200),
            viewBackgroundHolder.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            viewBackgroundHolder.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            viewBackgroundHolder.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0),
            viewBackgroundHolder.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            viewBackgroundHolder.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
            
        ])
    }
    
    lazy var imageBackground: UIImageView = {
        let imageView = UIImageView.init(image: UIImage(named: "mercado"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var viewBackgroundHolder: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.6
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    
    
}

