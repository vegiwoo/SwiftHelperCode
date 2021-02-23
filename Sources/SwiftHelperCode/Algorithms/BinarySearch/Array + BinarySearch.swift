//  Array + BinarySearch.swift
//  Created by Dmitry Samartcev on 23.02.2021.

import Foundation

public extension Array where Element: Comparable  {
    /// Implements a binary search for a given element in an array
    ///
    /// Refers to search algorithms
    /// Executed in logarithmic time `O (log2 n)`.
    /// ```swift
    ///     //Example:
    ///     let target = 10
    ///     do {
    ///         if let index = try [15,10,14,17,13,18,9,16,12,11].sorted().binarySearch(target: target) {
    ///             print("Index of value \(target) - \(index)")
    ///         } else {
    ///             print("Value \(target) not found in array")
    ///         }
    ///     } catch {
    ///         print((error as NSError).userInfo)
    ///     }
    /// ```
    /// - Parameter target: Specified element to search for
    /// - Throws: When passing an unsorted array, function will throw an exception
    /// - Returns: The index of the element found, or nil
    func binarySearch(target: Element) throws -> Int? {

        guard self.isSorted(isOrderedBefore: <) else {
            throw NSError(domain: "Array extension", code: 0, userInfo: ["Error" : "Passed array is not sorted"])
        }

        var range = 0..<self.count

        while range.lowerBound < range.upperBound {

            let middle = range.lowerBound + (range.upperBound - range.lowerBound) / 2
            
            if self[middle] == target {
                return middle
            }

            if self[middle] < target {
                range = middle + 1..<range.upperBound
            }
            else {
                range = range.lowerBound..<middle
            }
        }
        return nil
    }

}
