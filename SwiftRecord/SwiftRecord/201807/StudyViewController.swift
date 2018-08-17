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

    let  simpleClass:SimpleClass = SimpleClass()

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

//    enum Rank: Int {
//        case Ace = 1
//        case Two, Three, Four, Five
//        case Jack, Queen, King
//    }
//
//    struct Card {
//        var rank:Rank
//    }

    // MARK: - 你好啊

    override func viewDidLoad() {
        super.viewDidLoad()

        initialNavigationBar();

//        test1();
//
//        test2();
//
//        let value = getList(arr: [12,123,123,123,123, 1 ,0], pre: {(s:Int) in return s > 2});
//        print("getList is \(value))")
//
//        getTestEnum();
//
//        testBarcode()
//
//        testEqual();
        
//        Man.testGuard()

//        var someInt = 3
//        var anotherInt = 107
//
//        Man.swapTwoInts(a: &someInt, b: &anotherInt);
//
//        print("someInt is \(someInt), anotherInt is \(anotherInt)");

//        Man.testPrint()

//        testLable();

//        testOPeration()
//
//        testDelay()

//        testTunple()

//        testLabel()

//        testDic()

//        testDidSet();

//        testIfLet();

//        testMultiLines()

//        testBlock();

//        loadData { (result) in
//            print("获取json信息\(result)")
//        }

//        testRank();

//        testEnum();

//        testSimpleClass()

//        testError()

//       let result = makeArray(repeating: "knock", numberOfTimes: 5)
//        print("result is \(result)")

//        testWrapped()

        simpleClass.testTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initialNavigationBar() {
        let rightBarBtn:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action:#selector(StudyViewController.testDelay))

        self.navigationItem.rightBarButtonItem = rightBarBtn;
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


    private func testEqual() {
        let man:Man = Man();
        var man2:Man = Man();

//        man.value = 5
//        man2.value = 6

        man2 = man

        if man2 === man {
            print("testEqual equal")
        } else {
            print("testEqual don't equal")
        }

        let maxFloat:CGFloat = CGFloat(MAXFLOAT)

        print("maxFloat is \(maxFloat)")

        Man.canSendAttachments();

        man2.printMan()

    }


    func testLable() {
        let label:UILabel = UILabel(frame: CGRect.init(x: 50, y: 50, width: 100, height: 100))
        label.backgroundColor = UIColor.green
        label.textAlignment = .center
        label.text = "wang"

        self.view.addSubview(label)
    }


    func testOPeration() -> Void {
        let nickName:String? = nil
        let fullName: String = "Arthur Wang"
        let informalGreeting = "Hi\(nickName ?? fullName)"

        print(informalGreeting)
    }

    @objc func testDelay() {
        delay(1.0) {
            UIScreen.main.brightness = 1.0
        }
    }

    func delay(_ delay:Double, closure:@escaping ()->()) {
        UIScreen.main.brightness = 0.5

        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }

    func testTunple() {
        let http404Error = (404, "Not Found")
        let (_, _) = http404Error

        print(http404Error.0)

        let http200Error = (statusCode:200, statusMessage:"OK")
        print(http200Error.statusCode)
    }

    func testLabel() -> Void {
        let score = [96, 83, 43, 101, 66, 70, -5, 99];
        First: for s in score {
            switch s/10
            {
            case 10:
                continue First

            case 9:
                print("\(s) 分为优秀")

            case 8:
                print("\(s) 分为良好")

            case 7:
                print("\(s) 分为中等")

            case 0:
                break First

            default:
                print("\(s) 分没有几个")
            }
        }
    }

    func testDic() -> Void {
//        var ages = ["Peter": 23, "Wei": 35, "Anish": 65, "Katya": 19]
//        var copiedAges = ages
//        copiedAges["Peter"] = 24
//        print(ages["Peter"] ?? 0)

//        var a = [1, 2, 3]
//        var b = a
//        var c = a
//
//        a[0] = 42
//        print(a[0])
//        print(b[0])
//        print(c[0])

        let sparklingHeart = "\u{1F496} 🐮 🦋"
        print(sparklingHeart)
    }

    func testDidSet() -> Void {
        let man = Man();

        man.manD = 5;

        man.manD = 6;

        man.manD = 7;

        man.manD = 8;

    }

    func testIfLet() -> Void {
        let name:String? = "老王"
        let age:Int? = 10

        if name != nil && age != nil {
            print(name! + String(age!))
        }

        if let nameNew = name, let ageNew = age {
            print(nameNew + String(ageNew))
        }
    }

    func testMultiLines() -> Void {
        let apples = 3;
        let oranges = 5;

        let quotation = """
            I said "I have \(apples) apples"
            And then I said "I have \(apples + oranges) pieces of fruit."

            // 这么厉害啊！！！
            """

        print("quotation is \(quotation)")
    }


    func testBlock() -> Void {
        let countNum = {(num1:Int, num2:Int) -> Int in
            return num1 + num2;
        };

        let count1 = countNum(2, 3);

        print(count1)
    }


    func loadData(completion: @escaping (_ result: [String]) -> ()) -> Void {
        DispatchQueue.global().async {
            print("耗时操作\(Thread.current)")
        }

        Thread.sleep(forTimeInterval: 1.0)
        let json = ["12", "34", "56"]

        DispatchQueue.main.async {
            print("主线程\(Thread.current)")

            completion(json)
        }

    }


    enum Rank: Int {
        case ace = 1
        case two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king
        func simpleDescription() -> String {
            switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            case .ten:
                return "真的是这样的吗"
            default:
                return String(self.rawValue)
            }
        }
    }

    func testRank() -> Void {
        let ace = Rank.ten
        let aceRawValue = ace.rawValue

        print("ace is \(ace.simpleDescription()), aceRawValue is \(aceRawValue)")
    }

    enum ServerResponse {
        case result(String, String)
        case failure(String)
    }

    func testEnum() -> Void {
        let success = ServerResponse.result("6:00 am", "8:09 pm")
        let failure = ServerResponse.failure("Out of cheese.")

        switch success {
        case let .result(sunrise, sunset):
            print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
        case let .failure(message):
            print("Failure...  \(message)")
        }

        switch failure {
        case let .result(sunrise, sunset):
            print("Sunrise is at \(sunrise) and sunset is at \(sunset)")
        case let .failure(message):
            print("Failure...  \(message)")
        }
    }


    func testSimpleClass() -> Void {

    }


    enum PrinterError: Error {
        case outOfPaper
        case noToner
        case onFire
    }

    func testError() -> Void {
        do {
            let printerResponse = try send(job: 1040, toPrinter: "Never Has Toner")
            print(printerResponse)
        } catch PrinterError.onFire {
            print("I'll just put this over here, with the rest of the fire.")
        } catch PrinterError.noToner {
            print("我就是我，不一样的烟火")
        } catch let printerError as PrinterError {
            print("Printer error: \(printerError)")
        } catch {
            print(error)
        }
    }

    func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }

        return "Job sent"
    }

    func makeArray<Item>(repeating item:Item, numberOfTimes: Int) -> [Item] {
        var result = [Item]()

        for _ in 0..<numberOfTimes {
            result.append(item)
        }

        return result
    }

    enum OptionalValue<Wrapped> {
        case none
        case some(Wrapped)
    }

    func testWrapped() -> Void {
        var possibleInteger: OptionalValue<Int> = .none
        print("possibleInteger is \(possibleInteger)")
        possibleInteger = .some(100)
        print("possibleInteger is \(possibleInteger)")
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
