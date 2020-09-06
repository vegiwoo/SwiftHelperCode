//  AddressResponse01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to respond to a server request for an existing address.
public struct AddressResponse01 : Codable {
    let address  : String
    let city     : String
    let region   : String
    let country  : String
    let zip      : String
    let createAt : Date?
    let updateAt : Date?
    let deleteAt : Date?
    
    public init (address: String, city: String,region: String, country: String, zip: String, createAt: Date? = nil, updateAt: Date? = nil, deleteAt: Date? = nil) {
        self.address  = address
        self.city     = city
        self.region   = region
        self.country  = country
        self.zip      = zip
        self.createAt = createAt
        self.updateAt = updateAt
        self.deleteAt = deleteAt
        
        
    }
}
