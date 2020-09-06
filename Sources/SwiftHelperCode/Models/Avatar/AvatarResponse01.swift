//  AvatarResponse01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to respond to a server request for an existing avatar.
public struct AvatarResponse01 : Codable {
    let id         : Int
    let directLink : String
    let createAt   : Date?
    let updateAt   : Date?
    let deleteAt   : Date?
}
