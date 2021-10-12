//  MultipeerSessionError.swift
//  Created by Dmitry Samartcev on 12.10.2021.

import Foundation

public enum MultipeerSessionError: Error {
    case noPeersToSendData
    case errorSendingDataToPeers(String)
    case errorSendingOrreceiveStream
    case errorSendingOrreceiveResources
}

extension MultipeerSessionError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noPeersToSendData:
            return NSLocalizedString(
                "􀙇 No peers to send data.",
                comment: "No other peers are connected to this session."
            )
        case let .errorSendingDataToPeers(message):
            return NSLocalizedString(
                "􀙇 Error sending data to peers \(message).",
                comment: "Error sending data."
            )
        case .errorSendingOrreceiveStream:
            return NSLocalizedString(
                "􀙇 Error sending receive stream.",
                comment: "This service does not send / receive streams."
            )
        case .errorSendingOrreceiveResources:
            return NSLocalizedString(
                "􀙇 Error sending receive resource.",
                comment: "This service does not send / receive resources."
            )
        }
    }
}
