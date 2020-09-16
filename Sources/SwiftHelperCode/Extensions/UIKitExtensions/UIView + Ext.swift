//  UIView + Ext.swift
//  Created by Dmitry Samartcev on 16.09.2020.

import Foundation
#if os(iOS)
import UIKit
#endif

#if os(iOS)
public extension UIView {
    
    public static func screenSizeInInches () -> Float {
        let scale = UIScreen.main.scale
        
        let ppi = scale * ((UIDevice.current.userInterfaceIdiom == .pad) ? 132 : 163);
        
        let width = UIScreen.main.bounds.size.width * scale
        let height = UIScreen.main.bounds.size.height * scale
        
        let horizontal = width / ppi, vertical = height / ppi;
        
        return Float(sqrt(pow(horizontal, 2) + pow(vertical, 2)))
        //return String(format: "%0.1f", diagonal)
    }
    
    public func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}
#endif
