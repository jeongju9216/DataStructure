//
//  main.swift
//  DataStructure
//
//  Created by 유정주 on 2022/05/10.
//

import Foundation

class Node {
    var data: Int = -1 //노드의 데이터
    var prev: Node? //이전 노드
    var next: Node? //다음 노드
    
    init(data: Int, prev: Node? = nil, next: Node? = nil) {
        self.data = data
        self.prev = prev
        self.next = next
    }
}

class LinkedList {
    private var head: Node? //맨 앞 노드 => head
    private var tail: Node? //맨 뒤 노드 => tail
    var size: Int = 0 //링크드 리스트의 크기
    var isEmpty: Bool { size == 0 } //링크드 리스트가 비었는가?
    
    //맨 뒤에 노드 추가
    func append(data: Int) {
        let newNode = Node(data: data)
        
        if isEmpty {
            head = newNode
            tail = head
        } else {
            tail?.next = newNode //newNode와 tail을 연결
            newNode.prev = tail
            tail = newNode //tail을 새롭게 설정
        }
        
        size += 1
    }
    
    //index 위치에 노드 추가
    func insert(data: Int, at index: Int) {
        let newNode = Node(data: data)
        
        if isEmpty { //head가 비어있으면 head로 설정
            head = newNode
            tail = head
            
            size += 1
            return
        } else if index <= 0 { //head에 추가
            newNode.next = head
            head?.prev = newNode
            head = newNode
            
            size += 1
            return
        } else if index >= size { //tail에 추가
            append(data: data)
            return
        } else { //중간 삽입
            let half = size / 2
            let isForward = (index <= half)
            
            var node: Node?
            if isForward {
                node = head
                for _ in 0..<index-1 {
                    guard let next = node?.next else { break }
                    node = next
                }
            } else {
                node = tail
                for _ in 0..<(size-index) {
                    guard let prev = node?.prev else { break }
                    node = prev
                }
            }
            
            node?.next?.prev = newNode
            newNode.next = node?.next
            
            newNode.prev = node
            node?.next = newNode
            
            size += 1
            return
        }
    }
    
    //모든 노드 삭제
    func removeAll() {
        head = nil
        tail = nil
        
        size = 0
    }
    
    //맨 앞 노드 삭제
    func removeFirst() {
        guard let _ = head else { return }
        
        head = head?.next
        head?.prev = nil
        
        size -= 1
        if isEmpty {
            head = nil
            tail = nil
        }
    }
    
    //맨 뒤 노드 삭제
    func removeLast() {
        guard let _ = tail else { return }
        
        tail = tail?.prev
        tail?.next = nil
        
        size -= 1
        if isEmpty {
            head = nil
            tail = nil
        }
    }
    
    //index 위치의 노드 삭제
    func remove(at index: Int) {
        if isEmpty {
            return
        } else if index <= 0 { //head 삭제
            removeFirst()
        } else if index >= size { //tail 삭제
            removeLast()
        } else {
            let half = size / 2
            let isForward = (index <= half)
            
            var node: Node?
            if isForward {
                node = head
                for _ in 0..<index {
                    guard let next = node?.next else { break }
                    node = next
                }
            } else {
                node = tail
                for _ in 0..<(size-index-1) {
                    guard let prev = node?.prev else { break }
                    node = prev
                }
            }
            
            node?.prev?.next = node?.next
            node?.next?.prev = node?.prev
            
            size -= 1
        }
        
        if isEmpty {
            head = nil
            tail = nil
        }
        
        return
    }
    
    func printNodes() {
        print("size: \(size) / head: \(head?.data ?? -1) / tail: \(tail?.data ?? -1)")
        if size > 0 {
            var str = "[ "
            
            var node = head
            while let next = node?.next {
                str += "\(node?.data ?? -1) -> "
                node = next
            }
            str += "\(node?.data ?? -1) "
            str += "]"
            
            print("\(str)")
        }
    }
}

public func measureTime(_ closure: () -> ()) -> TimeInterval {
    let startDate = Date()
    closure()
    return Date().timeIntervalSince(startDate)
}

let time = 10000
var durationTime: TimeInterval = 0

var linkedList: LinkedList = LinkedList()

durationTime = measureTime {
    for i in 0..<time {
        linkedList.append(data: i)
    }
}
print("linked list append: \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for _ in 0..<time {
        linkedList.removeFirst()
    }
}
print("linked list removeFirst: \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.insert(data: i, at: 1)
    }
}
print("linked list insert(1): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for _ in 0..<time {
        linkedList.remove(at: 1)
    }
}
print("linked list remove(1): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.insert(data: i, at: 5)
    }
}
print("linked list insert(5): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.remove(at: 5)
    }
}
print("linked list remove(5): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.insert(data: i, at: 10)
    }
}
print("linked list insert(10): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.remove(at: 10)
    }
}
print("linked list remove(10): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.insert(data: i, at: linkedList.size - 5)
    }
}
print("linked list insert(size-5): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.remove(at: linkedList.size - 5)
    }
}
print("linked list remove(size-5): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")


durationTime = measureTime {
    for i in 0..<time {
        linkedList.insert(data: i, at: linkedList.size/2)
    }
}
print("linked list insert(center): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")

durationTime = measureTime {
    for i in 0..<time {
        linkedList.remove(at: linkedList.size/2)
    }
}
print("linked list remove(center): \(durationTime)(s)")
print("linked list size: \(linkedList.size)")
