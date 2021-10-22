//  ARViewWrapper.swift
//  Created by Dmitry Samartcev on 22.10.2021.

#if canImport(SwiftUI) && canImport(ARKit)
import SwiftUI
import ARKit
import RealityKit

public struct ARViewWrapper: UIViewRepresentable {
    
    @Binding public var arSession: ARSession
    @Binding public var debugOptions: ARView.DebugOptions
    private var coordinatorDelegate: ARViewWrapperCoordinatorDelegate
    
    @Binding public var isTapGesture: Bool
    
    public init (arSession: Binding<ARSession>,
                 debugOptions: Binding<ARView.DebugOptions>,
                 isTapGesture: Binding<Bool>,
                 delegate: ARViewWrapperCoordinatorDelegate) {
        self._arSession = arSession
        self._debugOptions = debugOptions
        self._isTapGesture = isTapGesture
        self.coordinatorDelegate = delegate
        print("ARViewWrapper init")
    }
    
    public func makeCoordinator() -> ARViewWrapperCoordinator {
        print("ARViewWrapperCoordinator init")
        return ARViewWrapperCoordinator()
    }

    public func makeUIView(context: Context) -> ARView {
        // Create ARView.
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
        arView.session = arSession
        arView.debugOptions = debugOptions
        // Set the required values for the coordinator:
        context.coordinator.parent = arView
        context.coordinator.delegate = coordinatorDelegate
        // Return
        return arView
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        if isTapGesture, !context.coordinator.isTapGesture {
            context.coordinator.isTapGesture.toggle()
        }
    }
}
#endif

public final class ARViewWrapperCoordinator: NSObject {
    
    public var parent: ARView?
    weak var delegate: ARViewWrapperCoordinatorDelegate?
    
    public var isTapGesture: Bool = false {
        didSet {
            if isTapGesture {
                enableTapGesture()
            }
        }
    }
    
    public override init() {
        super.init()
    }
    
    func enableTapGesture() {
        let tapGestureRecognizer: UITapGestureRecognizer = .init(target: parent, action: #selector(tapHandler(sender:)))
        parent?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func tapHandler(sender: UIGestureRecognizer) {
        delegate?.tapHandler(senderState: sender.state, tapPoint: sender.location(in: parent))
    }
}

public protocol ARViewWrapperCoordinatorDelegate: AnyObject {
    func tapHandler(senderState: UIGestureRecognizer.State, tapPoint: CGPoint) -> Void
}
