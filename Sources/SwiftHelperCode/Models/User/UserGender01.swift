//  UserGender02.swift
//  Created by Dmitry Samartcev on 08.09.2020.

import Foundation

public protocol Option: RawRepresentable, Hashable, CaseIterable, Codable {}

/// Defines gender of user.
public enum UserGender01: String, Option {
    case male, female
}

public extension Set where Element == UserGender01 {
    static var male: Set<UserGender01> {
        return [.male]
    }

    static var female: Set<UserGender01> {
        return [.female]
    }

    static var all: UserGenders01 {
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

public extension UserGender01 {
    var description : String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        }
    }
}

public typealias UserGenders01  = Set<UserGender01>
