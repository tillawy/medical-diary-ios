//
//  Doctor.swift
//  medical-diary-ios
//
//  Created by Mohammed Tillawy on 5/25/18.
//  Copyright © 2018 ArabiaWeather Inc. All rights reserved.
//

import RealmSwift

class Doctor: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var name : String = ""
    @objc dynamic var phone : String = ""

    static func all(in realm: Realm = try! Realm()) -> Results<Doctor> {
        return realm.objects(Doctor.self)
            .sorted(byKeyPath: "name")
    }

    @discardableResult
    static func add(name: String, phone: String , in realm: Realm = try! Realm()) -> Doctor {
        let doc = Doctor()
        doc.name = name
        doc.phone = phone
        try! realm.write {
            realm.add(doc)
        }
        return doc
    }

    func delete() {
        try! Realm().write {
            realm?.delete(self)
        }
    }
}
