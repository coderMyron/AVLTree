//
//  ViewController.swift
//  AVLTree
//
//  Created by Myron on 2019/8/5.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }


}

