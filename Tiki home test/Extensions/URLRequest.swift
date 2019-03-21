//
//  URLRequest.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

extension URLRequest {
    init?(urlString: String?) {
        guard let url = URL(string: urlString) else { return nil }
        self.init(url: url)
    }
}
