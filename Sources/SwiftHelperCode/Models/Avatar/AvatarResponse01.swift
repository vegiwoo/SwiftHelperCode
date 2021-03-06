//  AvatarResponse01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to respond to a server request for an existing avatar.
public struct AvatarResponse01 : Codable {
    public let id         : Int
    public let directLink : String
    public let createAt   : Date?
    public let updateAt   : Date?
    public let deleteAt   : Date?
    
    public init (id: Int, directLink: String, createAt: Date? = nil, updateAt: Date? = nil, deleteAt: Date? = nil) {
        self.id         = id
        self.directLink = directLink
        self.createAt   = createAt
        self.updateAt   = updateAt
        self.deleteAt   = deleteAt
    }
}
