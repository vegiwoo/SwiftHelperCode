//  ServerResponseAbort.swift
//  Created by Dmitry Samartcev on 16.09.2020.

import Foundation

public struct ServerResponseAbort : Codable, Error {
    public let error   : Bool
    public let reason  : String
    
    public init(error: Bool, reason: String) {
        self.error = error
        self.reason = reason
    }
}
