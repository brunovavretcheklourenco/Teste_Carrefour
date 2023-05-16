//
//  AppDelegate.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import Foundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = {
        return UIWindow()
    }()
    lazy var rootNavigationController: UINavigationController = {
        return UINavigationController()
    }()
    
    // MARK: - Coordinators
    lazy var initCoordinator: InitCoordinator = {
        CoordinatorFactory.makeInitCoordinator(
            window: window!,
            navigationController: rootNavigationController
        )
    }()
}

