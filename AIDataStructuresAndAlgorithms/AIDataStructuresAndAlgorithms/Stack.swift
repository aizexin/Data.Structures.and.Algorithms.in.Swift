//
//  Stack.swift
//  AIDataStructuresAndAlgorithms
//
//  Created by aizexin on 2021/5/20.
//

import Foundation

public struct Stack<Element> {
    private var storage :[Element] = []
    
    public init() {}
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    public func peek() -> Element? {
        storage.last
    }
    
    public var isEmpty :Bool {
        peek() == nil
    }
    
}

extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ---top---
        \(storage.map{ "\($0)"}.reversed().joined(separator: "\n") )
        """
    }
}

extension Stack: ExpressibleByArrayLiteral {
    /// 通过字面量的方式初始化
    /// - Parameter elements: 实现ExpressibleByArrayLiteral协议的字面量
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
