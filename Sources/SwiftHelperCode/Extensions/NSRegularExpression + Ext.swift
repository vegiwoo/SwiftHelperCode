
//  NSRegularExpression + Ext.swift
//  Created by Dmitry Samartcev on 04.08.2020.

import Foundation

public extension NSRegularExpression {
    /// Initializes a regular expression from a string pattern
    /// - Parameter pattern: String pattern for the regular expression.
    convenience init(_ pattern: String) throws {
        do {
            try self.init(pattern: pattern)
        } catch {
            throw SHCErrors.RegexError.notPossibleCreateRegexFromGivenPattern(pattern: pattern)
        }
        
        /*
         init() throws {
                 do {
                     text = try String(contentsOfFile: "/Users/me/file.txt", encoding: NSUTF8StringEncoding ) }
                 catch let error as NSError {
                     throw error
                 }
             }
         
         */
        
    }
    
    /// Checks a string against a regular expression.
    /// - Parameter string: Input string to check.
    /// - Returns:  Result of check as a boolean flag.
    func matches(_ string: String) -> Bool {
        let range = NSRange(location: 0, length: string.utf16.count)
        return firstMatch(in: string, options: [], range: range) != nil
    }
}
