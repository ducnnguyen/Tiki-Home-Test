//
//  UICollectionView.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        guard let dequeuedCell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("need to set identifier or register your cell")
        }
        return dequeuedCell
    }

    func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind elementKind: String, for indexPath: IndexPath) -> T {
        guard let dequeuedView = dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("need to set identifier or register your reusable supplementary view")
        }
        return dequeuedView
    }
    
    func registerFromNib(forCellClass cellClass: UICollectionViewCell.Type) {
        let nib = UINib(nibName: cellClass.className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellClass.className)
    }
}
