//  UserWithTokensResponse01.swift
//  Created by Dmitry Samartcev on 14.09.2020.

import Foundation

public struct UserWithTokensResponse01 : Codable {
    public let tokens : RefreshTokenResponse01
    public let user   : UserResponse01
    
    public init (tokens: RefreshTokenResponse01, user: UserResponse01) {
        self.tokens = tokens
        self.user   = user
    }
}
