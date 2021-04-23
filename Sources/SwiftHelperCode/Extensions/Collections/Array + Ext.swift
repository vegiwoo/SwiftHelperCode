//  Array + Ext.swift
//  Created by Dmitry Samartcev on 23.02.2021.

import Foundation

public extension Array where Element: Comparable  {
    /// Determines if array is sorted.
    /// - Parameter isOrderedBefore: The order of the checked sort.
    /// - Returns: Check flag.
    func isSorted(isOrderedBefore: (Element, Element) -> Bool) -> Bool {
        for i in 1..<self.count {
            if !isOrderedBefore(self[i-1], self[i]) {
                return false
            }
        }
        return true
    }
}
