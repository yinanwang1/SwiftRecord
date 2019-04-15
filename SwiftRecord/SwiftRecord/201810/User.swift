//
//  User.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2018/10/10.
//  Copyright © 2018 wang. All rights reserved.
//

import UIKit

class User: NSObject {

    var name:String
    var age:Int

    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }

//    override func isEqual(_ object: Any?) -> Bool {
//        if object is User {
//            let tempUser = object as! User
//            if self.name == tempUser.name
//                && self.age == tempUser.age {
//                return true
//            } else {
//                return false
//            }
//        } else {
//            return false
//        }
//    }
//
//    override func hash(into hasher: inout Hasher) {
//        hasher = Hasher
//    }

}
