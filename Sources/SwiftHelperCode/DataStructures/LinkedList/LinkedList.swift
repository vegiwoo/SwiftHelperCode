//  LinkedList.swift
//  Created by Dmitry Samartcev on 25.03.2021.

import Foundation

/// Linked list
public struct LinkedList<T>: CustomStringConvertible where T: Equatable{
    /// Head of linked list
    private var head: LinkedListNode<T>?
    /// Tail of linked list
    private var tail: LinkedListNode<T>?
    /// Queue for working with a linked list
    private let linkedListQueue: DispatchQueue = DispatchQueue(label: "LinkedListQueue", qos: .utility)
    /// Number of items in a linked list
    public var count: Int = 0
    /// Checking a linked list for elements
    public var isEmpty: Bool { head == nil }
    /// Returns first node (head) of linked list.
    public var first: LinkedListNode<T>? { head }
    /// Returns value of first node (head) of linked list.
    public var firstValue: T? { head?.value }
    /// Returns last node (tail) of linked list.
    public var last: LinkedListNode<T>? { tail }
    /// Returns value of last node (tail) of linked list.
    public var lastValue: T? { tail?.value }
    /// Returns a description of values of all nodes in linked list.
    public var description: String {
        var text = "["
        var node = head
        while node != nil {
            text += "\(node!.value)"
            node = node?.next
            if node != nil { text += ", "}
        }
        return text + "]"
    }
    
    // MARK: - Adding.
    /// Adds a new node to end of linked list.
    /// - Parameter value: Value for new LinkedListNode.
    /// - Returns: New LinkedListNode.
    @discardableResult
    public mutating func push(value: T) -> LinkedListNode<T>{
        linkedListQueue.sync(flags: .barrier) {
            let newNode = LinkedListNode(value: value)
            if tail != nil {
                newNode.previous = tail
                tail?.next = newNode
            } else {
                head = newNode
            }
            tail = newNode
            count += 1
            return newNode
        }
    }
    
    // MARK: - Search.
    /// Returns node that is searched for by specified ID.
    /// - Parameter id: ID for finding a node.
    /// - Returns: Found node or nil if no node is found.
    public func getNode(_ id: UUID) -> LinkedListNode<T>? {
        guard let head = head else { return nil }
        var node: LinkedListNode<T>? = head
        repeat {
            guard let existingNode = node else {
                return nil
            }
            
            if existingNode.id == id {
                return existingNode
            } else {
                if let nextNode = existingNode.next {
                    node = nextNode
                }
            }
        } while node != nil
        
        return nil
    }
    /// Returns node, which is searched for by specified value inside it.
    /// - Parameter id: Value for finding a node.
    /// - Returns: Found node or nil if no node is found.
    public func getNode(_ value: T) -> LinkedListNode<T>? {
        guard let head = head else { return nil }
        
        var node: LinkedListNode<T>?  = head
        
        repeat {
            guard let existingNode = node else {
                return nil
            }
            
            if existingNode.value == value {
                return existingNode
            } else {
                if let nextNode = existingNode.next {
                    node = nextNode
                }
            }
        } while node != nil
        
        return nil
    }
    /// Returns value for node searched for by the specified ID.
    /// - Parameter id: ID for finding a node.
    /// - Returns: Value of found node, or nil if node is not found.
    public func getValueForNode(_ id: UUID) -> T? {
        guard let node = getNode(id) else { return nil }
        return node.value
    }
    /// Returns value of next node relative to node specified for search by ID.
    /// - Parameter id: ID for finding a node.
    /// - Returns: Value of next node relative to specified node, or nil if node at specified id is not found or it does not have next node.
    public func getNextNodeValueForNode(_ id: UUID) -> T? {
        guard let node = getNode(id), let nextNode = node.next else { return nil }
        return nextNode.value
    }
    
    // MARK: - Deleting.
    /// Removes a specific node in the linked list
    /// - Parameter node: Node to remove from linked list.
    /// - Returns: Value of removed node.
    private mutating func remove(node: LinkedListNode<T>) -> T {
        linkedListQueue.sync(flags: .barrier) {
            let previous = node.previous
            let next = node.next
            if let previous = previous {
                previous.next = next
            } else {
                head = next
            }
            next?.previous = previous
            
            if next == nil { tail = previous }

            node.previous = nil
            node.next = nil
            
            count -= 1
            
            return node.value
        }
    }
    /// Removes first node (head) of linked list.
    /// - Returns: Returns value of removed item, or nil.
    @discardableResult
    public mutating func popHead() -> T? {
        guard let node = head else { return nil }
        return remove(node: node)
    }
    /// Removes last node (tail) of linked list.
    /// - Returns: Value of removed node, or nil if delete failed.
    @discardableResult
    public mutating func pop() -> T? {
        guard !isEmpty, tail != nil else { return nil }
        return remove(node: tail!)
    }
    /// Deletes all nodes of linked list except first (head).
    /// - Returns: Value of first node in linked list.
    @discardableResult
    public mutating func popToHead() -> T? {
        linkedListQueue.sync(flags: .barrier) {
            guard let head = head else { return nil }
            tail?.next = nil; tail?.previous = nil
            head.next = nil; head.previous = nil
            count = 1
            return head.value
        }
    }
    /// Deletes all nodes of the linked list, resetting it to zero.
    public mutating func removeAll() {
        linkedListQueue.sync(flags: .barrier) {
            head = nil; tail = nil
        }
    }
}

