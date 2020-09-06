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
    let avatars   : [AvatarResponse01]?
    let addresses : [AddressResponse01]?
    let createAt  : Date?
    let updateAt  : Date?
    let deleteAt  : Date?
    
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
