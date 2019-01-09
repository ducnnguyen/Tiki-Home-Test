//
//  ImageDownloader.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import AlamofireImage
import Alamofire

extension ImageDownloader {
    func download(withUrlString urlString: String?, completion: CompletionHandler?) -> RequestReceipt? {
        guard let urlRequest = URLRequest(urlString: urlString) else { return nil }
        return download(urlRequest, completion: completion)
    }

    func cancelRequest(with requestReceipt: RequestReceipt?) {
        guard let requestReceipt = requestReceipt else { return }
        cancelRequest(with: requestReceipt)
    }
}
