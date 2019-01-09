//
//  TikiGridViewController.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

class TikiGridViewController: UIViewController {

    @IBOutlet var deleteAllButton: UIButton!
    @IBOutlet var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: TikiGridViewController.className, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        collectionView.registerFromNib(forCellClass: TikiGridCollectionViewCell.self)
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumLineSpacing = 8
    }
    
    @IBAction func deleteAllButtonTapped() {
        SearchedKeyword.deleteAll()
    }
}
