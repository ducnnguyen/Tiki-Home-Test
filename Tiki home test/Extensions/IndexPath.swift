//
//  IndexPath.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

extension IndexPath {
    static func from(_ row: Int) -> IndexPath {
        return IndexPath(row: row, section: 0)
    }
}
