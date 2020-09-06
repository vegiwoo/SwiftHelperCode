//  UserResponse01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to respond to a server request for an existing user.
public struct UserResponse: Codable {
    public let id        : Int?
    public let username  : String?
    public let firstname : String?
    public let lastname  : String?
    public let gender    : UserGender01?
    public let dob       : Date?
    public let age       : Int?
    public let email     : String
    public let avatars   : [AvatarResponse01]?
    public let addresses : [AddressResponse01]?
    public let createAt  : Date?
    public let updateAt  : Date?
    public let deleteAt  : Date?
    
    public init (id: Int? = nil, username: String? = nil, firstname: String? = nil, lastname: String? = nil, gender: UserGender01? = nil, dob: Date? = nil, age: Int? = nil, email: String, avatars: [AvatarResponse01]? = nil, addresses : [AddressResponse01]? = nil, createAt: Date? = nil, updateAt: Date? = nil, deleteAt: Date? = nil){
        self.id = id
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.gender = gender
        self.dob = dob
        self.age = age
        self.email = email
        self.avatars = avatars
        self.addresses = addresses
        self.createAt = createAt
        self.updateAt = updateAt
        self.deleteAt = deleteAt
    }
}
