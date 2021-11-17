//  Queue.swift
//  Created by Dmitry Samartcev on 28.07.2021.

import Foundation
/// Queue
/// TODO: Исправитиь гонку состояний, ввести режим отображения/скрытия лога.
public class Queue<T> : CustomStringConvertible where T: Equatable & Identifiable {
    /// DispatchQueue for working with the queue
    private var queue: DispatchQueue
    /// LinkedList
    private var list: LinkedList<T> = .init()
    /// Returns a description of values of all nodes in йueue.
    public var description: String { list.description }
    /// Checking a queue for elements.
    public var isEmpty: Bool { list.isEmpty }
    /// Number of items in a queue.
    public var count: Int { list.count }
    /// Flag for specifying provision of a report on  operation of queue in console.
    private var isProvideReport: Bool
    
    // MARK: - Initialization.
    public init(queue: DispatchQueue = DispatchQueue.global(qos: .utility), isProvideReport: Bool = false) {
        self.queue = queue
        self.isProvideReport = isProvideReport
    }
    // MARK: - Functionality
    /// Queuing method.
    /// - Parameter element: Element to enqueue.
    public func enqueue (element: T, competion: (() -> Void)? = nil) {
        let workItem = DispatchWorkItem { [weak self] in
            self?.list.push(value: element)
        }
        queue.sync(execute: workItem)
        workItem.notify(queue: queue) {[weak self] in
            if let self = self, self.isProvideReport {
                #if DEBUG
                print("👯‍♀️ Element with ID '\(element.id)' has been added to queue.\nThere are '\(String(describing: self.count))' elements left in queue.")
                #endif
            }
            
            if let competion = competion {
                competion()
            }
        }
    }
    /// Method for removing an item from queue.
    ///
    /// Removes first element of the linked list (head of linkin list).
    /// - Returns: Removed item (optional).
    public func dequeue() -> T? {
        var element: T?
        let workItem = DispatchWorkItem {[weak self] in
            element = self?.list.popHead()
        }
        queue.sync(execute: workItem)
        workItem.notify(queue: queue){[weak self] in
            if let id = element?.id, let self = self, self.isProvideReport {
                #if DEBUG
                print("👯‍♀️ Element with ID '\(id)' is taken from queue.\nThere are '\(String(describing: self.count))' elements left in messageQueue.")
                #endif
            }
        }
        return element
    }
    /// Method for viewing first item in queue.
    /// - Returns: Returns first item in queue (head of linked list).
    public func peek () -> T? { list.first?.value}
}
