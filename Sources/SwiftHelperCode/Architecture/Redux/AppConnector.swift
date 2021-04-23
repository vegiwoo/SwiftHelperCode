//
//  AppConnector.swift
//  Created by Dmitry Samartcev on 23.04.2021.
//

import Foundation

public protocol AppConnector {
    associatedtype State
    associatedtype Action
    associatedtype ViewState: Equatable
    associatedtype ViewAction: Equatable
    /// Converts all application states to View state.
    /// - Parameter state: Application state.
    func connect(state: State) -> ViewState
    
    /// Converts View actions to application actions.
    /// - Parameter action: View action.
    func connect(action: ViewAction) -> Action
}
