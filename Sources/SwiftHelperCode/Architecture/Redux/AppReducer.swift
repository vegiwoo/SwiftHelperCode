//  AppReducer.swift
//  Created by Dmitry Samartcev on 23.04.2021.

#if canImport(SwiftUI)
import SwiftUI
import Combine

public struct AppReducer<State, Action, Environment> {
    let reduce: (inout State, Action, Environment) -> AnyPublisher<Action, Never>
    
    func callAsFunction(_ state: inout State, _ action: Action, _ environment: Environment) -> AnyPublisher<Action, Never> {
        reduce(&state, action, environment)
    }
    
    func optional() -> AppReducer<State?, Action, Environment> {
        .init {state, action, environment in
            if state != nil {
                return self(&state!, action, environment)
            } else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
        }
    }
}
#endif
