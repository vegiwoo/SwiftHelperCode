//  UserUpdateInput01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to send a request to server to update user data.
public struct UserUpdateInput01: Codable {
    var firstname, lastname, email, password, dob : String?
    var gender: UserGender01?
    let address: AddressInput01?
    
    public init (firstname: String? = nil , lastname: String? = nil, email: String? = nil , password: String? = nil, dob: String? = nil,  gender: UserGender01? = nil, address: AddressInput01? = nil) {
        
        self.firstname = firstname
        self.lastname  = lastname
        self.email     = email
        self.password  = password
        self.dob       = dob
        self.gender    = gender
        self.address   = address
    }
}
