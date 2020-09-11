//  ThreeDModelResponse01 + Ext.swift
//  Created by Dmitry Samartcev on 11.09.2020.

import Foundation

public struct ThreeDModelResponse01 : Codable {
    public let id:                   Int?
    public let modelName:            String
    public let modelLink:            String
    public let modelCoverLink:       String
    public let modelIsPublic:        Bool
    public let modelsBytesCount:     Double
    public let modelComposite:       Bool
    public let modelPositionOrder:   ThreeDModelPositionOrder01
    public let modelStatus:          ThreeDModelStatus01
    public let modelUserId:          Int
    public let modelCategoryId:      Int
    public let modelCreatedAt:       Date
    public let modelUpdateAt:        Date
    public let modelDeleteAt:        Date?
    
    public init (id: Int? = nil, modelName: String, modelLink: String, modelCoverLink: String, modelIsPublic: Bool, modelsBytesCount: Double, modelComposite: Bool, modelPositionOrder:   ThreeDModelPositionOrder01, modelStatus: ThreeDModelStatus01, modelUserId: Int, modelCategoryId: Int, modelCreatedAt: Date, modelUpdateAt: Date, modelDeleteAt:        Date? = nil) {
        
        self.id                 = id
        self.modelName          = modelName
        self.modelLink          = modelLink
        self.modelCoverLink     = modelCoverLink
        self.modelIsPublic      = modelIsPublic
        self.modelsBytesCount   = modelsBytesCount
        self.modelComposite     = modelComposite
        self.modelPositionOrder = modelPositionOrder
        self.modelStatus        = modelStatus
        self.modelUserId        = modelUserId
        self.modelCategoryId    = modelCategoryId
        self.modelCreatedAt     = modelCreatedAt
        self.modelUpdateAt      = modelUpdateAt
        self.modelDeleteAt      = modelDeleteAt
    }
}
