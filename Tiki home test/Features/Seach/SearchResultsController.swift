//
//  SearchResultsController.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit
import RealmSwift
import SnapKit

class SearchResultsController: UIViewController {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentStackView: UIStackView!

    let hotKeywordsViewController = HotKeywordsViewController()
    let searchKeywordsViewControllers = SearchKeywordsViewControllers()
    
    var hotProducts: [HotProduct] = [] {
        didSet { hotKeywordsViewController.hotProducts = hotProducts }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(hotKeywordsViewController)
        contentStackView.addArrangedSubview(hotKeywordsViewController.view)
        hotKeywordsViewController.didMove(toParent: self)
        hotKeywordsViewController.view.snp.makeConstraints {
            $0.height.equalTo(209)
        }
        
        addChild(searchKeywordsViewControllers)
        contentStackView.addArrangedSubview(searchKeywordsViewControllers.view)
        searchKeywordsViewControllers.didMove(toParent: self)
        searchKeywordsViewControllers.collectionViewHeightConstraint.constant = 52

        // TODO: create keyboard manager or intergrate IQKeyboardManagerSwift
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func handleKeyboardWillShow(_ notification: Notification) {
        guard let userInfo = (notification as NSNotification).userInfo else { return }
        guard let keyboardbRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardbRect.height, right: 0)
    }

    @objc func handleKeyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        view.isHidden = false
    }
}

extension SearchResultsController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedString = searchBar.text else { return }
        searchBar.text = nil
        SearchedKeyword.create(with: searchedString)
    }
}
