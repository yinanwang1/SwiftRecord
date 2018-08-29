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

    fileprivate let wahah: String = "我就是我 不一样的烟火"

    func adjust() {
        simpleDescription += "  Now 100% adjusted"
    }

    var response: String? = "sdfl"


    init() {
        // 构造
    }






    func testTest() -> Void {

        let value = ["test1": "12313", "test2": nil]


//        print(value)

        print(value["test2"] as Any)


    }

}

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}



























