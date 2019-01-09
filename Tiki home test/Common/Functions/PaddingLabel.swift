//
//  PaddingLabel.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    var insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 9) {
        didSet {
            super.invalidateIntrinsicContentSize()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
    }

    override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += insets.left + insets.right
        size.height += insets.top + insets.bottom
        return size
    }

    override open func drawText(in rect: CGRect) {
        return super.drawText(in: rect.inset(by: insets))
    }
}
