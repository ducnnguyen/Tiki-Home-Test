//
//  File.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import Alamofire

func request(_ target: TargetType) -> DataRequest {
    var url = target.baseURL
    url.appendPathComponent(target.path)
    return Alamofire.request(url, method: target.method, parameters: target.parameters, encoding: target.encoding, headers: target.headers)
}
