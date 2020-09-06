//  UserResponse01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to respond to a server request for an existing user.
public struct UserResponse: Codable {
    let id        : Int?
    let username  : String?
    let firstname : String?
    let lastname  : String?
    let gender    : UserGender01?
    let dob       : Date?
    let age       : Int?
    let email     : String
    let avatars   : [AvatarResponse01]
    let addresses : [AddressResponse01]?
    let createAt  : Date?
    let updateAt  : Date?
    let deleteAt  : Date?
}
