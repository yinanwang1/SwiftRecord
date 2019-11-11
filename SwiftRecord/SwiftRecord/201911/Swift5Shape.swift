//
//  Swift5Shape.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2019/11/6.
//  Copyright © 2019 wang. All rights reserved.
//

import Foundation

class SwiftShape: ExamplePotocol {
    
    private(set) var numberOfEdits = 0
    
    
    var simpleDescription: String {
        return "getget"
    }
    
    func adjust() {
        print("wa123456")
    }
    
    var numberOfSides = 0
    var name: String
    var sideLength: Double = 0.0 {
        willSet {
            print("willSet")
        }
        
        didSet {
            print("是的的")
        }
    }
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        
        set {
            sideLength = newValue / 3.0
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
}

protocol ExamplePotocol {
    var simpleDescription: String {
        get
    }
    
    mutating func adjust()
}

class Tools {
    class func sharedInstance() -> Tools {
        struct Static {
            static let sharedInstance = Tools()
        }
        
        return Static.sharedInstance
    }
}
