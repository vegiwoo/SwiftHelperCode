//
//  AppReducer.swift
//  Created by Dmitry Samartcev on 23.04.2021.
//

import Foundation
import Combine

public struct AppReducer<State, Action, Environment> {
    public init(reduce: @escaping (inout State, Action, Environment) -> AnyPublisher<Action, Never>) {
        self.reduce = reduce
    }
    

    public let reduce: (inout State, Action, Environment) -> AnyPublisher<Action, Never>
    
    public func callAsFunction(_ state: inout State, _ action: Action, _ environment: Environment) -> AnyPublisher<Action, Never> {
        reduce(&state, action, environment)
    }
    
    public func optional() -> AppReducer<State?, Action, Environment> {
        .init() {state, action, environment in
            if state != nil {
                return self(&state!, action, environment)
            } else {
                return Empty(completeImmediately: true).eraseToAnyPublisher()
            }
        }
    }
}


