//  UserGender.swift
//  Created by Dmitry Samartcev on 06.09.2020.\

import Foundation

/// Determines gender of user on service.
public struct UserGender01 : OptionSet, Codable, CustomStringConvertible, Hashable {
    
    public let rawValue: Int64
    
    public init(rawValue: Int64) {
        self.rawValue = rawValue
    }
    
    public init(from decoder: Decoder) throws {
      rawValue = try .init(from: decoder)
    }
    
    public func encode(to encoder: Encoder) throws {
      try rawValue.encode(to: encoder)
    }
    
    static let male   = Self(rawValue: 1 << 0)
    static let female = Self(rawValue: 1 << 1)

    public var description: String {
        var vals = [String]()

        if self.contains(.male) {
            vals.append("male")
        }
        if self.contains(.female) {
            vals.append("female")
        }
        
        return vals.joined(separator: ",")
    }
}
