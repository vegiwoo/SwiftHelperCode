//  AWSCredentials.swift
//  Created by Dmitry Samartcev on 24.08.2020.

import Foundation

/// An auxiliary structure for uniform formation of AWS credentials across different services.
public struct AWSCredentials  {
    public let awsAccessKeyID : String
    public let awsSecretAccessKey: String
}
