//  Queue.swift
//  Created by Dmitry Samartcev on 28.07.2021.

import Foundation

public struct Queue<T> : CustomStringConvertible where T: Equatable {
    /// LinkedList
    private var list = LinkedList<T>()
    /// Returns a description of values of all nodes in йueue.
    public var description: String { list.description }
    /// Checking a queue for elements.
    public var isEmpty: Bool { list.isEmpty }
    /// Number of items in a queue.
    public var count: Int { list.count }
    // MARK: - Initialization.
    public init() {}
    // MARK: - Functionality
    /// Queuing method.
    /// - Parameter element: Element to enqueue.
    public mutating func enqueue (element: T) { list.push(value: element) }
    /// Method for removing an item from queue.
    ///
    /// Removes first element of the linked list (head of linkin list).
    /// - Returns: Deleted item (optional).
    public mutating func dequeue() -> T? { list.popHead() }
    /// Method for viewing first item in queue.
    /// - Returns: Returns first item in queue (head of linked list).
    public func peek () -> T? { list.first?.value}
}
