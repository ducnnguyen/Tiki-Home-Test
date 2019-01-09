//
//  String.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

extension String {
    func calculateWidth(with font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: 50)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
}
