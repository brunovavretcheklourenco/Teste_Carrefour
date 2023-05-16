//
//  AppDelegate+Launch.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import Foundation
import UIKit

extension AppDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        Thread.sleep(forTimeInterval: 2.0)
        let initApp = InitCoordinator(window: window!)
        initApp.start(animated: true)
    }
}

