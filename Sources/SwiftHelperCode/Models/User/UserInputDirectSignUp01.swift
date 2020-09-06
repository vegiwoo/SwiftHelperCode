//  UserInputDirectSignUp01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to sign up a new user on service.
public struct UserInputDirectSignUp01: Codable {
    public let username, email, password : String
    public let firstname, lastname: String?
    public let gender: UserGender01?
    public let dob : Date?

    public init(username: String, firstname: String? = nil, lastname: String? = nil,
         email: String, password: String, gender: UserGender01? = nil, dob: Date? = nil) {
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.gender = gender
        self.dob = dob
    }
}
