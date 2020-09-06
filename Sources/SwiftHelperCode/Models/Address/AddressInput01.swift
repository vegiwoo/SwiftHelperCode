//  AddressInput01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to send data to server when publishing a address.
public struct AddressInput01 : Codable {
    let address : String
    let city    : String
    let region  : String
    let country : String
    let zip     : String
}
