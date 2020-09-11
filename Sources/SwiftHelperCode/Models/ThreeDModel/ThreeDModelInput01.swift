//  ThreeDModelInput01.swift
//  Created by Dmitry Samartcev on 11.09.2020.

import Foundation

/// Used as entity of 3D model in a publish request.
public struct ThreeDModelInput : Codable {
    public let modelName       : String
    public let modelData       : Data
    public let coverData       : Data
    public let isPublic        : Bool
    public let modelComposite  : Bool
    public let positionOrder   : ThreeDModelPositionOrder01
    public let categoryName    : String
    public let userId          : Int
    
    public init (modelName: String, modelData: Data, coverData: Data, isPublic: Bool, modelComposite: Bool, positionOrder: ThreeDModelPositionOrder01, categoryName: String, userId: Int) {
        self.modelName      = modelName
        self.modelData      = modelData
        self.coverData      = coverData
        self.isPublic       = isPublic
        self.modelComposite = modelComposite
        self.positionOrder  = positionOrder
        self.categoryName   = categoryName
        self.userId         = userId
    }
}
