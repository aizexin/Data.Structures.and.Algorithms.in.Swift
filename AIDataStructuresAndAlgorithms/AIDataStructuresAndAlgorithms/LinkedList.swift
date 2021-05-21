//
//  LinkedList.swift
//  AIDataStructuresAndAlgorithms
//
//  Created by aizexin on 2021/5/21.
//

import Foundation

//MARK: Node
public class Node<Value: Comparable> {
    public var value :Value
    public var next :Node?
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next  =  next
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}

//MARK: LinkedList
public struct LinkedList<Value :Comparable> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    //MARK: add
    public mutating func push(_ value: Value) {
        copyNodes()
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        guard !isEmpty else {
            push(value)
            return
        }
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        return currentNode
    }
    
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    //MARK: remove
    @discardableResult
    public mutating func pop() ->Value? {
        copyNodes()
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    @discardableResult
    public mutating func removeLast() -> Value? {
        copyNodes()
        guard let head = head else {
            return nil
        }
        guard head.next != nil else {
            return pop()
        }
        var prev    = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        prev.next = nil
        tail = prev
        return current.value
    }
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        copyNodes()
        guard let node = copNodes(returningCopyOf: node) else {
            return nil
        }
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else {
            return
        }
        guard var oldNode = head else {
            return
        }
        head = Node(value: oldNode.value)
        var newNode = head
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            oldNode = nextOldNode
        }
        tail = newNode
    }
    private mutating func copNodes(returningCopyOf node: Node<Value>?) -> Node<Value>? {
        guard !isKnownUniquelyReferenced(&head) else {
            return nil
        }
        guard var oldNode = head else {
            return nil
        }
        head = Node(value: oldNode.value)
        var newNode = head
        var nodeCopy: Node<Value>?
        
        while let nextOldNode = oldNode.next {
            if oldNode === node {
                nodeCopy = newNode
            }
            newNode!.next = Node(value: nextOldNode.value)
            newNode       = newNode!.next
            oldNode       = nextOldNode
        }
        return nodeCopy
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return String(describing: head)
    }
}

extension LinkedList: Collection {
    
    public var startIndex: Index {
        Index(node: head)
    }
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    public func index(after i:Index) -> Index {
        Index(node: i.node?.next)
    }
    public subscript(position: Index) -> Value {
        position.node!.value
    }
    
    public struct Index: Comparable {
        public static func == (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil,nil):
                return true
            default:
                return false
            }
        }
        
        public static func < (lhs: LinkedList<Value>.Index, rhs: LinkedList<Value>.Index) -> Bool {
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains{ $0 === rhs.node}
        }
        public var node: Node<Value>?
    }
}

//MARK: Challenges
extension LinkedList {
    static func printInReverse<T: Comparable>(_ array: [T]) {
        var list = LinkedList<T>()
        for item in array {
            list.push(item)
        }
        print(list)
    }
    func findMiddleNode() -> Node<Value>? {
        var nodeCount = 0
        guard head != nil else {
            return nil
        }
        var currentNode = head
        while let next = currentNode?.next {
            nodeCount += 1
            currentNode = next
        }
        return self.node(at: nodeCount/2)
    }
//    func reverse() -> LinkedList<Value> {
//        var list = LinkedList<Value>()
//        var currentNode = head
//        while let next = currentNode?.next {
//            list.push(currentNode!.value)
//            currentNode = next
//        }
//        list.push(currentNode!.value)
//        return list
//    }
    mutating func reverse() -> LinkedList<Value> {
        var currentNode = head
        var lastNode :Node<Value>? = nil
        while let next = currentNode?.next {
            currentNode?.next = lastNode
            lastNode = currentNode
            currentNode = next
        }
        currentNode?.next = lastNode
        self.head = currentNode
        return self
    }
    /// 升序合并
    /// - Parameters:
    ///   - listA: 1 -> 4 -> 10 -> 11
    ///   - listB: -1 -> 2 -> 3 -> 6
    /// - Returns: -1 -> 1 -> 2 -> 3 -> 4 -> 6 -> 10 -> 11
    static func mergeTwoList(listA: LinkedList<Value>, listB: LinkedList<Value>) -> LinkedList<Value> {
        var list = LinkedList<Value>()
        var cureentA = listA.head
        var cureentB = listB.head
        while var left = cureentA,
              var right = cureentB
        {
            if left.value < right.value {
                list.append(left.value)
                cureentA = left.next
            } else {
                list.append(right.value)
                cureentB = right.next
            }
        }
        if let leftNodes = cureentA {
            list.tail?.next = leftNodes
        }
        if let rigthNodes = cureentB {
            list.tail?.next = rigthNodes
        }
        return list
    }
    ///Challenge 5: Remove all occurrences of a specific element
    mutating func removeAll(_ value :Value) {
        
        while let head = self.head, head.value == value {
            self.head = head.next
        }
        var prev = head
        var current = head?.next
        while let currentNode = current {
            guard currentNode.value != value else {
                prev?.next = currentNode.next
                current    = prev?.next
                continue
            }
            prev       = current
            current    = current?.next
        }
        tail = prev
    }
}
