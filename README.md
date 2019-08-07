# AVLTree
平衡二叉搜索树(AVL Tree)  
AVL树，第一个自平衡的二叉搜索树，发明者G. M. Adelson-Velsky和E. M. Landis 在1962年提出的，所以 AVL来自于他们名字的简称。  
* 完美平衡：从上到下，除了最下面一层节点外，其他节点都有左右子节点。这是最理想的平衡状态。在实际中是比较难达到的。
* 不错的平衡：除了底层的节点外，其他节点都有左右子节点。这种状态是我们多数情况下能实现的最好的状态。
* 不平衡：除了底层的节点外，还有其他节点的子节点没有填满。这种状态的性能会很差。
## 平衡因子
二叉搜索树平衡的条件是树中所有节点的左子节点高度和右子节点高度的差的绝对值不大于1，我们把这个条件称为 balance factor，平衡因子  
## 左旋转
private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {  
    guard let pivot = node.rightChild else { return node }  
    node.rightChild = pivot.leftChild  
    pivot.leftChild = node  
    node.height = max(node.leftHeight, node.rightHeight) + 1  
    pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1  
    return pivot  
}  

* 把被旋转的节点(A)的右节点(B)作为轴，这个右节点最终将替代被旋转的节点作为根节点
* 被旋转的节点(A)的右节点更新为轴的左节点(X)
* 轴(B)的左节点更新为被旋转的节点(A)
* 最后更新被旋转节点和轴的高度
右旋转与左旋转类似，只不过是leftChild和rightChild对调了而已  

## 右左旋转
private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {  
    guard let rightChild = node.rightChild else { return node }  
    node.rightChild = rightRotate(rightChild)  
    return leftRotate(node)  
}  
左右旋转与右左旋转相反  

## 平衡的处理
我们已经写好了四种旋转的实现，下面根据平衡因子来决定何时调用哪一种旋转。  
* 平衡因子为2，意味着左边的节点比右边多，需要使用右旋转或者左右旋转。
* 平衡因子为-2，意味着右边的节点比左边多，需要使用左旋转或者右左旋转。

AVL树的自动平衡功能比较复杂，需要一定的时间去理解。它的效率很高，插入和移除操作的时间复杂度都是 O(log n)。AVL 树是第一个自动平衡的树结构，与 AVL 类似的树还有红黑树和伸展树  

### 示例
var tree = AVLTree<Int>()  
for i in 0...6 {  
    tree.insert(i)  
}  
print(tree)  

print("remove 3")  
tree.remove(3)  
print(tree)  

print("remove 5")  
tree.remove(5)  
print(tree)  

### 打印
 ┌───6  
┌───5  
| └───4  
3  
| ┌───2  
└───1  
 └───0  

remove 3  
 ┌───6  
┌───5  
4  
| ┌───2  
└───1  
 └───0  

remove 5  
┌───6  
4  
| ┌───2    
└───1  
 └───0  


