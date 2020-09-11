//  ThreeDModelUpdateInput01.swift
//  Created by Dmitry Samartcev on 11.09.2020.

import Foundation

/// Used as the entity of 3D model in update request.
public struct ThreeDModelUpdateInput01 : Codable {
    public var modelName           : String?
    public var modelIsPublic       : Bool?
    public var modelComposite      : Bool?
    public var modelPositionOrder  : ThreeDModelPositionOrder01?
    public var modelStatus         : ThreeDModelStatus01?
    public var modelCategory       : String?
    
    public init (modelName: String? = nil, modelIsPublic: Bool? = nil, modelComposite: Bool? = nil, modelPositionOrder:ThreeDModelPositionOrder01? = nil, modelStatus: ThreeDModelStatus01? = nil, modelCategory: String? = nil) {
        
        self.modelName          = modelName
        self.modelIsPublic      = modelIsPublic
        self.modelComposite     = modelComposite
        self.modelPositionOrder = modelPositionOrder
        self.modelStatus        = modelStatus
        self.modelCategory      = modelCategory
    }
}
