import Foundation
import UIKit

public protocol MainCoordinatorProtocol: Coordinator {
    func start()
}

public class MainCoordinator: MainCoordinatorProtocol {
    public func start(animated: Bool) {
        
    }
    
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
    
    public func start() {
        startAppFlow()
    }
    
    private func startAppFlow() {
        DispatchQueue.main.async {
            self.startAppCommonFlow()
        }
    }
    
    private func startAppCommonFlow() {
        homeCoordinator.showHome()
    }
}
