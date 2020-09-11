//  UsersRights01.swift
//  Created by Dmitry Samartcev on 08.09.2020.

import Foundation

/// Defines role (rights) of user on service.
public enum UserRights01: String, Option {
    case user, admin, superadmin
}

public extension Set where Element == UserRights01 {
    static var user: Set<UserRights01> {
        return [.user]
    }

    static var admin: Set<UserRights01> {
        return [.admin]
    }
    
    static var superadmin: UsersRights01 {
        return [.superadmin]
    }

    static var all: Set<UserRights01> {
        return Set(Element.allCases)
    }
}

public extension UserRights01 {
    var description : String {
        switch self {
        case .user:
            return "user"
        case .admin:
            return "admin"
        case .superadmin:
            return "superadmin"
        }
    }
}

public typealias UsersRights01  = Set<UserRights01>

