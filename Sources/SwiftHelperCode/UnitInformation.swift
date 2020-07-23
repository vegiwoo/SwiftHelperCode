//
//  UnitInformation.swift
//  Created by Dmitry Samartcev on 23.07.2020.
//

import Foundation

/// Unit of information.
enum UnitInformation: Int8, CaseIterable {
    case byte
    case kbyte
    case mbyte
    case gbyte
}
