//  UserGender02.swift
//  Created by Dmitry Samartcev on 08.09.2020.

import Foundation

public protocol Option: RawRepresentable, Hashable, CaseIterable {}

public typealias UserGenders02  = Set<UserGender02>

public enum UserGender02: String, Option {
    case male, female
}

public extension Set where Element == UserGender02 {
    static var male: Set<UserGender02> {
        return [.male]
    }

    static var female: Set<UserGender02> {
        return [.female]
    }

    static var all: Set<UserGender02> {
        return Set(Element.allCases)
    }
}

public extension Set where Element: Option {
    var rawValue: Int {
        var rawValue = 0
        for (index, element) in Element.allCases.enumerated() {
            if self.contains(element) {
                rawValue |= (1 << index)
            }
        }
        return rawValue
    }
}
