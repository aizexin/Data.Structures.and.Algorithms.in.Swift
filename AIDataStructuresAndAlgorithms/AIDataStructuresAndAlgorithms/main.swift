//
//  main.swift
//  AIDataStructuresAndAlgorithms
//
//  Created by aizexin on 2021/5/20.
//

import Foundation

public func example(of description: String, action: () -> ()) {
    print("---Example of \(description)---")
    action()
    print()
}

//MARK: example Stack
example(of: "use of a stack") {
    var stack = Stack<Int>()
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    print(stack)
    if let popedElement = stack.pop() {
        assert(4 == popedElement)
        print("poped: \(popedElement)")
    }
}
example(of: "initializing a stack from an array") {
  let array = ["A", "B", "C", "D"]
  var stack = Stack(array)
  print(stack)
  stack.pop()
}

example(of: "initializing a stack from an array literal") {
  var stack: Stack = [1.0, 2.0, 3.0, 4.0]
  print(stack)
  stack.pop()
}
