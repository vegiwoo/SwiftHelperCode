//  RandomAccessCollection + Ext.swift
//  Created by Dmitry Samartcev on 23.04.2021.

import Foundation

@available (macOS 10.15, *)
public extension RandomAccessCollection where Self.Element: Identifiable {
    func isLast(_ item: Element) -> Bool {
        guard isEmpty == false else {
            return false
        }
        guard let itemIndex = lastIndex(where: {AnyHashable($0.id) == AnyHashable(item.id) }) else {
            return false
        }
        return distance(from: itemIndex, to: endIndex) == 1
    }
}
