//
//  TikiAPI.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import Alamofire
import SwiftyJSON

public protocol TargetType {
    /// The target's base `URL`.
    var baseURL: URL { get }
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    /// The headers to be used in the request.
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
}

enum TikiAPI {
    case search
}

extension TikiAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://tiki-mobile.s3-ap-southeast-1.amazonaws.com/ios")!
    }

    var path: String {
        switch self {
        case .search:
            return "/keywords.json"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }

    var headers: [String : String]? {
        switch self {
        case .search:
            return nil
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .search:
            return [:]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .search:
            return JSONEncoding.default
        }
    }
}
