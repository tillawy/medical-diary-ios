//
//  HomeVC.swift
//  medical-diary-ios
//
//  Created by Mohammed Tillawy on 5/19/18.
//  Copyright © 2018 ArabiaWeather Inc. All rights reserved.
//

import Eureka

class HomeVC: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form
            +++ Section {
                $0.header = HeaderFooterView<EurekaLogoView>(.class)
            }
           +++ Section("References".localized())
            <<< ButtonRow("Doctors".localized()) {
                $0.title = $0.tag
                $0.presentationMode = .segueName(segueName: "DoctorsTVCSegue", onDismiss: nil)
        }
            <<< ButtonRow("Family".localized()) {
                $0.title = $0.tag
                $0.presentationMode = .segueName(segueName: "FamilyVCSegue", onDismiss: nil)
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

class EurekaLogoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView(image: UIImage(named: "Logo"))
        imageView.frame = CGRect(x: 0, y: 0, width: 160, height: 65)
        imageView.autoresizingMask = .flexibleWidth
        self.frame = CGRect(x: 0, y: 0, width: 320, height: 130)
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
