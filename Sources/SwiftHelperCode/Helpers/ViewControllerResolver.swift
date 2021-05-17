//  ViewControllerResolver.swift
//  Created by Dmitry Samartcev on 17.05.2021.

#if canImport(SwiftUI)
import SwiftUI

/// Implements interaction with UIViewController from SwiftUI.
public final class ViewControllerResolver: UIViewControllerRepresentable {
    
    public init() {}
    
    public func makeUIViewController(context: Context) -> ParentResolverViewController {
        ParentResolverViewController()
    }
    
    public func updateUIViewController(_ uiViewController: ParentResolverViewController, context: Context) { }
}

public class ParentResolverViewController: UIViewController {
    
    public override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if let parent = parent {
            print("didMove(toParent: \(parent)")
        }
    }
}
#endif
