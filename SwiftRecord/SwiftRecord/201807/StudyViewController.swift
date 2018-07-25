//
//  StudyViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2018/7/23.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit

typealias Testtest = Int

class StudyViewController: UIViewController {

    enum TestEnum {
        case testEnum0
        case testEnum1
    }

    enum BarCode {
        case upc(Int, Int, Int, Int)
        case qrCode(String)
    }


    struct Point {
        var x = 0, y = 0

        mutating func moveXBy(x:Int, yBy y:Int) -> Void {
            self.x += x
            self.y += y
        }
    }

    // MARK: - 你好啊

    override func viewDidLoad() {
        super.viewDidLoad()

        test1();

        test2();

        let value = getList(arr: [12,123,123,123,123, 1 ,0], pre: {(s:Int) in return s > 2});
        print("getList is \(value))")

        getTestEnum();

        testBarcode()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func test1() -> Void {
        let i:Testtest = 0x1010;

        print("test \(i)");

        let (x, y) = (1, 2)

        print("x is \(x), y is \(y)")

        let maxFloat:CGFloat = CGFloat(MAXFLOAT);

        print("maxFloat is \(maxFloat)");

        self.navigationItem.title = "不错不错 very good"

        //设置导航栏颜色
        let mainColor = UIColor(red: 0.92, green: 0.25, blue: 0.24, alpha: 1);
        self.navigationController?.navigationBar.barTintColor = mainColor
        self.navigationController?.navigationBar.tintColor = UIColor.white

        //设置标题颜色
        let navigationTitleAttribute = NSDictionary(object: UIColor.white, forKey: NSAttributedStringKey.foregroundColor as NSCopying);
        self.navigationController?.navigationBar.titleTextAttributes = navigationTitleAttribute as? [NSAttributedStringKey : Any];

        let reuslt = test(haha: 12);

        print("result is \(reuslt)");
    }


    func test(haha:Int) -> Int {
        return 8
    }

    private func test2() -> Void {
        let array1 = [1, 2, 3];

        print("array1.count is \(array1.count)");

        print("array1.capacity is \(array1.capacity)");

    }

    func getList(arr:[Int], pre:(Int)->Bool) -> [Int] {
        var tempArr = [Int]()

        for temp in arr {
            if (pre(temp)) {
                tempArr.append(temp)
            }
        }

        return tempArr
    }

    func getTestEnum() -> Void {
        let valueEnum = TestEnum.testEnum0

        switch valueEnum {
        case .testEnum0:
            print("I am testEnum0")

        case .testEnum1:
            print("I am testEnum1")
        }

    }

    private func testBarcode() -> Void {
        var productBarcode = BarCode.upc(1, 23, 14, 13)
        productBarcode = .qrCode("wahahhaha 你急速按收费了")

        switch productBarcode {
        case .upc(let number1, let number2, let number3, let number4):
            print("productBarcode is \(number1), \(number2), \(number3), \(number4)");

        case .qrCode(let string1):
            print("productBarcode is \(string1)")

        }
    }


    enum ASCIIControlCharacter: Character {
        case tab = "\t"
        case lineFeed = "\n"
        case carriageReturn = "\r"
    }

    /*
        /*
            你好啊！！！！
        */
     */
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
