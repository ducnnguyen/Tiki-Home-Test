//
//  UIInitable.swift
//  Extension
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Nguyen Van Cuong. All rights reserved.
//

import UIKit

protocol UIInitable {
    static func instantiate() -> Self
}

extension UIView: UIInitable {}
extension UIInitable where Self: UIView {
    static func instantiate() -> Self {
        guard Bundle.main.path(forResource: className, ofType: "nib") != nil else { return self.init() }
        return Bundle.main.loadNibNamed(className, owner: nil)?.first as? Self ?? self.init()
    }
}


extension UIViewController: UIInitable {}
extension UIInitable where Self: UIViewController {
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: className, bundle: nil)
        let instantiatedVC = storyboard.instantiateInitialViewController() ?? storyboard.instantiateViewController(withIdentifier: className)
        return instantiatedVC as? Self ?? self.init()
    }
}

