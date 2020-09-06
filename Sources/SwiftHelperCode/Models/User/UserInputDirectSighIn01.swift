//  UserInputDirectSighIn01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to sign in a registered user to service.
public struct UserInputDirectSighIn01 : Codable {
    public let username: String
    public let password: String
    
    public init (username: String, password: String) {
        self.username = username
        self.password = password
    }
}
