//  ARProviderError.swift
//  Created by Dmitry Samartcev on 22.10.2021.

import Foundation

public enum ARProviderError: Error {
    case errorFindingURLforFile (fileName: String, fileExtension: String )
    case errorLoadingEntityFromFile(message: String)
    case noValidURLToLoadEntity
}

extension ARProviderError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .errorFindingURLforFile(fileName, fileExtension):
            return NSLocalizedString("Error finding URL for file with name '\(fileName)' and extension '\(fileExtension)'.",
                                     comment: "")
        case let .errorLoadingEntityFromFile(message):
            return NSLocalizedString("Loading Entity from file failed with error: \(message)",
                                     comment: "")
        case .noValidURLToLoadEntity:
            return NSLocalizedString("No valid URL to load Entity.",
                                     comment: "")
        }
    }
}
