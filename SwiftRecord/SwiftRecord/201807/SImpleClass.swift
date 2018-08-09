//
//  SImpleClass.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2018/8/6.
//  Copyright © 2018年 wang. All rights reserved.
//

import Foundation

protocol ExampleProtocol {
    var simpleDescription: String{get}

    mutating func adjust();
}


class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "一个简单的类"
    var anotherProperty: Int  = 69105
    func adjust() {
        simpleDescription += "  Now 100% adjusted"
    }


    func testTest() -> Void {

        testVar()
    }

    struct Resolution {
        var width = 0
        var height = 0
    }
    class VideoMode {
        var resolution = Resolution()
        var interlaced = false
        var frameRate = 0.0
        var name: String?
    }

    func testVar() -> Void {
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3);

        rangeOfThreeItems.firstValue = 3;

        print(rangeOfThreeItems)

    }
}


struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}








