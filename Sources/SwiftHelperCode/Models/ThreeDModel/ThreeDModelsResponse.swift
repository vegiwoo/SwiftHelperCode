//  ThreeDModelsResponse.swift
//  Created by Dmitry Samartcev on 27.04.2021.

import Foundation

public struct ThreeDModelsResponse: Codable {
    public var page: Int
    public var models: [ThreeDModelResponse01]
    public var totalNumbeOfResults: Int
}
