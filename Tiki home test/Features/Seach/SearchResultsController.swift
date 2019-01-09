//
//  SearchResultsController.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit
import RealmSwift

class SearchResultsController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var collectionView: UICollectionView!
    
    var hotProducts: [HotProduct] = [] {
        didSet {
            guard hotProducts.count > 0 else {
                return tableView.tableHeaderView = nil
            }
            loadViewIfNeeded()
            collectionView.reloadData()
        }
    }
    private var realmNotificationToken: NotificationToken?
    var searchedKeywordResults = SearchedKeyword.retrieve().filter("FALSEPREDICATE")

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareHotProductCollectionView()
        prepareTableView()
        observeSearchedKeywordsOnRealm()
    }

    func observeSearchedKeywordsOnRealm() {
        searchedKeywordResults = SearchedKeyword.retrieve()
            .sorted(byKeyPath: SearchedKeyword.Property.createdDate.rawValue, ascending: false)
        realmNotificationToken = searchedKeywordResults.observe { [weak tableView] changes in
            guard let tableView = tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, let deletions, let insertions, let updates):
                    tableView.applyChanges(deletions: deletions, insertions: insertions, updates: updates)
            case .error: break
            }
        }
    }

    private func prepareHotProductCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        guard let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        flowLayout.minimumLineSpacing = 8
        flowLayout.itemSize = CGSize(width: 112, height: 165)
    }

    private func prepareTableView() {
        tableView.registerFromNib(forHeaderFooterViewClass: SearchedKeywordSearchResultTableHeaderView.self)
        tableView.sectionHeaderHeight = 64
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
    }
}

extension SearchResultsController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotProducts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as HotProductSearchResultCollectionViewCell
        cell.hotProduct = hotProducts[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as HotProductSearchResultCollectionViewCell
        cell.hotProduct = nil
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
