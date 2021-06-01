//
//  DoublyLinkedList.swift
//  AIDataStructuresAndAlgorithms
//
//  Created by aizexin on 2021/6/1.
//

import Foundation

public class DoublyNode<T> {
    public var value: T
    public var next : DoublyNode<T>?
    public var previous: DoublyNode<T>?
    
    public init(value: T) {
        self.value = value
    }
}

public class DoublyLinkedList<T> {
    private var head: DoublyNode<T>?
    private var tail: DoublyNode<T>?
    
    public init() {}
    public var isEmpty: Bool {
        head == nil
    }
    
    public var first: DoublyNode<T>? {
        head
    }
    public func append(_ value: T) {
        let newNode = DoublyNode(value: value)
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        newNode.previous = tailNode
        tailNode.next    = newNode
        tail = newNode
    }
    public func remove(_ node: DoublyNode<T>) ->T {
        let prev = node.previous
        let next = node.next
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        return node.value
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    public var description: String{
        var string = ""
        var current = head
        while let node = current {
            string.append("\(node.value) -> ")
            current = node.next
        }
        return string + "end"
    }
}
public class LinkedListIterator<T>: IteratorProtocol {
    private var current: DoublyNode<T>?
    init(node: DoublyNode<T>?) {
        current = node
    }
    
    public func next() -> DoublyNode<T>? {
        defer {
            current = current?.next
        }
        return current
    }
}

extension DoublyLinkedList: Sequence {
    public func makeIterator() -> LinkedListIterator<T> {
        LinkedListIterator(node: head)
    }
}
