//
//  RealmCrudable.swift
//  Tiki home test
//
//  Created by Cuong Nguyen on 1/9/19.
//  Copyright © 2019 Cuong Nguyen. All rights reserved.
//

import RealmSwift

protocol RealmCrudable where Self: Object {
    static var realm: Realm { get }
    //create func
    func delete()
    static func deleteAll()
    static func retrieve() -> Results<Self>
    //update func
}

extension RealmCrudable {
    func delete() {
        do { try realm?.write { realm?.delete(self) }
        } catch let error {
            print(error.localizedDescription)
        }
    }

    static func deleteAll() {
        retrieve().forEach { $0.delete() }
    }

    static func retrieve() -> Results<Self> {
        return realm.objects(Self.self)
    }
}

