//  RefreshTokenResponse01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to respond to server's request to update the access token (new access token and refresh token data are sent in response body).
public struct RefreshTokenResponse01: Codable {
    let accessToken: String
    let refreshToken: String
}
