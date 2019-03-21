//
//  UITableView.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

extension UITableView {
    func applyChanges(deletions: [Int], insertions: [Int], updates: [Int]) {
        performBatchUpdates({
            deleteRows(at: deletions.map(IndexPath.from), with: .automatic)
            insertRows(at: insertions.map(IndexPath.from), with: .automatic)
            reloadRows(at: updates.map(IndexPath.from), with: .automatic)
        })
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        guard let dequeuedView = dequeueReusableHeaderFooterView(withIdentifier: T.className) as? T else {
            fatalError("need to set identifier or register your reusable header footer view")
        }
        return dequeuedView
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let dequeuedCell = self.dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("need to set identifier or register your cell")
        }
        return dequeuedCell
    }

    func registerFromNib(forCellClass cellClass: UITableViewCell.Type) {
        register(UINib(nibName: cellClass.className, bundle: nil), forCellReuseIdentifier: cellClass.className)
    }

    func registerFromNib(forHeaderFooterViewClass headerFooterViewClass: UITableViewHeaderFooterView.Type) {
        register(UINib(nibName: headerFooterViewClass.className, bundle: nil), forHeaderFooterViewReuseIdentifier: headerFooterViewClass.className)
    }
}
