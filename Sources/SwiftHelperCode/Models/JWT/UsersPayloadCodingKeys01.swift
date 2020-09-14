//  UsersPayloadCodingKeys.swift
//  Created by Dmitry Samartcev on 14.09.2020.

import Foundation

public enum UsersPayloadCodingKeys01: String, CodingKey {
    case subject        = "sub"
    case expiration     = "exp"
    case userid         = "userid"
    case username       = "username"
    case userRights     = "userRights"
    case userStatus     = "userStatus"
}

public enum MicroservicesPayloadCodingKeys01: String, CodingKey {
    case subject        = "sub"
    case expiration     = "exp"
}
