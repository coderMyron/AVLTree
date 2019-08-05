//
//  BinaryTreeNode.swift
//  BinaryTreeNode
//
//  Created by Myron on 2019/8/4.
//  Copyright © 2019 Myron. All rights reserved.
//

final class AVLNode<T> {
    var value: T
    var leftChild: AVLNode?
    var rightChild: AVLNode?
    
    //从当前节点到叶节点的最长距离
    var height = 0
    
    var leftHeight: Int {
        return leftChild?.height ?? -1
    }
    var rightHeight: Int {
        return rightChild?.height ?? -1
    }
    //平衡因子(二叉搜索树平衡的条件是树中所有节点的左子节点高度和右子节点高度的差的绝对值不大于1)
    var balanceFactor: Int {
        return leftHeight - rightHeight
    }
    
    init(_ value: T) {
        self.value = value
    }
}

//MARK: - description
extension AVLNode: CustomStringConvertible {
    var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?,
                         top: String = "",
                         root: String = "",
                         bottom: String = "") -> String {
        guard let node = node else {
            //return root + "nil\n"
            return ""
        }
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        return diagram(for: node.rightChild,
                       top: top + " ",
                       root: top + "┌───",
                       bottom: top + "| ")
            + root + "\(node.value)\n"
            + diagram(for: node.leftChild,
                      top: bottom + "| ",
                      root: bottom + "└───",
                      bottom: bottom + " ")
    }
}

// MARK: - Traverse
extension AVLNode {
    //MARK: 中序遍历 左根右
    func traverseInOrder(_ closure: (T) -> Void) {
        leftChild?.traverseInOrder(closure)
        closure(value)
        rightChild?.traverseInOrder(closure)
    }
    
    //MARK: 前序遍历 根左右
    func traversePreOrder(_ closure: (T) -> Void) {
        closure(value)
        leftChild?.traversePreOrder(closure)
        rightChild?.traversePreOrder(closure)
    }
    
    //MARK: 后序遍历 左右根
    func traversePostOrder(_ closure: (T) -> Void) {
        leftChild?.traversePostOrder(closure)
        rightChild?.traversePostOrder(closure)
        closure(value)
    }
}
