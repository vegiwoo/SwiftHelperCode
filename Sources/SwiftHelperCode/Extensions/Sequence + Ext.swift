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
}

/*
 Exaple
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
