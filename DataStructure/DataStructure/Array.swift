//
//  main.swift
//  DataStructure
//
//  Created by 유정주 on 2022/04/08.
//

import Foundation

var a1: String = "1", a2: String = "22"
var arr: [String] = ["1", "22", "333"]
var arr2: [[String]] = [["1", "2", "3"], ["11", "22", "33"], ["111", "222", "333"], ["1111", "2222"]]
var a3: String = "333"
print("size: \(type(of: a1)) / \(MemoryLayout.size(ofValue: a1))")
withUnsafePointer(to: &a1) { print("a1 addr: \($0)") }
withUnsafePointer(to: &a2) { print("a2 addr: \($0)") }
withUnsafePointer(to: &a3) { print("a3 addr: \($0)") }

print("------1------")
for i in 0..<arr.count {
    withUnsafePointer(to: &arr[i]) {
        print("addr: \($0) / value: \($0.pointee)")
    }
}

print("------2------")
arr.append("4444")
for i in 0..<arr.count {
    withUnsafePointer(to: &arr[i]) {
        print("addr: \($0) / value: \($0.pointee)")
    }
}

print("------3------")
arr.removeFirst()
for i in 0..<arr.count {
    withUnsafePointer(to: &arr[i]) {
        print("addr: \($0) / value: \($0.pointee)")
    }
}

print("------4------")
for i in 0..<arr2.count {
    for j in 0..<arr2[i].count {
        withUnsafePointer(to: &(arr2[i][j])) {
            print("addr2: \($0) / value: \($0.pointee)")
        }
    }
}
