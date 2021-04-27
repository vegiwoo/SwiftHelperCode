//  Bundle + Ext.swift
//  Created by Dmitry Samartcev on 27.04.2021.

import Foundation

public extension Bundle {
    static func appName() -> String {
        guard let dictionary = Bundle.main.infoDictionary else {
            return ""
        }
        if let version : String = dictionary["CFBundleName"] as? String {
            return version
        } else {
            return ""
        }
    }
}
