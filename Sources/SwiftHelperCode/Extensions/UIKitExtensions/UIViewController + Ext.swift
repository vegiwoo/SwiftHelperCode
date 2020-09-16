//  UIViewController + Ext.swift
//  Created by Dmitry Samartcev on 16.09.2020.

import Foundation
#if os(iOS)
import UIKit
#endif

#if os(iOS)
public extension UIViewController {
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
#endif
