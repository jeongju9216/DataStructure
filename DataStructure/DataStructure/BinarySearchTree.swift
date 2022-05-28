//
//  BinarySearchTree.swift
//  DataStructure
//
//  Created by 유정주 on 2022/05/28.
//

//BinarySearchTree
import Foundation

class Node {
    var data: Int //데이터는 항상 존재해야 한다.
    var parent: Node?
    var left: Node?
    var right: Node?
    
    init(data: Int) {
        self.data = data
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    var isFull: Bool {
        return left != nil && right != nil
    }
}

class BinarySearchTree {
    var root: Node?
    
    func insert(_ data: Int) {
        guard let root = root else {
            self.root = Node(data: data)
            return
        }

        var currentNode: Node = root
        while true {
            //BST의 값은 유일해야 한다.
            if currentNode.data == data {
                return
            }
         
            if currentNode.data > data {
                //삽입할 값이 현재 노드의 값보다 작으면 왼쪽 노드로 이동한다.
                guard let nextLeftNode = currentNode.left else {
                    //왼쪽 노드가 비어 있으면 새로운 노드를 생성, 삽입한다.
                    currentNode.left = Node.init(data: data)
                    currentNode.left?.parent = currentNode
                    return
                }
                
                currentNode = nextLeftNode
            } else {
                //삽입할 값이 현재 노드의 값보다 크면 오른쪽 노드로 이동한다.
                guard let nextRightNode = currentNode.right else {
                    //오른쪽 노드가 비어 있으면 새로운 노드를 생성, 삽입한다.
                    currentNode.right = Node.init(data: data)
                    currentNode.right?.parent = currentNode
                    return
                }
                
                currentNode = nextRightNode
            }
        }
    }
    
    func remove(_ data: Int) -> Bool {
        guard let targetNode = search(data) else { //탐색 실패
            return false
        }
        
        if targetNode.isRoot { //root 노드를 지우는 경우
            removeRoot(targetNode)
        } else if targetNode.isLeaf { //Leaf 노드인 경우
            removeLeaf(targetNode, data: data)
        } else {
            if targetNode.isFull { //자식 노드가 2개인 경우
                removeFullNode(targetNode, data: data)
            } else { //자식 노드가 1개인 경우
                removeSingleChildNode(targetNode, data: data)
            }
        }
        
        return true
    }
    
    private func removeRoot(_ node: Node) {
        if node.isLeaf {
            root = nil
        } else if node.isFull {
            var changeNode = node.right!
            while let nextNode = changeNode.left {
                changeNode = nextNode
            }
            
            changeNode.left = root?.left
            changeNode.right = root?.right
            root = changeNode
            
            changeNode.parent?.left = nil
        } else {
            if node.left != nil { //왼쪽 노드만 있는 경우
                node.left?.parent = nil
                root = node.left
            } else if node.right != nil { //오른쪽 노드만 있는 경우
                node.right?.parent = nil
                root = node.right
            }
        }
    }
    
    private func removeLeaf(_ node: Node, data: Int) {
        if node.parent?.left?.data == data { //왼쪽 노드일 경우
            node.parent?.left = nil
        } else { //오른쪽 노드일 경우
            node.parent?.right = nil
        }
        node.parent = nil
    }
    
    private func removeSingleChildNode(_ node: Node, data: Int) {
        guard let parent = node.parent else { return }
        
        if node.left != nil { //target의 왼쪽 노드가 존재하는 경우
            if parent.data > data {
                parent.left = node.left
            } else {
                parent.right = node.left
            }
            node.left?.parent = parent
        } else { //target의 오른쪽 노드가 존재하는 경우
            if parent.data > data {
                parent.left = node.right
            } else {
                parent.right = node.right
            }
            node.right?.parent = parent
        }
    }
    
    private func removeFullNode(_ node: Node, data: Int) {
        guard let parent = node.parent else { return }
        guard let rightNode = node.right else { return }
        
        var changeNode = rightNode
        while let nextNode = changeNode.left {
            changeNode.parent = changeNode
            changeNode = nextNode
        }
                
        if let changeChildNode = changeNode.right {
            //변경할 노드가 leaf가 아닌 경우 -> right 노드가 있는 경우
            changeNode.parent?.right = changeChildNode
            changeChildNode.parent = changeNode
        } else {
            changeNode.parent?.right = nil
        }
        
        if parent.data > changeNode.data {
            parent.left = changeNode
        } else {
            parent.right = changeNode
        }
        changeNode.parent = parent
        
        changeNode.left = node.left
        changeNode.right = node.right
    }
    
    func search(_ data: Int) -> Node? {
        var currentNode: Node? = root
        while let node = currentNode {
            //찾는 값이 있으면 break
            if node.data == data { break }
            
            //이진 탐색
            currentNode = (node.data > data) ? node.left : node.right
        }
        
        return currentNode
    }
}

extension BinarySearchTree {
    func drawDiagram() {
        print(diagram(for: self.root))
    }
    
    private func diagram(for node: Node?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        if node.left == nil && node.right == nil {
            return root + "\(node.data)\n"
        }
        return diagram(for: node.right, top + " ", top + "┌──", top + "│ ")
            + root + "\(node.data)\n"
            + diagram(for: node.left, bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

let binarySearchTree = BinarySearchTree()

binarySearchTree.insert(15)
binarySearchTree.insert(18)
binarySearchTree.insert(20)
binarySearchTree.insert(12)
binarySearchTree.insert(10)
binarySearchTree.insert(11)
binarySearchTree.insert(17)
binarySearchTree.insert(13)
binarySearchTree.insert(9)
binarySearchTree.insert(14)

binarySearchTree.drawDiagram()

binarySearchTree.remove(12)
binarySearchTree.drawDiagram()
