//
//  BinarySearchTree.swift
//  BinarySearchTree
//
//  Created by Myron on 2019/8/4.
//  Copyright © 2019 Myron. All rights reserved.
//

struct AVLTree<Element: Comparable> {
    private(set) var root: AVLNode<Element>?
    init() {  }
}

//MARK: - description
extension AVLTree: CustomStringConvertible {
    var description: String {
        return root?.description ?? "empty tree"
    }
}

// MARK: - 查找
extension AVLTree {
    func contains(_ value: Element) -> Bool {
        var current = root
        while let node = current {
            if node.value == value {
                return true
            }
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        return false
    }
}

// MARK: - 插入Insert
extension AVLTree {
    mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: AVLNode<Element>?,
                        value: Element) -> AVLNode<Element> {
        guard let node = node else {
            return AVLNode(value)
        }
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        //return node
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight,
                                  balancedNode.rightHeight) + 1
        return balancedNode
    }
}

// MARK: - 删除Remove
extension AVLNode {
    //MARK: 节点右边的最小值
    var minNode: AVLNode {
        return leftChild?.minNode ?? self
    }
}

extension AVLTree {
    mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: AVLNode<Element>?,
                        value: Element) -> AVLNode<Element>? {
        
        guard let node = node else { return nil }
        
        if node.value == value {
            // 左右子节点都为空，删除当前节点，为nil
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            // 左子节点为空，删除当前节点，当前节点变为右节点
            if node.leftChild == nil {
                return node.rightChild
            }
            // 右子节点为空，，删除当前节点，当前节点变为左节点
            if node.rightChild == nil {
                return node.leftChild
            }
            // 左右子节点都不为空
            // 把当前节点的值更新为右子节点的最小值
            node.value = node.rightChild!.minNode.value
            // 把右子节点的最小值删除
            node.rightChild = remove(node: node.rightChild, value: node.value)
            
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        //return node
        let balancedNode = balanced(node)
        balancedNode.height = max(balancedNode.leftHeight,
                                  balancedNode.rightHeight) + 1
        return balancedNode
    }
}

// MARK: - Rotate
extension AVLTree {
    //MARK: 左旋转
    private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let pivot = node.rightChild else { return node }
        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    //MARK: 右旋转
    private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let pivot = node.leftChild else { return node }
        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = max(node.leftHeight, node.rightHeight) + 1
        pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
        return pivot
    }
    //MARK: 右左旋转
    private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let rightChild = node.rightChild else { return node }
        node.rightChild = rightRotate(rightChild)
        return leftRotate(node)
    }
    //MARK: 左右旋转
    private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
        guard let leftChild = node.leftChild else { return node }
        node.leftChild = leftRotate(leftChild)
        return rightRotate(node)
    }
}

// MARK: - Balance
extension AVLTree {
    /**
     平衡因子为2，意味着左边的节点比右边多，需要使用右旋转或者左右旋转。
     平衡因子为-2，意味着右边的节点比左边多，需要使用左旋转或者右左旋转。
    */
    //MARK: 平衡处理
    func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild,
                leftChild.balanceFactor == -1 {
                
                return leftRightRotate(node)
            } else {
                return rightRotate(node)
            }
        case -2:
            if let rightChild = node.rightChild,
                rightChild.balanceFactor == 1 {
                
                return rightLeftRotate(node)
            } else {
                return leftRotate(node)
            }
        default:
            return node
        }
    }
}
