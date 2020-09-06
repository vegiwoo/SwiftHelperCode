//  AvatarInput01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to send data to server when publishing a user's avatar.
public struct AvatarInput01 : Codable {
    let avatarInputData: Data
}
