//  ThreeDModelCategoryInput01.swift
//  Created by Dmitry Samartcev on 11.09.2020.

import Foundation

/// Used as entity of 3D model category in a publish (update) request.
public struct ThreeDModelCategoryInput01: Codable {
    
    public let modelCategoryName: String
    
    public init(modelCategoryName: String) {
        self.modelCategoryName = modelCategoryName
    }
}
