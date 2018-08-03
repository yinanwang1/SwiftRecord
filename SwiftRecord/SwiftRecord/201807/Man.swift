//
//  Man.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2018/7/26.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

class Man: NSObject {

    var value: Int;
    var value2: Int;

    var manD: Int = 200 {
        didSet {
            print("manD didSet olderValue is \(oldValue), manD is \(manD)");
        }

        willSet {
            print("manD willSet manD is \(manD), newValue is \(newValue)");
        }
    }


    override init() {
        value = 5;
        value2 = 6;
    }


    func printMan() -> Void {
        print("printMan wahaha");
    }

    class func canSendAttachments() -> Void {
        print("canSendAttachments")
    }

    class func testGuard() -> Void {
        var person: [String:String?] = ["id":"123123", "examNumber":"12313"]

        guard person["id"] != nil else {
            print("这个是啥啊");

            return;
        }

        guard person["examNumber"] != nil else {
            print("你啥都没有啊")

            return;
        }


        print("就这样吧")

        if #available(iOS 9, *) {
            print("wahaha iOS 9")
        } else {
            print("wahaha iOS other ")
        }
    }


    class func swapTwoInts(a:inout Int, b:inout Int) -> Void {
        a = 107;
        b = 3;
    }


    class func testPrint() {
        let dictionary = ["firstName":"Mango", "lastName": "Fang"]

        for (key, value) in dictionary {
            print(key + "  " + value);
        }
    }

}



















