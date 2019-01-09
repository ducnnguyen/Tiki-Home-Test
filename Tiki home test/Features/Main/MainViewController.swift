//
//  ViewController.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/8/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    let searchResultsController = SearchResultsController.instantiate()
    var searchController: UISearchController!

    var searchService: SearchService.Type = TikiAPI.self

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareSearchController()

        searchService.get { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let hotProducts):
                self.searchResultsController.hotProducts = hotProducts
            case .failure(let error):
                // TODO: handle error
                print(error.rawValue)
            }
        }
    }

    private func prepareSearchController() {
        searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Product name, branch..."
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.titleView = searchController.searchBar
        searchController.searchResultsUpdater = searchResultsController
        definesPresentationContext = true
    }
}

