//  ARViewWrapper.swift
//  Created by Dmitry Samartcev on 22.10.2021.

#if canImport(SwiftUI) && canImport(ARKit)
import SwiftUI
import ARKit
import RealityKit

public struct ARViewWrapper: UIViewRepresentable {
    
    @Binding public var arSession: ARSession
    @Binding public var debugOptions: ARView.DebugOptions
    @Binding public var isTapGesture: Bool
    
    public init (arSession: Binding<ARSession>,
                 debugOptions: Binding<ARView.DebugOptions>,
                 isTapGesture: Binding<Bool>) {
        self._arSession = arSession
        self._debugOptions = debugOptions
        self._isTapGesture = isTapGesture
    }
    
    public func makeUIView(context: Context) -> ARView {
        // Create ARView.
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
        arView.session = arSession
        arView.debugOptions = debugOptions
        // Return
        return arView
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        // ...
    }
}
#endif
