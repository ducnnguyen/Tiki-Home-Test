//
//  SearchedKeyword.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import RealmSwift

@objcMembers final class SearchedKeyword: Object, RealmCrudable {

    static var realm = RealmManager.plainRealm
    static func create(with text: String) {
        do {
            let cearchedKeyword = SearchedKeyword(text: text)
            try realm.write { realm.add(cearchedKeyword, update: true) }
        } catch let error {
            print(error.localizedDescription)
        }
    }

    dynamic var text = ""
    dynamic var createdDate = Date.distantPast

    convenience init(text: String) {
        self.init()
        self.text = text
        self.createdDate = Date()
    }

    enum Property: String {
        case text, createdDate
    }

    override static func primaryKey() -> String? {
        return Property.text.rawValue
    }
}
