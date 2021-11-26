//  Binding + Ext.swift
//  Created by Dmitry Samartcev on 28.08.2021.

#if canImport(SwiftUI)
import SwiftUI

@available (macOS 10.15, *)
public extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { self.wrappedValue = $0; handler($0)
        })
    }
}
#endif
