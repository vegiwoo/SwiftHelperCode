//  Queue.swift
//  Created by Dmitry Samartcev on 28.07.2021.

#if canImport(Combine)
import Foundation
import Combine
import Accessibility

/// Queue
@available (iOS 13.0, macOS 10.15, *)
public class Queue<Value: Equatable & Identifiable> : CustomStringConvertible {
    /// LinkedList.
    private var list: LinkedList<Value> = .init()
    /// Dispatch queue.
    public var queue: DispatchQueue
    /// Returns a description of values of all nodes in йueue.
    public var description: String { list.description }
    /// Checking a queue for elements.
    public var isEmpty: Bool { list.isEmpty }
    /// Number of items in a queue.
    public var count: Int { list.count }
    /// Flag for specifying provision of a report on  operation of queue in console.
    private var isProvideReport: Bool
    
    // MARK: - Initialization.
    public init(isProvideReport: Bool = false) {
        self.queue = list.linkedListQueue
        self.isProvideReport = isProvideReport
    }
    // MARK: - Functionality
    /// Queuing method.
    /// - Parameter element: Element to enqueue.
    public func enqueue (_ element: Value) -> AnyPublisher<Bool, Never> {
        list.push(value: element)
            .map{node in
                assert(node.value == element)
                return true
            }
            .handleEvents(receiveOutput: {[weak self] flag in
                if let isProvideReport = self?.isProvideReport, isProvideReport {
                #if DEBUG
                print("👯‍♂️ Element with ID '\(element.id)' has been added to queue.\nThere are '\(String(describing: self?.count))' elements left in queue.")
                #endif
                }
            })
            .receive(on: list.linkedListQueue, options: nil)
            .eraseToAnyPublisher()
    }
    
    /// Method for removing an item from queue.
    ///
    /// Removes first element of the linked list (head of linkin list).
    /// - Returns: Removed item (optional).
    public func dequeue() -> AnyPublisher<Value?, Never> {
        list.popHead()
            .map{$0}
            .handleEvents(receiveOutput: {[weak self] value in
                if let isProvideReport = self?.isProvideReport,
                    isProvideReport, let value = value {
                    #if DEBUG
                    print("👯‍♀️ Element with ID '\(value.id)' is taken from queue.\nThere are '\(String(describing: self?.count))' elements left in messageQueue.")
                    #endif
                }
            })
            .receive(on: list.linkedListQueue, options: nil)
            .eraseToAnyPublisher()
    }
    /// Method for viewing first item in queue.
    /// - Returns: Returns first item in queue (head of linked list).
    public func peek () -> Value? { list.first?.value}
}
#endif
