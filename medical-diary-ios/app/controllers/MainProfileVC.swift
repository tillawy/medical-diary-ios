//
//  MainProfileVC.swift
//  medical-diary-ios
//
//  Created by Mohammed Tillawy on 2/9/18.
//  Copyright © 2018 ArabiaWeather Inc. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift
import SwiftDate

class MainProfileVC: FormViewController {

    let realm = try! Realm()

    func appPatient() -> Patient {
        if let patient = realm.objects(Patient.self).first {
            return patient
        }
        let patient = Patient()
        try! realm.write {
            realm.add(patient)
        }
        return patient
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let patient = appPatient()

        form
        +++ Section("name".localized())
        
        <<< TextRow{ row in
            row.title = "first_name".localized()
            row.placeholder = "your_first_name".localized()
            row.value = patient.firstName
            row.onChange({ (textRow: TextRow) in
                try! self.realm.write {
                    guard let v = row.value else { return }
                    patient.firstName = v
                }
            })
        }
        
        <<< TextRow{ row in
            row.title = "father_name".localized()
            row.placeholder = "your_father_name".localized()
            row.value = patient.middleName
            row.onChange({ (textRow: TextRow) in
                try! self.realm.write {
                    guard let v = row.value else { return }
                    patient.middleName = v
                }
            })
        }
        
        <<< TextRow{ row in
            row.title = "family_name".localized()
            row.placeholder = "your_family_name".localized()
            row.value = patient.lastName
            row.onChange({ (textRow: TextRow) in
                try! self.realm.write {
                    guard let val = row.value else { return }
                    patient.lastName = val
                }
            })
        }

        +++ Section("Age")

        <<< IntRow { row in
            row.title = "age".localized()
            row.placeholder = "age".localized()
            row.value = patient.age
            row.tag = "age"
            row.onChange({ (textRow: IntRow) in
                guard let age = row.value else { return }
                try! self.realm.write {
                    patient.age = age
                }
                let birthRow : DateRow? = self.form.rowBy(tag: "birth_date")
                if let newBirthDate = DateInRegion(components: [.month: 1, .day: 1, .year: Date().year - age])?.absoluteDate {
                    birthRow?.value =  newBirthDate
                    birthRow?.updateCell()
                }
            })
        }
            
        <<< DateRow {
            $0.title = "birth_date".localized()
            if let birthDate = patient.birthDate {
                $0.value = birthDate
            }
            $0.tag = "birth_date"
            $0.onChange({ (dateRow: DateRow) in
                guard let birthDate = dateRow.value else { return }
                try! self.realm.write {
                    patient.birthDate = birthDate
                }
                let ageRow : IntRow? = self.form.rowBy(tag: "age")
                if let age = (Date() - birthDate).in(.year), age != ageRow?.value  {
                    ageRow?.value = age
                    ageRow?.updateCell()
                }
            })
        }

        +++ Section("Section2")

        <<< SwitchRow{ row in
            row.title = "organ_donnor".localized()
            row.value = patient.isOraganDonnor
            row.onChange({ (textRow: SwitchRow) in
                try! self.realm.write {
                    guard let v = row.value else { return }
                    patient.isOraganDonnor = v
                }
            })
        }
        
            /*
        +++ Section("Selectors Rows Examples")

            <<< ActionSheetRow<Option>() {
                $0.title = option.title
                $0.selectorTitle = option.title
                $0.displayValueFor = {(rowValue: Set<Selection>?) in
                    return rowValue?.map({ $0.title! }).sorted().joined(separator: ", ")
                }
        }*/
    

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
