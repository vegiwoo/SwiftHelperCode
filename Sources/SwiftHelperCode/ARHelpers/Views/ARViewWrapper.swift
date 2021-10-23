//  ARViewWrapper.swift
//  Created by Dmitry Samartcev on 22.10.2021.

#if canImport(SwiftUI) && canImport(ARKit)
import SwiftUI
import ARKit
import RealityKit

public struct ARViewWrapper: UIViewRepresentable {
    
    @Binding public var arSession: ARSession
    @Binding public var debugOptions: ARView.DebugOptions
    
    public init (arSession: Binding<ARSession>,
                 debugOptions: Binding<ARView.DebugOptions>,
                 isTapGesture: Binding<Bool>) {
        self._arSession = arSession
        self._debugOptions = debugOptions
    }
    
    public func makeUIView(context: Context) -> ARView {
        // Create ARView.
        let arView = ARView(frame: .zero, cameraMode: .ar, automaticallyConfigureSession: false)
        arView.session = arSession
        arView.debugOptions = debugOptions
        
        arView.enableTapGestureRecognizer()
        
        // Return
        return arView
    }
    
    public func updateUIView(_ uiView: ARView, context: Context) {
        // ...
    }
}
#endif

extension ARView {
    public func enableTapGestureRecognizer() {
        let tapGestureRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector (tapGesture(sender:)))
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func tapGesture(sender: UITapGestureRecognizer) {
        print(sender.location(in: self))
    }
}
