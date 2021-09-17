//  Numbers + Ext.swift
//  Created by Dmitry Samartcev on 17.09.2021.

import Foundation

public extension Float {
    /// For working with angle values. Converts degrees to radians.
    /// - Parameter degrees: Input value in degrees.
    /// - Returns: Output value in radians.
    static func degreesToRadians(degrees: Float) -> Float {
        return (degrees * .pi) / 180
    }
}
