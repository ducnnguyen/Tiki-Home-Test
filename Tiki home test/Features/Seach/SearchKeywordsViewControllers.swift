//
//  SearchKeywordsViewControllers.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit
import RealmSwift

class SearchKeywordsViewControllers: TikiGridViewController {
    
    private var realmNotificationToken: NotificationToken?
    var searchedKeywordResults = SearchedKeyword.retrieve().filter("FALSEPREDICATE")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = "Searched Keywords"
        observeSearchedKeywordsOnRealm()
    }
    
    private func observeSearchedKeywordsOnRealm() {
        searchedKeywordResults = SearchedKeyword.retrieve()
            .sorted(byKeyPath: SearchedKeyword.Property.createdDate.rawValue, ascending: false)
        realmNotificationToken = searchedKeywordResults.observe { [weak collectionView] changes in
            guard let collectionView = collectionView else { return }
            collectionView.reloadData()
            collectionView.setContentOffset(.zero, animated: true)
        }
    }
}

extension SearchKeywordsViewControllers: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedKeywordResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TikiGridCollectionViewCell
        cell.searchedKeyword = searchedKeywordResults[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 60 is the longest word in vietnamese
        let textWidth = searchedKeywordResults[indexPath.row].text.calculateWidth(with: .systemFont(ofSize: 14)) / 2 + 60
        return CGSize(width: textWidth < 112 ? 112 : textWidth, height: collectionViewHeightConstraint.constant)
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = tableView.dequeueReusableHeaderFooterView() as SearchedKeywordSearchResultTableHeaderView
//        headerView.deleteButton.removeTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
//        headerView.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
//        return headerView
//    }
}
