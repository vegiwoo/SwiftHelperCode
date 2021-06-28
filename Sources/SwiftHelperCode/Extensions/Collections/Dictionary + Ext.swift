//  Dictionary + Ext.swift
//  Created by Dmitry Samartcev on 10.06.2021.

import Foundation

public extension Dictionary {
    static func += <K, V> (left: inout [K:V], right: [K:V]) {
        for (k, v) in right {
            left[k] = v
        }
    }
}
