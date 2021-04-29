//
//  AppStore.swift
//  MoveToMovies
//
//  Created by Dmitry Samartcev on 31.03.2021.
//

import SwiftUI
import Combine

#if canImport(SwiftUI)

@available(iOS 13.0, *)
public final class AppStore<State, Action>: ObservableObject {
    @Published public private(set) var state: State

    private let reduce: (inout State, Action) -> AnyPublisher<Action, Never>
    private var effectsCancellables: [UUID: AnyCancellable] = .init()
    public let appStoreQueue: DispatchQueue
    
    public init<Environment>(
        initialState: State,
        reducer: AppReducer<State, Action, Environment>,
        environment: Environment,
        subscriptionQueue: DispatchQueue = .init(label: "com.application.appStoreQueue")
        ) {
        self.appStoreQueue = subscriptionQueue
        self.state = initialState
        self.reduce = {state, action in
            reducer(&state, action, environment)
        }
    }
    
    public func send(_ action: Action) {
        let effect = reduce(&state, action)
        
        var didComplete = false
        let uuid = UUID()
        
        let cancellable = effect
            .subscribe(on: appStoreQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                didComplete = true
                self?.effectsCancellables[uuid] = nil
            } receiveValue: { [weak self] in
                self?.send($0)
            }
        if !didComplete {
            effectsCancellables.updateValue(cancellable, forKey: uuid)
        }
    }
    
    //@available(iOS 14.0, *)
    public func derived<DerivedState: Equatable, ExtractedAction>(
        deriveState: @escaping (State) -> DerivedState,
        embedAction: @escaping (ExtractedAction) -> Action
    ) -> AppStore<DerivedState, ExtractedAction> {
        
        let store = AppStore<DerivedState, ExtractedAction>(initialState: deriveState(state), reducer: AppReducer {_, action, _ in
            self.send(embedAction(action))
            return Empty().eraseToAnyPublisher()
        }, environment: ())
           _ = $state
                .map(deriveState)
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .assign(to: \.state, on: store)
                
        //.assign(to: &store.$state)
        return store
    }
}

public extension AppStore {
    func binding<Value>(for keyPath: KeyPath<State, Value>,
                        toAction: @escaping (Value) -> Action) -> Binding<Value> {
        Binding<Value>(
            get: {self.state[keyPath: keyPath]},
            set: {self.send(toAction($0))}
        )
    }
    
    func binding<Value>(for keyPath: KeyPath<State, Value>) -> Binding<Value> {
        Binding<Value>(
            get: {
                self.state[keyPath: keyPath]},
            set: {
                self.state = $0 as! State
            }
        )
    }
    
    //@available(iOS 14.0, *)
    func connect<C: AppConnector>(using connector: C) -> AppStore<C.ViewState, C.ViewAction> where C.State == State, C.Action == Action {
        derived(deriveState: connector.connect(state:), embedAction: connector.connect(action:))
    }
}
#endif
