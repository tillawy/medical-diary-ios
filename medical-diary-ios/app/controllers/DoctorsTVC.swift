//
//  DoctorsVC.swift
//  medical-diary-ios
//
//  Created by Mohammed Tillawy on 5/25/18.
//  Copyright © 2018 ArabiaWeather Inc. All rights reserved.
//
// https://github.com/xmartlabs/Eureka/issues/1494 , section from array

import UIKit
import RealmSwift

class DoctorsTVC: UITableViewController {
    private var itemsToken: NotificationToken?

    override func viewWillAppear(_ animated: Bool) {
       itemsToken = Doctor.all()._observe { changes  in
        switch changes {
        case .initial:
            debugPrint("initial change")
        case .update(_,  _,  _,  _):
            self.tableView.reloadData()
        case .error(_):
            debugPrint("error")
        }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "doctors".localized()
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func callDoctor(doc: Doctor) {
        let alert = UIAlertController(title: "Call Doctor: \(doc.name)", message: "\(doc.phone)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Call", style: .default, handler: { (_) in
            guard let url = URL(string: doc.phone) else { return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)

    }

    func addDoctorAlert() {
        let alert = UIAlertController(title: "Doctor", message: "adf", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.keyboardType = .default
            textField.placeholder = "Doctor name"
        }
        alert.addTextField { (textField) in
            textField.keyboardType = .phonePad
            textField.placeholder = "Doctor Number"
        }
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (_) in
            guard let name = alert.textFields?[0].text else { return }
            guard let phone = alert.textFields?[1].text else { return }
            Doctor.add(name: name, phone: phone)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return Doctor.all().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddDoctorReuseID", for: indexPath)
            return cell
        }
       let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorReuseID", for: indexPath)
        let doc = Doctor.all()[indexPath.row]
        cell.textLabel?.text = doc.name
        cell.detailTextLabel?.text = doc.phone
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            addDoctorAlert()
        }
        if indexPath.section == 1 {
            let doc = Doctor.all()[indexPath.row]
            callDoctor(doc: doc)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 1
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let doc = Doctor.all()[ indexPath.row ]
            doc.delete()
        }
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
