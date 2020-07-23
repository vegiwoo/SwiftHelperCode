//
//  ApplicationInformer.swift
//  Created by Dmitry Samartcev on 23.07.2020.
//

import Foundation

/// Provides information about the application.
public struct AppInformer {
    
    public init() {}
    
    /// Determines the current version number and the current app build number.
    /// - Throws: Error of type ApplicationInformerError.
    /// - Returns: Version and build information tuple.
    public func appVersionAndBuild () throws -> (appVersion: String, appBuild: String) {
        
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
           let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return (appVersion, appBuild)
        } else {
            throw SHCErrors.ApplicationInformerError.unableDetermineVersionOrBuildOfApplication
        }
    }

}

