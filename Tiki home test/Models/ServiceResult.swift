//
//  ServiceResult.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import Foundation

enum ServiceResult<T> {
    case success(T)
    case failure(error: ServiceError)
}
