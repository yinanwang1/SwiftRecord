//
//  SwiftRecordTests.swift
//  SwiftRecordTests
//
//  Created by ArthurWang on 2018/10/10.
//  Copyright © 2018 wang. All rights reserved.
//

import XCTest

@testable import SwiftRecord

class SwiftRecordTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testUser() {
        let user1 = User.init(name: "haha", age: 20)
        let user2 = User.init(name: "waha", age: 21)

        XCTAssert(user1.name == user2.name, "我就是我，不一样的烟火")
    }

}
