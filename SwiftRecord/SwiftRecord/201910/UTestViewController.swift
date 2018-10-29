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

        self.sort()

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
    


}
