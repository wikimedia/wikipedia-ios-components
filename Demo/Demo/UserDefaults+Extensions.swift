//
//  UserDefaults+Extensions.swift
//  Demo
//
//  Created by Toni Sevener on 4/28/23.
//

import Foundation

let WKThemeNameKey = "WKThemeNameKey"

extension UserDefaults {
    @objc var themeName: String? {
        get {
            return string(forKey: WKThemeNameKey)
        }
        set {
            set(newValue, forKey: WKThemeNameKey)
        }
    }

}
