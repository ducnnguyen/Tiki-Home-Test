//
//  RealmManager.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import RealmSwift

class RealmManager {
    static var plainRealm: Realm {
        return try! Realm()
    }
}
