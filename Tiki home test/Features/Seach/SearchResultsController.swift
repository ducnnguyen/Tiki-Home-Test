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
    private var realmNotificationToken: NotificationToken?
    var searchedKeywordResults = SearchedKeyword.retrieve().filter("FALSEPREDICATE")

    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(hotKeywordsViewController)
        contentStackView.addArrangedSubview(hotKeywordsViewController.view)
        hotKeywordsViewController.didMove(toParent: self)
        hotKeywordsViewController.view.snp.makeConstraints {
            $0.height.equalTo(209)
        }
        
//        addChild(searchKeywordsViewControllers)
//        contentStackView.addArrangedSubview(searchKeywordsViewControllers.view)
//        searchKeywordsViewControllers.didMove(toParent: self)
//        searchKeywordsViewControllers.view.snp.makeConstraints {
//            $0.height.equalTo(209)
//        }

        prepareHotProductCollectionView()
        observeSearchedKeywordsOnRealm()

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

    private func observeSearchedKeywordsOnRealm() {
        searchedKeywordResults = SearchedKeyword.retrieve()
            .sorted(byKeyPath: SearchedKeyword.Property.createdDate.rawValue, ascending: false)
//        realmNotificationToken = searchedKeywordResults.observe { [weak tableView] changes in
//            guard let tableView = tableView else { return }
//            switch changes {
//            case .initial:
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let updates):
//                    tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
//            case .error: break
//            }
//        }
    }

    private func prepareHotProductCollectionView() {
        
    }
}

extension SearchResultsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedKeywordResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as SearchedKeywordSearchResultTableViewCell
        cell.keywordLabel.text = searchedKeywordResults[indexPath.row].text
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView() as SearchedKeywordSearchResultTableHeaderView
        headerView.deleteButton.removeTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        headerView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return headerView
    }

    @objc func deleteButtonTapped() {
        SearchedKeyword.deleteAll()
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
