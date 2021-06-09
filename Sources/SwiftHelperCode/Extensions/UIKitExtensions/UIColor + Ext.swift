//  UIColor + Ext.swift
//  Created by Dmitry Samartcev on 09.06.2021.

#if canImport(UIKit)
import UIKit

public extension UIColor {
    /// Determines the predominance of a dark or light color in image.
    /// - Returns: Bool flag.
    /// - Remark: Algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
    func isLight() -> Bool {
        guard let components = self.cgColor.components else { return false }
        let components01 = (components[0] * 299)
        let components02 = (components[1] * 587)
        let components03 = (components[2] * 114)

        let brightness = ( components01 + components02 + components03) / 1000
        return brightness < 0.5 ? false : true
    }
}
#endif
