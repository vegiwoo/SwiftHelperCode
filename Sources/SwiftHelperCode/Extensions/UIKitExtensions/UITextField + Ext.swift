//  UITextField + Ext.swift
//  Created by Dmitry Samartcev on 16.09.2020.

import Foundation
#if os(iOS)
import UIKit
#endif

#if os(iOS)
public extension UITextField {
    
    func fitTextToBounds() {
        guard let text = text, let currentFont = font else { return }
        
        let bestFittingFont = UIFont.bestFittingFont(for: text, in: bounds, fontDescriptor: currentFont.fontDescriptor, additionalAttributes: basicStringAttributes)
        
        font = bestFittingFont
    }
    
    private var basicStringAttributes: [NSAttributedString.Key: Any] {
        var attribs = [NSAttributedString.Key: Any]()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        attribs[.paragraphStyle] = paragraphStyle
        
        return attribs
    }
}
#endif
