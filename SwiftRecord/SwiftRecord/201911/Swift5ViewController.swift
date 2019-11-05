//
//  Swift5ViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2019/11/4.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class Swift5ViewController: UIViewController {
    
    typealias hideShowView = (Int) -> Void
    
    var muFunc: hideShowView?

    override func viewDidLoad() {
        super.viewDidLoad()

//        muFunc = {(number) in
//            print("wyn is \(number)")
//        }
//
//
//        muFunc!(123)
        
//        testMap()
        
//        testFlatMap()
        
//        testCompactMap()
//        testFilter()
        testReduce()
    }
    

//    func testMap() {
//        let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"]
//        func stringCount(string: String) -> Int {
//            return string.count
//        }
//
//        let result = stringArray.map(stringCount(string:))
//        let result1 = stringArray.map({ string -> Int in
//            return string.count
//        })
//        let result2 = stringArray.map {
//            return $0.count
//        }
//
//    }
    
//    func testFlatMap() {
//        let array = ["Apple", "Orange", "Puple", ""]
//        let arr1 = array.map { a -> Int? in
//            let length = a.count
//            guard length > 0 else {
//                return nil
//            }
//
//            return length
//        }
//
//        print("arr1 is \(arr1)") // [Optional(5), Optional(6), Optional(5), nil]
//
//        let arr2 = array.compactMap { a -> Int? in
//            let length = a.count
//            guard length > 0 else {
//                return nil
//            }
//
//            return length
//        }
//
//        print("arr2 is \(arr2)") // [5, 6, 5]
//    }
    
//    func testCompactMap() {
//        let array = [[1,2,3], [4,5,6], [7,8,9]]
//        let arr1 = array.map{$0}
//        print("arr1 is \(arr1)") // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
//
//        let arr2 = array.flatMap{$0}
//        print("arr2 is \(arr2)") // [1, 2, 3, 4, 5, 6, 7, 8, 9]
//
//        let arr3 = array.compactMap{$0}
//        print("arr3 is \(arr3)") // [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
//    }
    
//    func testCompactMap() {
//        let fruits = ["Apple", "Orange", "Puple"]
//        let counts = [2, 3, 5]
//
//        let array = counts.flatMap { count in
//            fruits.map({ fruit in
//                return fruit + " \(count)"
//
//            })
//        }
//
//        print("array is \(array)") // ["Apple 2", "Orange 2", "Puple 2", "Apple 3", "Orange 3", "Puple 3", "Apple 5", "Orange 5", "Puple 5"]
//
//        let array2 = counts.compactMap { count in
//            fruits.map({ fruit in
//                return fruit + " \(count)"
//
//            })
//        }
//
//        print("array2 is \(array2)") // [["Apple 2", "Orange 2", "Puple 2"], ["Apple 3", "Orange 3", "Puple 3"], ["Apple 5", "Orange 5", "Puple 5"]]
//    }
    
    func testFilter() {
        let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"]
        
        func stringCountLess10(string: String) -> Bool {
            return string.count < 10
        }
        
        let result = stringArray.filter(stringCountLess10(string:))
        print("result is \(result)") // ["Swift", "HTML", "CSS"]
        
        let result1 = stringArray.filter({string -> Bool in
            return string.count < 10
        })
        print("result1 is \(result1)") // ["Swift", "HTML", "CSS"]
        
        let result2 = stringArray.filter{
            return $0.count < 10
        }
        print("result2 is \(result2)") // ["Swift", "HTML", "CSS"]
    }
    
    func testReduce() {
        let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"]

        func appendString(string1: String, string2: String) -> String {
            return string1 == "" ? string2 : string1 + "、" + string2
        }

        let result = stringArray.reduce("", appendString(string1:string2:))
        print("result is \(result)") // Objective-C、Swift、HTML、CSS、JavaScript

        let result1 = stringArray.reduce("", {(string1, string2) -> String in
            return string1 == "" ? string2 : string1 + "、" + string2
        })
        print("result1 is \(result1)") // Objective-C、Swift、HTML、CSS、JavaScript

        let result2 = stringArray.reduce("", {
            return $0 == "" ? $1 : $0 + "、" + $1
        })
        print("result2 is \(result2)") // Objective-C、Swift、HTML、CSS、JavaScript
            }
}
