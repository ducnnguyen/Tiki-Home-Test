//
//  HotProduct.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import SwiftyJSON

class HotProduct {
    let keyword: String
    let iconURLString: String

    init?(_ json: JSON) {
        guard let keyword = json["keyword"].string,
            let iconURLString = json["icon"].string else {
            return nil
        }
        self.keyword = keyword
        self.iconURLString = iconURLString
    }
}
