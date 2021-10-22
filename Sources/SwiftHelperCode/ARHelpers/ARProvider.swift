//  ARProvider.swift
//  Created by Dmitry Samartcev on 21.10.2021.

#if canImport(Combine) && canImport(ARKit) && canImport(RealityKit)
import Foundation
import Combine
import ARKit
import RealityKit

public typealias PlaneDetection = ARWorldTrackingConfiguration.PlaneDetection

/// Protocol for working with ARKit.ARSession.
///
/// - Implemented in ARProviderImpliment class.
public protocol ARProvider {
    // MARK: - Variables and constants.
    /// ARSession configuration (ARWorldTrackingConfiguration).
    var arSessionConfiguration: ARWorldTrackingConfiguration { get }
    /// An ARSession instance.
    var arSession: ARSession { get }
    /// Plane detection mode.
    var planeDetection: PlaneDetection { get }
    // MARK: - Work with ARSession.
    /// Adds a delegate for ArSession.
    func append(arSessionDelegate: ARSessionDelegate)
    // MARK: - Work with files.
    /// Generates a URL to download the '* .reality' file.
    ///
    /// Used to search and generate a URL for a file in local project directory.
    /// - Parameters:
    ///   - filename: The name of the file.
    ///   - fileExtension: File extension.
    ///   - sceneName: Scene name.
    /// - Returns: Returns the generated URL (optional) or an error (as publisher).
    func findURLForRelalityFile(filename: String, fileExtension: String, sceneName:String) -> AnyPublisher <URL?, Error>
    /// Generates a URL to download the '* .usdz' file.
    ///
    /// Used to search and generate a URL for a file in local project directory.
    /// - Parameters:
    ///   - filename: Name of file.
    ///   - fileExtension: File extension.
    /// - Returns: Tuple of file name and URL (optional) as publisher.
    func createUrlForUSDZFile(filename: String, fileExtension: String) -> AnyPublisher<(filename: String, url: URL?), Error>
    /// Asynchronously loads AnchorEnitty **from local file** with extension '*.reality*'.
    /// - Parameters:
    ///   - filename: Name of file.
    ///   - fileExtension: File extension.
    ///   - fileExtension: Name of scene.
    /// - Returns: AnchorEnitty (Entity & HasAnchoring) optional or error.
    func loadRealityFileAsync (filename: String, fileExtension: String, sceneName: String) -> AnyPublisher<(Entity & HasAnchoring)?, Error>
    /// Asynchronously loads ModelEntity **from local file** with extension '*.usdz*'.
    /// - Parameters:
    ///   - filename: Unique name of entity for unique identification in a multiuser session (optional).
    ///   - fileURL: URL of file.
    /// - Returns: ModelEntity (optional) or error (as publisher).
    func loadModelEntityAsync(filename: String, fileURL: URL?) -> AnyPublisher<ModelEntity?, Error>
}

/// Class for working with ARKit.ARSession.
///
/// - Implements ARProvider protocol.
@available (iOS 14.0, *)
public final class ARProviderImpliment: NSObject, ARProvider {
    
    // MARK: - Variables and constants.
    public let arSessionConfiguration: ARWorldTrackingConfiguration
    public let arSession: ARSession
    weak var arSesionDelegate: ARSessionDelegate?
    public let planeDetection: PlaneDetection
    
    /// Subscribers for loading entities.
    var loadingStreams: [AnyCancellable] = .init()
    
    public init(peopleOcclusionIsEnabled: Bool,
                planeDetection: PlaneDetection) {
        // Make ARWorldTrackingConfiguration.
        arSessionConfiguration = .init()
        arSessionConfiguration.isCollaborationEnabled = true
        arSessionConfiguration.isLightEstimationEnabled = true
        arSessionConfiguration.environmentTexturing = .automatic
        if peopleOcclusionIsEnabled,
            ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            arSessionConfiguration.frameSemantics.insert(.personSegmentationWithDepth)
        }
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            arSessionConfiguration.sceneReconstruction = .mesh
        }
        self.planeDetection = planeDetection
        arSessionConfiguration.planeDetection = self.planeDetection
        // Make and run ARSession.
        arSession = .init()
        arSession.run(arSessionConfiguration, options: [.resetTracking, .removeExistingAnchors])
        
        super.init()
        
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
