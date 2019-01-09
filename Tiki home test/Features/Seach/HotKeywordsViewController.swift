//
//  HotKeywordsViewController.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

class HotKeywordsViewController: TikiGridViewController {
    var hotProducts: [HotProduct] = [] {
        didSet {
            loadViewIfNeeded()
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = "Hot Keywords"
    }
}

extension HotKeywordsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TikiGridCollectionViewCell
        cell.hotProduct = hotProducts[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TikiGridCollectionViewCell
        cell.hotProduct = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 60 is the longest word in vietnamese
        let textWidth = hotProducts[indexPath.row].keyword.calculateWidth(with: .systemFont(ofSize: 14)) / 2 + 60
        return CGSize(width: textWidth < 112 ? 112 : textWidth, height: 156)
    }
}
