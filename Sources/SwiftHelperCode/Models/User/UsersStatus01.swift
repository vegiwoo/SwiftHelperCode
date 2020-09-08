//  UsersStatus01.swift
//  Created by Dmitry Samartcev on 08.09.2020.

import Foundation

public typealias UsersStatus01  = Set<UserStatus01>

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
