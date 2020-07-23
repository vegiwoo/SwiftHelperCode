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
        }
    }
}

