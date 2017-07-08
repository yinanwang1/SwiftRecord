//
//  MethodOfExhuastionViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2017/6/30.
//  Copyright © 2017年 wang. All rights reserved.
//

import UIKit

class MethodOfExhuastionViewController: UIViewController {

    private let MAGIC_SQUARE = 4;
    private let beginTime = Date.init().timeIntervalSince1970;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let result = Array<Int>.init();
        var possibility = Array<Int>.init();
        
        for index in 0..<(MAGIC_SQUARE * MAGIC_SQUARE)
        {
            possibility.append(index)
        }
        
        
        print("beginTime is \(beginTime)")
        
        methodOfExhuastion(result: result, possibility: possibility)
    }
    
    func methodOfExhuastion(result:Array<Int>, possibility:Array<Int>) -> Void {
        
        if 0 >= possibility.count {
            print("result is \(result)")
            
            let nowTime = Date.init().timeIntervalSince1970
            
            let usingTime = nowTime - beginTime;
            
            print("usingTime is \(usingTime)")
            
            return;
        }
        
        for index in 0..<possibility.count
        {
            let number = possibility[index];
            var tempResult = Array<Int>.init(result);
            tempResult.append(number);
            
            var tempPossibility = Array<Int>.init(possibility);
            tempPossibility.remove(at: index);
            
            methodOfExhuastion(result: tempResult, possibility: tempPossibility);
        }
    }

    
}
