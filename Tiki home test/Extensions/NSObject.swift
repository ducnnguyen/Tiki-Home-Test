//
//  NSObject.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }

    var className: String {
        return String(describing: type(of: self))
    }
}
