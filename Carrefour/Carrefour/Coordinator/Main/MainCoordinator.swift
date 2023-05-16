//
//  MainCoordinator.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import Foundation
import UIKit

public protocol MainCoordinatorProtocol: Coordinator {
    func start()
}

public class MainCoordinator: MainCoordinatorProtocol {

    public var nextCoordinator: Coordinator?
    public var currentViewController: UIViewController?
    public var presentingViewController: UINavigationController

    let homeCoordinator: HomeCoordinatorProtocol

    public init(
        presentingViewController: UINavigationController,
        homeCoordinator: HomeCoordinatorProtocol
    ) {
        self.presentingViewController = presentingViewController
        self.homeCoordinator = homeCoordinator
    }

    public func start(animated: Bool) {
        startAppCommonFlow()
    }

    public func start() {
        startAppFlow()
    }

    public func startAppCommonFlow() {}

    func startAppFlow() {
        DispatchQueue.main.async {
            self.startAppCommonFlow()
        }
    }

    func startLogin() {
        homeCoordinator.showHome()
      //  nextCoordinator = loginCoordinator
    }
}
