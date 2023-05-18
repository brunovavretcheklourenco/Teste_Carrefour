//
//  OverlaySpinning.swift
//  Carrefour
//

import Foundation
import UIKit

class OverlayLoadingView: UIView {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .systemBlue
        view.hidesWhenStopped = false
        return view
    }()
    
    private lazy var loadingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "Arial", size: 16)
        label.textColor = .black
        return label
    }()
    
    init(loadingText: String) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.text = loadingText
        buildView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.isHidden = false
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.isHidden = true
        }
    }
    
    func isLoading() -> Bool {
        return activityIndicator.isAnimating
    }
}

extension OverlayLoadingView: ViewCodeProtocol {
    func setupHierarchy() {
        addSubview(activityIndicator)
        addSubview(loadingLabel)
    }
    
    func setupConstraints() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            loadingLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16)
        ])
    }
    
    func additionalSetup() {
        isHidden = true
        backgroundColor = .clear
    }
    
    func buildView() {
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }
}
