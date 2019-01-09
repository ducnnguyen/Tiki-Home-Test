//
//  SearchService.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import SwiftyJSON

typealias SearchServiceResult = ServiceResult<[HotProduct]>

protocol SearchService {
    static func get(completionHandler: @escaping (SearchServiceResult) -> ())
}

extension TikiAPI: SearchService {
    static func get(completionHandler: @escaping (SearchServiceResult) -> ()) {
        request(search).responseJSON { response in
            switch response.result {
            case .success(let jsonData):
                let json = JSON(jsonData)
                let hotProductJSONs = json["keywords"].arrayValue
                guard hotProductJSONs.count > 0 else {
                    return completionHandler(.failure(error: .unexpectedResponse))
                }
                let hotProducts = hotProductJSONs.compactMap(HotProduct.init)
                guard hotProducts.count > 0 else {
                    return completionHandler(.failure(error: .parseJSON))
                }
                completionHandler(.success(hotProducts))
            case .failure:
                return completionHandler(.failure(error: .alamofire))
            }
        }
    }
}

