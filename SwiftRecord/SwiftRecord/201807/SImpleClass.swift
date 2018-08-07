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
//        print("I am here")

        testVar()
    }

    func testVar() -> Void {
        let paddedDouble = 0000123.456
        print(paddedDouble)

        let oneMillion = 1_000_000
        print(oneMillion)

        let justOverOneMilloin = 1000_000.000_000_1
        print(justOverOneMilloin)


    }



}


struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "一个简单的结构体"
    mutating func adjust() {
        simpleDescription += "   (adjusted)"
    }
}





