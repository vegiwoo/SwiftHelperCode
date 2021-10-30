//  ARProviderImpliment + ARsession.swift
//  Created by Dmitry Samartcev on 22.10.2021.

#if canImport(ARKit)
import Foundation
import ARKit

/// - Work with ARSession.
@available (iOS 14.0, *)
extension ARProviderImpliment {
    
    public func reconfigureSession(planeDetectionMode: PlaneDetection?, runOptions: ARSession.RunOptions?, debugOptions: DebugOptions?) {
        
        if planeDetectionMode != nil || runOptions != nil {
            self.pauseSession()
            
            // Set PlaneDetection mode.
            if let planeDetectionMode = planeDetectionMode {
                self.planeDetectionMode = planeDetectionMode
                self.arSessionConfiguration.planeDetection = self.planeDetectionMode
            }
            // Re-run with runOptions.
            self.arSession.run(self.arSessionConfiguration, options: runOptions ?? [])
        }
        
        // Set Debug options.
        if let debugOptions = debugOptions {
            self.debugOptions = debugOptions
        }
    }
    
    public func pauseSession() {
        self.arSession.pause()
    }
}
#endif
