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
import RealmSwift

class MainProfileVC: FormViewController {

    let realm = try! Realm()
    
    func appPatient() -> Patient {
        if let patient = realm.objects(Patient.self).first {
            return patient
        }
        let p = Patient()
        try! realm.write {
            realm.add(p)
        }
        return p
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let patient = appPatient()
        
        form +++ Section("name".localized())
            
            <<< TextRow(){ row in
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
            
            <<< TextRow(){ row in
                row.title = "father_name".localized()
                row.placeholder = "your_father_name".localized()
                row.value = patient.fatherName
                row.onChange({ (textRow: TextRow) in
                    try! self.realm.write {
                        guard let v = row.value else { return }
                        patient.fatherName = v
                    }
                })
            }
            
            <<< TextRow(){ row in
                row.title = "family_name".localized()
                row.placeholder = "your_family_name".localized()
                row.value = patient.familyName
                row.onChange({ (textRow: TextRow) in
                    try! self.realm.write {
                        guard let v = row.value else { return }
                        patient.familyName = v
                    }
                })
            }

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
