//
//  URL.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

extension URL {
    init?(string: String?) {
        guard let string = string else {
            return nil
        }
        self.init(string: string)
    }
}
