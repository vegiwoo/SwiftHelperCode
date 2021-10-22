//  ARProviderImpliment + ARsession.swift
//  Created by Dmitry Samartcev on 22.10.2021.

#if canImport(ARKit)
import Foundation
import ARKit

/// - Work with ARSession.
@available (iOS 14.0, *)
extension ARProviderImpliment {
    public func append(arSessionDelegate: ARSessionDelegate) {
        self.arSesionDelegate = arSessionDelegate
        self.arSession.delegate = self.arSesionDelegate
    }
}
#endif
