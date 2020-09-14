//  UsersPayloadCodingKeys.swift
//  Created by Dmitry Samartcev on 14.09.2020.

import Foundation

enum UsersPayloadCodingKeys: String, CodingKey {
    case subject        = "sub"
    case expiration     = "exp"
    case userid         = "userid"
    case username       = "username"
    case userRights     = "userRights"
    case userStatus     = "userStatus"
}

enum MicroservicesPayloadCodingKeys: String, CodingKey {
    case subject        = "sub"
    case expiration     = "exp"
}
