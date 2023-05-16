//
//  UIKit+UIWindow.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import UIKit

public protocol Window {
    var rootViewController: UIViewController? { get set }
    func makeKeyAndVisible()
}

extension UIWindow: Window { }
