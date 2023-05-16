//
//  UIView+Extensions.swift
//  Carrefour
//
//  Created by exactaworks on 16/05/23.
//

import Foundation
import UIKit

extension UIView {

    func constraint(_ closure: (UIView) -> [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(closure(self))
    }
}

extension UIView {

    func addSubviewWithBorders(subview: UIView,
                               top: CGFloat = 0,
                               bot: CGFloat = 0,
                               lead: CGFloat = 0,
                               trail: CGFloat = 0) {

        subview.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor, constant: top),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -bot),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: lead),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trail)]
        }
    }
}
