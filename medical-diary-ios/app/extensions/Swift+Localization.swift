//
//  Swift+Localization.swift
//  medical-diary-ios
//
//  Created by Mohammed Tillawy on 2/25/18.
//  Copyright © 2018 ArabiaWeather Inc. All rights reserved.
//
/* source:
 https://medium.com/@marcosantadev/app-localization-tips-with-swift-4e9b2d9672c9
 */

import Foundation

extension String {
    
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
}
