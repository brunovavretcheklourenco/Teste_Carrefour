//
//  ViewProtocol.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import Foundation

protocol ViewCodeProtocol {

    func setupHierarchy()
    func setupConstraints()
    func additionalSetup()
    func buildView()
}

extension ViewCodeProtocol {

    func buildView() {
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }

    func setupConstraints() { }
    func additionalSetup() { }
}
