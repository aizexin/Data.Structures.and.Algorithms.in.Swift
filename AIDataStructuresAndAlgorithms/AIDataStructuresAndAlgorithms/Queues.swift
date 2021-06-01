//
//  Queues.swift
//  AIDataStructuresAndAlgorithms
//
//  Created by aizexin on 2021/6/1.
//

import Foundation

public protocol Queue {
    associatedtype Element
    mutating func enqueue(_ element: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

public struct QueueArray<T>:Queue {
    public typealias Element = T
    
    private var array: [T] = []
    public init() {}
    
    public var isEmpty: Bool {
        array.isEmpty
    }
    
    public var peek: T? {
        array.first
    }
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
    public mutating func dequeue() -> T? {
        isEmpty ? nil : array.removeFirst()
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String {
        String(describing: array)
    }
}

//MARK:“Doubly linked list implementation”
public class QueueLinkedList<T>: Queue {
    public typealias Element = T
     
    private var list = DoublyLinkedList<T>()
    public init() {}
    
    public func enqueue(_ element: T) -> Bool {
        list.append(element)
        return true
    }
    public func dequeue() -> T? {
        guard !list.isEmpty, let element = list.first else {
            return nil
        }
        return list.remove(element)
    }
    public var peek: T? {
        list.first?.value
    }
    public var isEmpty: Bool {
        list.isEmpty
    }
}

extension QueueLinkedList: CustomStringConvertible {
    public var description: String {
        String(describing: list)
    }
}

//MARK:Ring buffer implementation
public struct QueueRingBuffer<T>: Queue {
    public mutating func enqueue(_ element: T) -> Bool {
        ringBuffer.write(element)
    }
    
    public mutating func dequeue() -> T? {
        ringBuffer.read()
    }
    
    public typealias Element = T
    
    private var ringBuffer: RingBuffer<T>
    public init(count: Int) {
        ringBuffer = RingBuffer<T>(count: count)
    }
    public var isEmpty: Bool {
        ringBuffer.isEmpty
    }
    public var peek: T? {
        ringBuffer.first
    }
}
extension QueueRingBuffer: CustomStringConvertible {
    public var description: String {
        String(describing: ringBuffer)
    }
}

//MARK:Double-stack implementation
public struct QueueStack<T>: Queue {
    public mutating func enqueue(_ element: T) -> Bool {
        rightStack.append(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        if leftStack.isEmpty {
            leftStack = rightStack.reversed()
            rightStack.removeAll()
        }
        return leftStack.popLast()
    }
    
    public typealias Element = T
    
    private var leftStack: [T] = []
    private var rightStack: [T] = []
    public init(){}
    
    public var isEmpty: Bool {
        leftStack.isEmpty && rightStack.isEmpty
    }
    public var peek: T? {
        !leftStack.isEmpty ? leftStack.last : rightStack.first
    }
}

extension QueueStack: CustomStringConvertible {
    public var description: String {
        String(describing: leftStack.reversed() + rightStack)
    }
}
