//
//  InitCoordinator.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import UIKit

public enum InitCoordinatorError: Error {
    case invalidNotificationManager
}

public final class InitCoordinator {

    public var nextCoordinator: Coordinator?
    public var currentViewController: UIViewController?
    public var presentingViewController: UINavigationController

    private lazy var initViewController: MainViewController = {
        //let viewModel = InitViewModel(coordinator: self)
        
        let initViewController = MainViewController()
        
        return initViewController
    }()

    public var mainCoordinator: MainCoordinatorProtocol?

    private var window: Window?

    public init(
        window: Window?,
        presentingViewController: UINavigationController = UINavigationController()
    ) {
        self.window = window
        self.presentingViewController = presentingViewController
        
    }

    private func startApp() {
        mainCoordinator?.start()
        nextCoordinator = mainCoordinator
    }
}

extension InitCoordinator: InitCoordinatorProtocol {
    public func start() {}
    

    public func start(animated: Bool) {
        window?.rootViewController = initViewController
        window?.makeKeyAndVisible()
        startApp()
    }

}
