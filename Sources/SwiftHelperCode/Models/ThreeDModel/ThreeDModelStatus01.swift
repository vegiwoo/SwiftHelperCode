//  ThreeDModelStatus01.swift
//  Created by Dmitry Samartcev on 11.09.2020.

import Foundation

/// Defines status of 3D model in service.
public enum ThreeDModelStatus01: String, Option {
    case published, blocked, archived
}

public extension Set where Element == ThreeDModelStatus01 {
    static var published: Set<ThreeDModelStatus01> {
        return [.published]
    }

    static var blocked: Set<ThreeDModelStatus01> {
        return [.blocked]
    }
    
    static var archived: Set<ThreeDModelStatus01> {
        return [.archived]
    }

    static var all: ThreeDModelsStatus01 {
        return Set(Element.allCases)
    }
}

public extension ThreeDModelStatus01 {
    var description : String {
        switch self {
        case .published:
            return "published"
        case .blocked:
            return "blocked"
        case .archived:
            return "archived"
        }
    }
}

public typealias ThreeDModelsStatus01  = Set<ThreeDModelStatus01>
