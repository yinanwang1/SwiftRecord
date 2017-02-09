//
//  FoodfillViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2017/2/9.
//  Copyright © 2017年 wang. All rights reserved.
//

import UIKit

class FoodfillViewController: UIViewController {
    
    @IBOutlet weak var foodfillTextView: UITextView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var array = [[Int]]();
    var total:Int = 0;
    
    let row = 5
    let column = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialFoodfillTextView()
    }
    
    // MARK:- Target Methods

    @IBAction func onClickStartBtn(_ sender: Any) {
        total = 0;
        
        for i in 0..<row
        {
            for j in 0..<column
            {
                if 2 == array[i][j] {
                    array[i][j] = 1
                }
            }
        }
        
        calc()
    }

    // MARK:- Foodfill Methods
    
    func initialFoodfillTextView() -> Void
    {
        let array = createFoodfillArray();
        
        var foodfillStr = "";
        
        for i in 0..<row
        {
            for j in 0..<column
            {
                foodfillStr += String(array[i][j]) + " "
            }
            
            foodfillStr += "\r\n"
        }
        
        foodfillTextView.text = foodfillStr
    }
    
    func createFoodfillArray() -> [[Int]]
    {
        for _ in 0..<row
        {
            var columnArray = [Int]()
            for _ in 0..<column
            {
                let value:Int = (Int)(arc4random() % 2);
                
                columnArray.append(value);
            }
            
            array.append(columnArray)
        }
        
        return array;
    }
    
    func calc() -> Void {
        for i in 0..<row
        {
            for j in 0..<column
            {
                if (1 == array[i][j])
                {
                    markIsland(index: (i, j))
                    
                    total += 1
                }
            }
        }
        
        resultLabel.text = String(total)
    }
    
    func markIsland(index:(Int, Int)) -> Void {
        
        print(index)
        
        array[index.0][index.1] = 2
        
        // 上
        let up = index.0 - 1;
        if (0 <= up) && (1 == array[up][index.1]) {
            markIsland(index: (up, index.1))
        }
        
        // 下
        let down = index.0 + 1;
        if (row > down) && (1 == array[down][index.1]) {
            markIsland(index: (down, index.1))
        }
        
        // 左
        let left = index.1 - 1;
        if (0 <= left) && (1 == array[index.0][left]) {
            markIsland(index: (index.0, left))
        }
        
        // 右
        let right = index.1 + 1;
        if (column > right) && (1 == array[index.0][right]) {
            markIsland(index: (index.0, right))
        }
    }

}
