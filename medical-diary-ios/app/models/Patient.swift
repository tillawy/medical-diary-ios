//
//  Patient.swift
//  medical-diary-ios
//
//  Created by Mohammed Tillawy on 2/24/18.
//  Copyright © 2018 ArabiaWeather Inc. All rights reserved.
//

import RealmSwift

class Patient: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var firstName : String = ""
    @objc dynamic var middleName : String = ""
    @objc dynamic var lastName : String = ""
    @objc dynamic var birthDate : Date?
    @objc dynamic var age : Int = 0
    @objc dynamic var isOraganDonnor : Bool = false
}
