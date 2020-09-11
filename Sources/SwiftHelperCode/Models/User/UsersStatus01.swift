//  UsersStatus01.swift
//  Created by Dmitry Samartcev on 08.09.2020.

import Foundation

/// Defines user's status on service.
public enum UserStatus01: String, Option {
    case created, confirmed, blocked, archived
}

public extension Set where Element == UserStatus01 {
    static var created: Set<UserStatus01> {
        return [.created]
    }

    static var confirmed: Set<UserStatus01> {
        return [.confirmed]
    }
    
    static var blocked: Set<UserStatus01> {
        return [.blocked]
    }
    
    static var archived: Set<UserStatus01> {
        return [.archived]
    }
    
    static var all: UsersStatus01 {
        return Set(Element.allCases)
    }
}

public extension UserStatus01 {
    var description : String {
        switch self {
        case .created:
            return "created"
        case .confirmed:
            return "confirmed"
        case .blocked:
            return "blocked"
        case .archived:
            return "archived"
        }
    }
}

public typealias UsersStatus01  = Set<UserStatus01>
