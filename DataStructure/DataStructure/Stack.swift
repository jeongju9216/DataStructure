//
//  main.swift
//  DataStructure
//
//  Created by 유정주 on 2022/04/07.
//

import Foundation

struct Stack<T> {
    private var stack: [T] = []
    
    public var size: Int {
        return stack.count
    }
    
    public var isEmpty: Bool {
        return stack.isEmpty
    }
    
    public mutating func push(_ element: T) {
        stack.append(element)
    }
    
    public mutating func pop() -> T? {
        return stack.popLast()
    }
    
    public mutating func top() -> T? {
        return stack.last
    }
}

var stack = Stack<Int>()
print("1) isEmpty? \(stack.isEmpty)")

stack.push(1)
stack.push(2)
print("2) isEmpty? \(stack.isEmpty)")
print("3) stack size: \(stack.size)")
print("4) top: \(stack.top())")

stack.pop()
print("5) top: \(stack.top())")
print("6) stack size: \(stack.size)")
