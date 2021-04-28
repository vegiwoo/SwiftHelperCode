//  Connectible.swift
//  Created by Dmitry Samartcev on 25.04.2021.

import Foundation

/// Defines the container view to be *connectible* in context of implementing Redux architecture.
public protocol Connectible {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    associatedtype ViewModel
}

public extension Connectible where Self: Equatable & Identifiable {
    var id: UUID {UUID()}
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}

