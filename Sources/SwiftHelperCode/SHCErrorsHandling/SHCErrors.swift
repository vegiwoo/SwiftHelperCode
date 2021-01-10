//  SHCErrors.swift
//  Created by Dmitry Samartcev on 23.07.2020.

import Foundation

/// Handles possible errors when implementing the package.
public class SHCErrors {
    enum ApplicationInformerError : Error {
        case unableDetermineVersionOrBuildOfApplication
    }
    
    enum DeviceInformerError : Error {
        case unableToCalculateDiskSpace
        case requestIsAvailableOnlyForDevicesSupportingIOS
    }
    
    enum RegexError : Error {
        case notPossibleCreateRegexFromGivenPattern(pattern: String)
    }
}

extension SHCErrors.ApplicationInformerError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unableDetermineVersionOrBuildOfApplication:
            return "Unable to determine the version and (or) build of current application."
        }
    }
}

extension SHCErrors.DeviceInformerError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .unableToCalculateDiskSpace:
            return "Unable to determine the disk space status of current device."
        case .requestIsAvailableOnlyForDevicesSupportingIOS:
            return "The request is available only for devices supporting IOS."
        }
    }
}

extension SHCErrors.RegexError : LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notPossibleCreateRegexFromGivenPattern(pattern: let pattern):
            return "It is not possible to create a regex from given pattern '\(pattern)'. Check correct operation on playground."
        }
    }
}

