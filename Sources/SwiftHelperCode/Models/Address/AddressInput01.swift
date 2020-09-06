//  AddressInput01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to send data to server when publishing a address.
public struct AddressInput01 : Codable {
    public let address : String
    public let city    : String
    public let region  : String
    public let country : String
    public let zip     : String
    
    public init (address: String, city: String,region: String,country: String, zip: String) {
        self.address = address
        self.city    = city
        self.region  = region
        self.country = country
        self.zip     = zip
    }
}
