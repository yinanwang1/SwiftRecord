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
    var myProperty: String = "wang"
    var name: String?
    var text: String? = "text"
    lazy var asHtml: () -> String = { [unowned self] in
        if let text = self.text {
            return "<\(String(describing: self.name))>\(text)</\(String(describing: self.name))>"
        } else {
            return "<\(String(describing: self.name)) />"
        }
    }
    var fridgeContent: [String]?
    

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
//        testReduce()
        test()
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
            print("string1 is \(string1)")
            print("string2 is \(string2)")
            return string1 == "" ? string2 : string1 + "、" + string2
        })
        print("result1 is \(result1)") // Objective-C、Swift、HTML、CSS、JavaScript

        let result2 = stringArray.reduce("", {
            return $0 == "" ? $1 : $0 + "、" + $1
        })
        print("result2 is \(result2)") // Objective-C、Swift、HTML、CSS、JavaScript
        
        print("result2.length is \(result2.count)")
    }
    
    func test() {
//        let implicityionDouble: Double = 70
//        let string = String(implicityionDouble)
//        let wang = Wang()
//
//        var shoppingList = ["123123", "1321414", "14124124"]
//        print(shoppingList)
//
//        shoppingList[1] = "boottle"
//        print(shoppingList)
//
//        var occupations = [
//            "Malcolm": "Captain",
//            "Kayleee": "Mechanic"
//        ]
//        print(occupations)
//        occupations["Jayne"] = "Public test"
//        print(occupations)
        
//        _ = [String]()
//        _ = Dictionary<String, Float>()
//        var test = [String: Float]()
//        test["你好啊"] = 1111.0
//
//        print(test)
        
//        for i in 0..<10 {
//            print(i)
//        }
//        let (a, b, c) = getGasPrice()
//        print("a is \(a), b is \(b), c is \(c)")
        
//        let sum = sumOf(numbers: 1, 5, 6, 7)
//        print(sum)
        
//        let shape = SwiftShape(name: "你说啥")
//        shape.numberOfSides = 7
//        shape.adjust()
//        let shapeDescription = shape.simpleDescription
//        print(shapeDescription)
//        shape.perimeter = 1000
//        print(shape.perimeter)
//        print(shape.sideLength)
        
//        let ace = Rank.Jack
//        let aceRawValue = ace.rawValue
//
//        let temp = Rank.init(rawValue: 5)
//        print("temp is \(temp?.simpleDescription() ?? "")")
//        print("ace is \(ace)")
//        print("aceRawValue is \(aceRawValue)")
//        print(ace.simpleDescription())
        
//        let threeOfSpades = Card(rank: .Three, suit: .Spades)
//        let threeOfSpadesDescription = threeOfSpades.simpleDescription()
//        print(threeOfSpadesDescription)
        
//        var gene = Extension()
//        print(gene.repeatTemp(item: "knock", times: 5))
        
//        print("\(#file) \(#line) \(#column) \(#function)")
        
//        let minuteInterval = 5
//        for tricMark in stride(from: 0, to: 100, by: minuteInterval) {
//            print("111 \(tricMark)")
//        }
        
//        var x: Int32 = 2147483647
//        var y = x + 10
//        print("wyn y is \(y)")
        
//        DispatchQueue.main.async {
//            print("说说啥啊")
//        }
        
//        self.name = "Arthur"
//
//        if let myName = self.name {
//            print("myName is \(myName)")
//        } else {
//            print("I have no name.")
//        }
        
//        testGuard()
//        myProperty = "b改变了啊"
//        print("my property is \(myProperty)")
//        testDate()
        
//        let date1 = datePrase(year: 2015, month: 1, day: 1, hour: 1, minute: 1, sec: 1)
//        let date2 = datePrase(year: 2015, month: 2, day: 2, hour: 2, minute: 2, sec: 2)
//
//        let dateComponents = diff(date1: date1, date2: date2)
//        print("dateComponents.year is \(dateComponents.year)")
//        print("dateComponents.month is \(dateComponents.month)")
//        print("dateComponents.day is \(dateComponents.day)")
//        print("dateComponents.hour is \(dateComponents.hour)")
//        print("dateComponents.minute is \(dateComponents.minute)")
//        print("dateComponents.second is \(dateComponents.second)")
        
//        let sum = 3
//        print("sum i s\(sum), sum double is \(Double(sum) * 2.5)")
//        let unicode = "\u{1F496}"
//        print("unicode is \(unicode)")
        
//        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
//        for (animalName, legCount) in numberOfLegs {
//            print("\(animalName)s have \(legCount) legs")
//        }
        
//        let yetAnotherPoint = (1, -1)
//        switch yetAnotherPoint {
//        case let (x, y) where x == y:
//            print("\(x), \(y) is on the line x == y")
//        case let (x, y) where x == -y:
//            print("\(x), \(y) is on the line x == -y")
//        case let (x, y):
//            print("\(x), \(y) is just some arbitrary point")
//        default:
//            print("I am default!")
//        }
        
//        let http200Status = (statusCode: 200, desc: "OK")
//        print("\(http200Status.statusCode)")
        
//        do {
//            try print("name is \(canThrowErrors(name: "wan1g"))")
//        } catch NetError.cloudy {
//            print("cloudy")
//        } catch {
//            print("all")
//        }
        
//        swapTwoInts(a: &someInt, b: &anotherInt)
//        print("a is \(someInt), b is \(anotherInt)")
        
//        for i in 0...10 {
//            print("i is \(i)")
//        }
        
//        let options: NSStringDrawingOptions = .usesLineFragmentOrigin
    }
    
    struct Point {
        var x = 0, y = 0
        
        mutating func moveXBy(x: Int, y : Int) {
            self.x += x
            
            self.y += y
        }
    }
    
    var someInt = 3
    var anotherInt = 107

    func swapTwoInts(a: inout Int, b: inout Int) {
        a = 107
        b = 3
    }
    
    func fridgeContains(itemName: String) -> Bool {
        var fridgeOpen = true
        defer {
            fridgeOpen = false
        }
        
        return fridgeContent?.contains(itemName) ?? false
    }
    
    func canThrowErrors(name: String) throws -> String {
        if name == "wang" {
            return "right"
        }
        
        throw NetError.cloudy
    }
    
    func datePrase(year: Int, month: Int, day: Int, hour: Int, minute: Int, sec: Int) -> Date {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        c.hour = hour
        c.minute = minute
        c.second = sec
        
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let date = gregorian?.date(from: c as DateComponents)
        
        return date!
    }
    
    func diff(date1: Date, date2: Date) -> NSDateComponents {
        let gregorian = NSCalendar(identifier: NSCalendar.Identifier.gregorian)
        let c1 = gregorian?.components(in: TimeZone.current, from: date1)
        let c2 = gregorian?.components(in: TimeZone.current, from: date2)
        
        let c = NSDateComponents()
        if nil == c1 || nil == c2 {
            return c
        }
        
        c.year = (c2?.year)! - (c1?.year)!
        c.month = (c2?.month)! - (c1?.month)!
        c.day = (c2?.day)! - (c1?.day)!
        c.hour = (c2?.hour)! - (c1?.hour)!
        c.minute = (c2?.minute)! - (c1?.minute)!
        c.second = (c2?.second)! - (c1?.second)!
        
        return c
    }
    
    func testDate() {
        let date1 = NSDate()
        let date2 = NSDate()
        
        let result = date1.compare(date2 as Date)
        
        switch result {
        case ComparisonResult.orderedAscending:
            print("date1 < date2")
            
        case ComparisonResult.orderedDescending:
            print("date1 > date2")
            
        case ComparisonResult.orderedSame:
            print("date1 == date2")
            
        default:
            print("default")
        }
    }
    
    func testGuard() {
        let person: [String: String?] = ["id": "123123"]
        guard person["id"] != nil else {
            print("这是nilllllll")
             return
        }
        
        guard person["examNumber"] != nil else {
            print("空空空空空空")
            return
        }
        
        print("It is over!")
    }
    
    func getGasPrice() -> (Double, Double, Double) {
        return (3.59, 3.68, 3.89)
    }
    
    func sumOf(numbers: Int...) -> Int {
        var sum = 0
        for number in numbers {
            sum += number
        }
        
        return sum
    }
}

class Extension {
    func repeatTemp<ItemType> (item: ItemType, times: Int) -> [ItemType] {
        var result = [ItemType]()
        for _ in 0..<times {
            result.append(item)
        }
        
        return result
    }
}


enum NetError: Error {
    case sunshine
    case cloudy
    case rainy
    case snow
}

enum Rank: Int {
    case Ace = 1
    case Two, Three, Four, Five
    case Jack, Queen, King
    
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
            
        
            
        default:
            return String(self.rawValue)
        }
    }
}

enum Suit: Int {
    case Spades
}

struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "哇哈哈"
    }
}



