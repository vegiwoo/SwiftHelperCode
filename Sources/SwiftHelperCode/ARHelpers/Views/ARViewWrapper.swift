//  ARViewWrapper.swift
//  Created by Dmitry Samartcev on 22.10.2021.

#if canImport(SwiftUI) && canImport(ARKit)
import SwiftUI
import ARKit
import RealityKit

public struct ARViewWrapper: UIViewRepresentable {
    
    @Binding var arSession: ARSession
    @Binding var debugOptions: ARView.DebugOptions
    
    public init (arSession: Binding<ARSession>, debugOptions: Binding<ARView.DebugOptions>) {
        self._arSession = arSession
        self._debugOptions = debugOptions
    }
    
    public func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
        arView.session = arSession
        arView.debugOptions = debugOptions
        return arView
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        // Do something...
    }
}
#endif
