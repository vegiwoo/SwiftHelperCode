//  UserInputDirectSignUp01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to sign up a new user on service.
public struct UserInputDirectSignUp01: Codable {
    var username, email, password : String
    var firstname, lastname: String?    
    var gender: UserGender01?
    var dob : Date?

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
