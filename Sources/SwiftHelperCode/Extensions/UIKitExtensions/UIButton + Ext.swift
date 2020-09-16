//  UIButton + Ext.swift
//  Created by Dmitry Samartcev on 16.09.2020.

import Foundation
#if os(iOS)
import UIKit
#endif

#if os(iOS)
public extension UIButton {
    
    public func fitTextToBounds() {
        guard let text = self.titleLabel?.text, let currentFont = self.titleLabel?.font else { return }
    
        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
        self.titleLabel?.font = bestFittingFont
    }
    
    private var basicStringAttributes: [NSAttributedString.Key: Any] {
        var attribs = [NSAttributedString.Key: Any]()
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        
        if let label = self.titleLabel {
            paragraphStyle.alignment = label.textAlignment
            attribs[.paragraphStyle] = paragraphStyle
        }

        attribs[.paragraphStyle] = paragraphStyle
        
        return attribs
    }
}
#endif

