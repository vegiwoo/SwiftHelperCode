//  AddressResponse01.swift
//  Created by Dmitry Samartcev on 06.09.2020.

import Foundation

/// Used to respond to a server request for an existing address.
public struct AddressResponse01 : Codable {
    let address  : String?
    let city     : String?
    let region   : String
    let country  : String
    let zip      : String
    let createAt : Date?
    let updateAt : Date?
    let deleteAt : Date?
}
