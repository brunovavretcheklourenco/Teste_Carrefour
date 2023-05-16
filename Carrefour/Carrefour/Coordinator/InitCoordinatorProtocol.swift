//
//  InitCoordinatorProtocol.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

public protocol InitCoordinatorProtocol: Coordinator {
    var mainCoordinator: MainCoordinatorProtocol? { get set }

    func start(animated: Bool)
    func start()
}
