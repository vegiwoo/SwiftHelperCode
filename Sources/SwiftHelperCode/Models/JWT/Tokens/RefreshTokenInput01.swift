//  RefreshTokenInput01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to send a request to server about need to update the access token (a string of  available refreshToken is sent in request body).
public struct RefreshTokenInput01: Codable {
    let refreshToken: String
    
    public init (refreshToken: String) {
        self.refreshToken = refreshToken
    }
}
