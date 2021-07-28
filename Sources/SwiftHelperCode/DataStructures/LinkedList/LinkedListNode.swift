//  LinkedListNode.swift
//  Created by Dmitry Samartcev on 25.03.2021.

import Foundation
/// Node for linked list
public class LinkedListNode<T> where T: Equatable {
    public var id: UUID
    public var value: T
    public var next: LinkedListNode?
    public var previous: LinkedListNode?

    public init(id: UUID = UUID(), value: T) {
        self.id = id
        self.value = value
    }
    
    static public func == (lhs: LinkedListNode<T>, rhs: LinkedListNode<T>) -> Bool {
        lhs.id == rhs.id
    }
    
    static public func != (lhs: LinkedListNode<T>, rhs: LinkedListNode<T>) -> Bool {
        lhs.id != rhs.id
    }
}
