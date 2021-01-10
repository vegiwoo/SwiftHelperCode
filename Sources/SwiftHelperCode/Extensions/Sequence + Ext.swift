//
//  File.swift
//  
//
//  Created by Dmitry Samartcev on 14.12.2020.
//

import Foundation

/// Description of sort descriptor (in relation to `NSSortDescriptor`)
///
/// ComparisonResult - objc type, used here directly
public struct SortDescriptor<Value> {
    public var comparator: (Value, Value) -> ComparisonResult
}

public extension SortDescriptor {
    static func keyPath<T:Comparable>(_ keyPath: KeyPath<Value, T>) -> Self {
        Self {rootA, rootB in
            let valueA = rootA[keyPath: keyPath]
            let valueB = rootB[keyPath: keyPath]
            
            guard valueA != valueB else {
                return .orderedSame
            }
            
            return valueA < valueB ? .orderedAscending : .orderedDescending
        }
    }
}

/// Description of sort order
public enum SortOrder {
    case ascending, descending
}

public extension Sequence {
    func sorted(using descriptors: [SortDescriptor<Element>], order: SortOrder) -> [Element] {
        sorted{ valueA, valueB in
            for descriptor in descriptors {
                let result = descriptor.comparator(valueA, valueB)
                
                switch result {
                case .orderedAscending:
                    return order == .ascending
                case .orderedSame:
                    // Keep iterating if the two elements are equal,
                    // since that'll let the next descriptor determine
                    // the sort order:
                    break
                case .orderedDescending:
                    return order == .descending
                }
            }
            
            // If no descriptor was able to determine the sort
            // order, we'll default to false (similar to when
            // using the '<' operator with the built-in API):
            return false
        }
    }
    
    /// A convenience API on top of another convenience API
    func sorted(using descriptors: SortDescriptor<Element>...) -> [Element] {
        sorted(using: descriptors, order: .ascending)
    }
    
    /*
     Example
    struct Article {
        var category : String
        var title : String
    }

    let article1 = Article(category: "People", title: "Artice about people")
    let article2 = Article(category: "Animals", title: "These cute pandas")
    let article3 = Article(category: "People", title: "Machine robots among us")
    let article4 = Article(category: "Animals", title: "In the north-west of St. Petersburg, a boa constrictor swallowed a car")

    func sortArticlesByCategory(_ articles: [Article]) -> [Article] {
        articles.sorted(using: .keyPath(\.category), .keyPath(\.title))
    }

    let sortArticles = sortArticlesByCategory([article3, article4, article2, article1])
    print(sortArticles)
     */
    
    /// Method uses a binary search for index of target element in the search set.
    ///
    /// Executed in logarithmic time `O (log n)`.
    /// A sorted set must be passed to function.
    /// - Parameters:
    ///   - arr: Set to search for.
    ///   - target: Target value for search.
    /// - Returns: Returns index of target element in set, or nil if there is no such element in  set.
    func binarySearch<T: Comparable>(arr : [T], target: T) -> Int? {
        // Range stores upper and lower bounds (indices) of set
        var range = 0..<arr.count
        // Until condition is reduced to one element ...
        while range.lowerBound < range.upperBound {
            // ... check middle element of set
            let mid = range.lowerBound + (range.upperBound - range.lowerBound) / 2
            // If the value is found, return it
            if arr[mid] == target {
                return mid
            }
            // If value is less than target, search range is shifted forward from  middle element of  set + 1 element to  upper bound
            if arr[mid] < target {
                range = mid + 1..<range.upperBound
            }
            // If  value is greater than target, search range is shifted back - from the bottom to the middle
            else {
                range = range.lowerBound..<mid
            }
        }
        return nil
    }
    
    /*
     Example:
     - The array to search for:
     var numbers = [23, 5, 17, 29, 11, 13, 3, 19, 2, 7]
     - Element for searching in an array:
     let targetValue = 29
     - Method work:
     if let index = binarySearch(arr: numbers.sorted(), target: targetValue) {
         print("Number index \(targetValue) - \(index).")
     } else {
         print("Number \(targetValue) is not in the desired set.")
     }
     */
}


