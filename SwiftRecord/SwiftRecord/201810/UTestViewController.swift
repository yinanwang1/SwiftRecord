//
//  UTestViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2018/10/10.
//  Copyright © 2018 wang. All rights reserved.
//

import UIKit

class UTestViewController: UIViewController {

    @IBOutlet weak var myStepper: UIStepper!

    @IBOutlet weak var myProgressView: UIProgressView!

    var progress: Progress?;
    let completed:Int64 = 20



    override func viewDidLoad() {
        super.viewDidLoad()

        self.myStepper.addTarget(self, action: #selector(setupChange), for: UIControlEvents.valueChanged)

        self.initialProgressView()

//        self.sort()

//        self.testMap();

//        self.testFlatmap();

//        self.testFilter();

        self.testReduce();

    }


    @objc func setupChange() {
        print(self.myStepper.value)
    }

    @objc func task() {
        if self.progress!.completedUnitCount < completed {
            self.progress?.completedUnitCount += 1;
        }
    }


    func initialProgressView() {

        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(task), userInfo: nil, repeats: true)

        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
        self.progress = Progress.init(totalUnitCount: completed)

        self.progress?.addObserver(self, forKeyPath: "fractionCompleted", options: NSKeyValueObservingOptions.new, context: nil)


        self.myProgressView.observedProgress = self.progress
    }


    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        let per = (self.progress?.fractionCompleted ?? 0) * 100

//        print("完成百分比： " + String.init(describing: per));
    }


    func sort() {
        var myArr = ["34saldfj","sdfsaldfj","assaldfj","gsaldfj","dtsaldfj","ertsaldfj","sdfsaldfj",
                     "123saldfj","sdfsaldfj","fgsaldfj","wesaldfj","ertsaldfj","tysaldfj","tusaldfj",
                     "3saldfj","dgssaldfj","rtusaldfj","wetsaldfj","sdgsaldfj","ertsaldfj","tysaldfj",
                     "4saldfj","ertsaldfj","hsaldfj","dfgsaldfj","fgsaldfj","ertsaldfj","erysaldfj",
                     "asfsaldfj","saldfj","saldfj","saldfj","saldfj","saldfj","fgsaldfj",
                     "gsaldfj","saldfj","saldfj","saldfj","saldfj","saldfj","saldfj",
                     "assaldfj","saldfj","saldfj","saldfj","saldfj","saldfj","saldfj","saldfj",]

        myArr.sort { (a, b) -> Bool in
            return a < b
        }

        print("myArr is " + String.init(describing: myArr))
    }

    func testMap() {
        let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"];


        func stringCount(string: String) -> Int {
            return string.count;
        }

        let count1 = stringArray.map(stringCount);

        let count2 = stringArray.map { string -> Int in
            return string.count;
        }

        let count3 = stringArray.map {
            return $0.count;
        }

        print("count1 is \(count1), count2 is \(count2), count3 is \(count3)");

    }


    func testFlatmap() -> Void {
        let array = ["Apple", "Orange", "Puple", ""];

        let arr1 = array.map { a -> Int? in
            let length = a.count;
            guard length > 0 else {
                return nil;
            }

            return length;
        }

        print("arr1 is \(arr1)");

        let arr2 = array.compactMap { (a) -> Int? in
            let length = a.count;

            guard length > 0 else {
                return nil;
            }

            return length;
        }

        print("arr2 is \(arr2)");
    }

    func testFilter() -> Void {
        let stringArray = ["Objective-C", "Swift", "HTML", "JavaScript"];

        func stringCountLess10(string: String) -> Bool {
            return string.count < 10;
        }

        let result1 = stringArray.filter(stringCountLess10);

        let result2 = stringArray.filter { string -> Bool in
            return string.count < 10;
        }

        let result3 = stringArray.filter {
            return $0.count < 10;
        }

        print("result1 is \(result1), result2 is \(result2), result3 is \(result3)")
    }

    func testReduce() -> Void {
        // 将数组中的每个字符串用‘、’拼接
        let stringArray = ["Objective-C", "Swift", "HTML", "CSS", "JavaScript"]

        func appendString(string1: String, string2: String) -> String {
            return string1 == "" ? string2 : string1 + "、" + string2
        }

        // reduce方法中的第一个参数是初始值
        let result1 = stringArray.reduce("", appendString)

        let result2 = stringArray.reduce("", {(string1, string2) -> String in
            return string1 == "" ? string2 : string1 + "、" + string2
        })

        // $0表示计算后的结果, $1表示数组中的每一个元素
        let result3 = stringArray.reduce("", {
            return $0 == "" ? $1 : $0 + "、" + $1
        })

        print("result1 is \(result1),\n result2 is \(result2),\n result3 is \(result3)")
    }
    


}
