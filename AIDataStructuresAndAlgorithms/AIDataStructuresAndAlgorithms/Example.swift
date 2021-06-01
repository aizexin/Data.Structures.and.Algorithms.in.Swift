//
//  Example.swift
//  AIDataStructuresAndAlgorithms
//
//  Created by aizexin on 2021/5/21.
//

import Foundation

public func example(of description: String, action: () -> ()) {
    print("---Example of \(description)---")
    action()
    print()
}

class Example {
    //MARK: example Stack
    static func performStackExample() {
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
        example(of: "括号匹配") {
            print(Stack<Int>.checkParetheses("xxx)("))
        }
        example(of: "反转数组") {
            Stack<Int>.printInReverse(["A", "B", "C", "D"])
        }
    }
    //MARK: LinkedList
    static func performLinkedListExample() {
        example(of: "creating and linking nodes") {
            let node1 = Node(value: 1)
            let node2 = Node(value: 2)
            let node3 = Node(value: 3)
            
            node1.next = node2
            node2.next = node3
            print(node1)
        }
        example(of: "push") {
            var list = LinkedList<Int>()
            list.push(3)
            list.push(2)
            list.push(1)
            print(list)
        }
        example(of: "append") {
            var list = LinkedList<Int>()
            list.append(1)
            list.append(2)
            list.append(3)
            print(list)
        }
        example(of: "inserting at a particular index") {
            var list = LinkedList<Int>()
            list.push(3)
            list.push(2)
            list.push(1)
            
            print("Before inserting: \(list)")
            var middleNode = list.node(at: 1)!
            for _ in 1...4 {
                middleNode = list.insert(-1, after: middleNode)
            }
            print("After inserting: \(list)")
        }
        example(of: "pop") {
            var list = LinkedList<Int>()
            list.push(3)
            list.push(2)
            list.push(1)
            
            print("Before popping list: \(list)")
            let poppedValue = list.pop()
            print("After popping list: \(list)")
            print("Poped value: " + String(describing: poppedValue))
        }
        example(of: "removing the last node") {
            var list = LinkedList<Int>()
            list.push(3)
            list.push(2)
            list.push(1)
            print("Before removing last node: \(list)")
            let removedValue = list.removeLast()
            
            print("After removing last node: \(list)")
            print("Removed value: " + String(describing: removedValue))
        }
        example(of: "removing a node after a praticular node") {
            var list = LinkedList<Int>()
            list.push(3)
            list.push(2)
            list.push(1)
            print("Before removing at particular index: \(list)")
            let index = 1
            let node = list.node(at: -1)!
            let removedValue = list.remove(after: node)
            
            print("After removing at index \(index): \(list)")
            print("Removed value: " + String(describing: removedValue))
        }
        example(of: "using collection") {
            var list = LinkedList<Int>()
            for i in 0...9 {
                list.append(i)
            }
            print("List: \(list)")
            print("First element: \(list[list.startIndex])")
            print("Array containing first 3 elements: \(Array(list.prefix(3)))")
            print("Array containing last 3 elements: \(Array(list.suffix(3)))")
            let sum = list.reduce(0, +)
            print("Sum of all values: \(sum)")
        }
        ///实验copy on write
        example(of: "array cow") {
            let array1 = [1,2]
            var array2 = array1
            print("array1: \(array1)")
            print("array2: \(array2)")
            
            print("---After adding 3 to array 2---")
            array2.append(3)
            print("array1: \(array1)")
            print("array2: \(array2)")
        }
        example(of: "linked list cow") {
            var list1 = LinkedList<Int>()
            list1.append(1)
            list1.append(2)
//            print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")
            var list2 = list1
//            print("List1 uniquely referenced: \(isKnownUniquelyReferenced(&list1.head))")

            print("List1: \(list1)")
            print("List2: \(list2)")
            
            print("After appending 3 to list2")
            list2.append(3)
            print("List1: \(list1)")
            print("List2: \(list2)")
            print("Removing middle node on list2")
            if let node = list2.node(at: 0) {
                list2.remove(after: node)
            }
            print("List2: \(list2)")
        }
    }
    static func linkedListChallengesExample() {
        example(of: "printInReverse") {
            LinkedList<String>.printInReverse(["A", "B", "C", "D"])
        }
        example(of: "findMiddleNode") {
            var list = LinkedList<Int>()
            for i in 1...4 {
                list.append(i)
            }
            print("List: \(list)")
            print("middleNode: \(String(describing: list.findMiddleNode()?.value))")
        }
        example(of: "reverse a linked list") {
            var list = LinkedList<Int>()
            for i in 1...4 {
                list.append(i)
            }
            print("List: \(list)")
            print("After reverse List: \(list.reverse())")
        }
        example(of: "merging two list") {
            var list = LinkedList<Int>()
            list.push(3)
            list.push(2)
            list.push(1)
            var anotherList = LinkedList<Int>()
            anotherList.push(-1)
            anotherList.push(-2)
            anotherList.push(-3)
            print("First list: \(list)")
            print("Second list: \(anotherList)")
            let mergedList = LinkedList<Int>.mergeTwoList(listA: list, listB: anotherList)
            print("Merged list: \(mergedList)")
            
        }
        example(of: "Challenge 5: Remove all occurrences of a specific element") {
            var list = LinkedList<Int>()
            list.push(3)
            list.push(2)
            list.push(2)
            list.push(1)
            list.push(1)
            list.removeAll(3)            
            print("before list: \(list)")
        }
    }
    static func queueExample() {
        example(of: "QueueArray") {
            var queue = QueueArray<String>()
            queue.enqueue("ray")
            queue.enqueue("brian")
            queue.enqueue("eric")
            queue.dequeue()
            queue.peek
            print(queue)
        }
        example(of: "QueueRingBuffer") {
            var queue = QueueRingBuffer<String>(count: 10)
            queue.enqueue("ray")
            queue.enqueue("brian")
            queue.enqueue("eric")
            queue.dequeue()
            queue.peek
            print(queue)
        }
    }
}
