//  ARProviderImpliment.swift
//  Created by Dmitry Samartcev on 30.10.2021.

#if canImport(Combine) && canImport(ARKit) && canImport(RealityKit)
import Foundation
import ARKit
import class RealityKit.ARView
import Combine

/// Class for working with ARKit.ARSession.
///
/// - Implements ARProvider protocol.
@available (iOS 14.0, *)
public final class ARProviderImpliment: NSObject, ARProvider {
    

    // MARK: - Variables and constants.
    public var arSessionConfiguration: ARWorldTrackingConfiguration {
        willSet {
            newValue.isCollaborationEnabled = true
            newValue.isLightEstimationEnabled = true
            newValue.environmentTexturing = .automatic
            
            if isPeopleOcclusion, ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
                newValue.frameSemantics.insert(.personSegmentationWithDepth)
            }
            
            if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
                newValue.sceneReconstruction = .mesh
            }
            
            newValue.planeDetection = planeDetectionMode
        }
    }
    public var isPeopleOcclusion: Bool = false
    public let arSession: ARSession
    public var planeDetectionMode: PlaneDetection
    public var debugOptions: ARView.DebugOptions
    
    /// Subscribers for loading entities.
    var loadingStreams: [AnyCancellable] = .init()
    
    public init(planeDetectionMode: PlaneDetection, debugOptions: DebugOptions, isPeopleOcclusion: Bool, arSessionDelegate: ARSessionDelegate) {
        // Assign people occlusion.
        self.isPeopleOcclusion = isPeopleOcclusion
        // Assign debugOptions.
        self.debugOptions = debugOptions
        // Assign planeDetection mode.
        self.planeDetectionMode = planeDetectionMode
        // Make ARWorldTrackingConfiguration.
        arSessionConfiguration = .init()
        // Make and run ARSession.
        arSession = .init()
        arSession.run(arSessionConfiguration, options: [.resetTracking, .removeExistingAnchors])
 
        super.init()
        
        arSession.delegate = arSessionDelegate
        
        #if DEBUG
        print("[ARProvider]: Initialized.")
        #endif
    }
    
    deinit {
        #if DEBUG
        print("[ARProvider]: Deinitialized.")
        #endif
    }
}
#endif
