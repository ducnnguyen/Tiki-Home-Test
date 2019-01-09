//
//  ServiceError.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

enum ServiceError: String, Error {
    case alamofire
    case invalidToken
    case network
    case parseJSON
    case unexpectedResponse
}
