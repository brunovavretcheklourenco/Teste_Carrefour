//
//  Coordinator.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import UIKit
import Foundation

public protocol Coordinator: AnyObject {
    var nextCoordinator: Coordinator? { get set }
    var currentViewController: UIViewController? { get }
    func start()
    func start(animated: Bool)
}

extension Coordinator {

    public func start() {
        start(animated: true)
    }

}
