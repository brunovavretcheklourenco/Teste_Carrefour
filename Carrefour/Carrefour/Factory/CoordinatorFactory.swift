//
//  CoordinatorFactory.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import Foundation
import UIKit

final class CoordinatorFactory {
    static func makeInitCoordinator(
        window: UIWindow,
        navigationController: UINavigationController
    ) -> InitCoordinator {
        return InitCoordinator(
            window: window,
            presentingViewController: navigationController
        )
    }
}
