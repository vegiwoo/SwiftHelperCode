//  RegexResponse.swift
//  Created by Dmitry Samartcev on 07.09.2020.

import Foundation

/// Represents entity of regular expression as value returned from response.
public struct RegexResponse : Codable {
    public var id               : Int
    public var regexName        : String
    public var regexDescription : String
    public var regexString      : String
    public var regexRule        : String
    public var regexCreateAt    : Date?
    public var regexUpdateAt    : Date?
    public var regexDeleteAt    : Date?
    
    public init(id: Int, regexName: String, regexDescription: String, regexString: String, regexRule: String, regexCreateAt: Date? = nil, regexUpdateAt: Date? = nil, regexDeleteAt: Date? = nil) {
        self.id                 = id
        self.regexName          = regexName
        self.regexDescription   = regexDescription
        self.regexString        = regexString
        self.regexRule          = regexRule
        self.regexCreateAt      = regexCreateAt
        self.regexUpdateAt      = regexUpdateAt
        self.regexDeleteAt      = regexDeleteAt
    }
}


