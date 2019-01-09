//
//  HotProductSearchResultCollectionViewCell.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class HotProductSearchResultCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productLabel: UILabel!

    let hotProductColors: [UIColor] = [UIColor(hex: 0x16702e), UIColor(hex: 0x005a51), UIColor(hex: 0x996c00), UIColor(hex: 0x5c0a6b), UIColor(hex: 0x006d90), UIColor(hex: 0x974e06), UIColor(hex: 0x99272e), UIColor(hex: 0x89221f), UIColor(hex: 0x00345d)]
    let downloader = ImageDownloader()
    var requestReceipt: RequestReceipt?
    let placeHolderImage = #imageLiteral(resourceName: "place holder")
    var indexPath: IndexPath! {
        didSet {
            productLabel.backgroundColor = hotProductColors[indexPath.row % hotProductColors.count]
        }
    }

    var hotProduct: HotProduct? {
        didSet {
            guard let hotProduct = hotProduct else {
                downloader.cancelRequest(with: requestReceipt)
                productLabel.text = nil
                productImageView.image = placeHolderImage
                return
            }
            productLabel.text = hotProduct.keyword
            requestReceipt = downloader.download(withUrlString: hotProduct.iconURLString) { [weak self] response in
                guard let self = self else { return }
                self.productImageView.image = response.result.value
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        productLabel.textColor = .white
        productLabel.layer.cornerRadius = 4
        productLabel.clipsToBounds = true
        productImageView.image = placeHolderImage
    }
}
