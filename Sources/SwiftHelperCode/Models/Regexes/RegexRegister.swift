//  RegexRegister.swift
//  Created by Dmitry Samartcev on 07.09.2020.

import Foundation

/// Represents entity of regular expression as value accepted by query to register with DB.
public struct RegexRegister : Codable {
    public var regexname    : String
    public var description  : String
    public var regexString  : String
    public var rule         : String
    
    public init (regexname: String, description: String, regexString: String, rule: String) {
        self.regexname      = regexname
        self.description    = description
        self.regexString    = regexString
        self.rule           = rule
    }
}
