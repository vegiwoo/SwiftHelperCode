//  ThreeDModelPositionOrder01.swift
//  Created by Dmitry Samartcev on 11.09.2020.

import Foundation

/// Determines order in which 3D model is placed on plane.
public enum ThreeDModelPositionOrder01: String, Option {
    /// It doesn't matter - model can "hover" in space (for example, a copter model).
    case noMatter
    /// On any (horizontal or vertical) plane.
    case onAnyPlane
    /// Only on a horizontal plane (for example, a train model).
    case onHorizontalPlane
    /// Only on a vertical plane (for example, a model of a wall lamp).
    case onVerticalPlane
}

public extension Set where Element == ThreeDModelPositionOrder01 {
    static var noMatter: Set<ThreeDModelPositionOrder01> {
        return [.noMatter]
    }

    static var onAnyPlane: Set<ThreeDModelPositionOrder01> {
        return [.onAnyPlane]
    }
    
    static var onHorizontalPlane: Set<ThreeDModelPositionOrder01> {
        return [.onHorizontalPlane]
    }
    
    static var onVerticalPlane: Set<ThreeDModelPositionOrder01> {
        return [.onVerticalPlane]
    }

    static var all: ThreeDModelPositionOrders01 {
        return Set(Element.allCases)
    }
}

public extension ThreeDModelPositionOrder01 {
    var description : String {
        switch self {
        case .noMatter:
            return "noMatter"
        case .onAnyPlane:
            return "onAnyPlane"
        case .onHorizontalPlane:
            return "onHorizontalPlane"
        case .onVerticalPlane:
            return "onVerticalPlane"
        }
    }
}

public typealias ThreeDModelPositionOrders01  = Set<ThreeDModelPositionOrder01>
