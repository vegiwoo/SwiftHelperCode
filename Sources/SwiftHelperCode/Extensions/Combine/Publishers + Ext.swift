//  Publishers + Ext.swift
//  Created by Dmitry Samartcev on 12.10.2021.

#if canImport(Combine)
import Combine

@available (macOS 10.15, *)
public extension Publishers {
    struct ZipMany<Element, F: Error>: Publisher {
        public typealias Output = [Element]
        public typealias Failure = F

        private let upstreams: [AnyPublisher<Element, F>]

        public init(_ upstreams: [AnyPublisher<Element, F>]) {
            self.upstreams = upstreams
        }

        public func receive<S: Subscriber>(subscriber: S) where Self.Failure == S.Failure, Self.Output == S.Input {
            let initial = Just<[Element]>([])
                .setFailureType(to: F.self)
                .eraseToAnyPublisher()

            let zipped = upstreams.reduce(into: initial) { result, upstream in
                result = result.zip(upstream) { elements, element in
                    elements + [element]
                }
                .eraseToAnyPublisher()
            }

            zipped.subscribe(subscriber)
        }
    }
}
#endif
