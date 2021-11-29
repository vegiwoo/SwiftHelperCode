//  LinkedList.swift
//  Created by Dmitry Samartcev on 25.03.2021.

#if canImport(Combine)
import Foundation
import Combine

@available (iOS 13.0, macOS 10.15, *)
/// Linked list
public class LinkedList<T>: CustomStringConvertible where T: Equatable {
    /// Head of linked list.
    private var head: LinkedListNode<T>?
    /// Tail of linked list.
    private var tail: LinkedListNode<T>?
    /// Queue for working with a linked list.
    public let linkedListQueue: DispatchQueue = DispatchQueue.init(label: "LinkedListQueue_\(UUID().uuidString)", qos: .utility)
    /// Number of items in a linked list.
    public var count: Int = 0
    /// Checking a linked list for elements.
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
    // MARK: - Initialization.
    public init() {}
    // MARK: - Adding.
    /// Adds a new node to end of linked list.
    /// - Parameter value: Value for new LinkedListNode.
    /// - Returns: New LinkedListNode as AnyPublisher.
    @discardableResult
    public func push(value: T) -> AnyPublisher<LinkedListNode<T>, Never> where T: Equatable {
        Deferred {Future<LinkedListNode<T>, Never>{[weak self] promise in
            DispatchQueue.global().async {
                self?.linkedListQueue.async {
                    let newNode = LinkedListNode(value: value)
                    if self?.tail != nil {
                        newNode.previous = self?.tail
                        self?.tail?.next = newNode
                    } else {
                        self?.head = newNode
                    }
                    self?.tail = newNode
                    self?.count += 1
                    promise(.success(newNode))
                }
            }
        }}
        .receive(on: linkedListQueue, options: nil)
        .eraseToAnyPublisher()
    }
    
    // MARK: - Search.
    /// Returns node that is searched for by specified ID.
    /// - Parameter id: ID for finding a node.
    /// - Returns: Found node or nil if no node is found as AnyPublisher.
    public func getNode(_ id: UUID) -> AnyPublisher<LinkedListNode<T>?, Never> {
        Deferred {Future<LinkedListNode<T>?, Never>{[weak self] promise in
            
            guard let head = self?.head
            else { promise(.success(nil)); return }
            
            var node: LinkedListNode<T>? = head
            repeat {
                guard let existingNode = node
                else { promise(.success(nil)); return }
                
                if existingNode.id == id {
                    promise(.success(existingNode))
                } else {
                    if let nextNode = existingNode.next {
                        node = nextNode
                    }
                }
            } while node != nil
            
            promise(.success(nil))
        }}
        .receive(on: linkedListQueue, options: nil)
        .eraseToAnyPublisher()
    }
    
    /// Returns node, which is searched for by specified value inside it.
    /// - Parameter id: Value for finding a node.
    /// - Returns: Found node or nil if no node is found as AnyPublisher.
    public func getNode(_ value: T) -> AnyPublisher<LinkedListNode<T>?, Never> {
         Deferred {Future<LinkedListNode<T>?, Never>{[weak self] promise in
            guard let head = self?.head
             else { promise(.success(nil)); return }
            
            var node: LinkedListNode<T>?  = head
            
            repeat {
                guard let existingNode = node
                else { promise(.success(nil)); return}
                
                if existingNode.value == value {
                    promise(.success(existingNode))
                } else {
                    if let nextNode = existingNode.next {
                        node = nextNode
                    }
                }
            } while node != nil
            
            promise(.success(nil))
        }}
        .receive(on: linkedListQueue, options: nil)
        .eraseToAnyPublisher()
    }
    
    /// Returns value for node searched for by the specified ID.
    /// - Parameter id: ID for finding a node.
    /// - Returns: Value of found node, or nil if node is not found as AnyPublisher.
    public func getValueForNode(_ id: UUID) -> AnyPublisher<T?, Never> {
        return self.getNode(id)
            .map{node -> T? in
                node?.value != nil ? node!.value : nil
            }
            .receive(on: linkedListQueue, options: nil)
            .eraseToAnyPublisher()
    }
    
    /// Returns value of next node relative to node specified for search by ID.
    /// - Parameter id: ID for finding a node.
    /// - Returns: Value of next node relative to specified node, or nil if node at specified id is not found or it does not have next node as AnyPublisher.
    public func getNextNodeValueForNode(_ id: UUID) ->  AnyPublisher<T?, Never> {
        return self.getNode(id)
            .map{node -> T? in
               node != nil && node?.next != nil ? node?.next!.value : nil
            }
            .receive(on: linkedListQueue, options: nil)
            .eraseToAnyPublisher()
    }
    
    // MARK: - Removing.
    /// Removes a specific node in the linked list
    /// - Parameter node: Node to remove from linked list.
    /// - Returns: Value of removed node as AnyPublisher.
    private func remove(node: LinkedListNode<T>) -> AnyPublisher<T, Never> {
        return Deferred{Future<T,Never>{[weak self] promise in
            DispatchQueue.global().async {
                self?.linkedListQueue.async {
                    let previous = node.previous
                    let next = node.next
                    if let previous = previous {
                        previous.next = next
                    } else {
                        self?.head = next
                    }
                    next?.previous = previous
                    
                    if next == nil { self?.tail = previous }

                    node.previous = nil
                    node.next = nil
                    
                    self?.count -= 1
                    
                    promise(.success(node.value))
                }
            }
        }}
        .receive(on: linkedListQueue, options: nil)
        .eraseToAnyPublisher()
    }
    
    /// Removes first node (head) of linked list.
    /// - Returns: Returns value of removed item, or nil as AnyPublisher.
    @discardableResult
    public func popHead() -> AnyPublisher<T?, Never> {

        guard let node = head
        else {return Result<T?, Never>.success(nil).publisher
            .receive(on: linkedListQueue, options: nil)
            .eraseToAnyPublisher()}
        
        return remove(node: node)
            .map{$0}
            .receive(on: linkedListQueue, options: nil)
            .eraseToAnyPublisher()
            
    }
    
    /// Removes last node (tail) of linked list.
    /// - Returns: Value of removed node, or nil if delete failed as AnyPublisher.
    @discardableResult
    public func pop() -> AnyPublisher<T?, Never> {
        guard !isEmpty, tail != nil
        else {return Result<T?, Never>.success(nil).publisher
                .receive(on: linkedListQueue, options: nil)
                .eraseToAnyPublisher()}
        return remove(node: tail!)
            .map{$0}
            .receive(on: linkedListQueue, options: nil)
            .eraseToAnyPublisher()
    }
    
    /// Deletes all nodes of linked list except first (head).
    /// - Returns: Value of first node in linked list as AnyPublisher.
    @discardableResult
    public func popToHead() -> AnyPublisher<T?, Never> {
        Deferred {Future<T?,Never>{ [weak self] promise in
            DispatchQueue.global().async {
                self?.linkedListQueue.async {
                    guard let head = self?.head
                    else { promise(.success(nil)); return }
                    
                    self?.tail?.next = nil; self?.tail?.previous = nil
                    head.next = nil; head.previous = nil
                    self?.count = 1
                    promise(.success(head.value))
                }
            }
        }}
        .receive(on: linkedListQueue, options: nil)
        .eraseToAnyPublisher()
    }
    
    /// Deletes all nodes of the linked list, resetting it to zero.
    public func removeAll() {
        DispatchQueue.global().async {[weak self] in
            self?.linkedListQueue.async {
                self?.head = nil; self?.tail = nil
            }
        }
    }
}
#endif

