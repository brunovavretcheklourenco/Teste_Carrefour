//
//  OverlaySpinning.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
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
        activityIndicator.startAnimating()
        isHidden = false
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        isHidden = true
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
        activityIndicator.constraint { view in
            [view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
             view.centerYAnchor.constraint(equalTo: self.centerYAnchor)]
        }

        loadingLabel.constraint { view in
            [view.centerXAnchor.constraint(equalTo: self.centerXAnchor),
             view.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 16)]
        }
    }

    func additionalSetup() {
        isHidden = true
        backgroundColor = .clear
    }
}

