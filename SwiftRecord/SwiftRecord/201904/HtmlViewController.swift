//
//  HtmlViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2019/4/9.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit
import MediaPlayer

class HtmlViewController: UIViewController {

    @IBOutlet weak var htmlLabel: UILabel!

    private lazy var volumeView: MPVolumeView = {
        var volumeView = MPVolumeView.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        volumeView.backgroundColor = UIColor.yellow
        volumeView.isHidden = false
        volumeView.alpha = 0.01

        return volumeView
    }()
    private var volumeSlider: UISlider? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "世界那么大"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]

//        let html = "<strong>Dear Friend</strong> I hope this <i>tip</i> will be useful for <b>you</b>."
//        let attributedString = html.htmlAttributeString(with: "Futura", fontSize: 14, colorHex: "ff0000")
//
//        self.htmlLabel.attributedText = attributedString
//
//        testScanner()
//
//        addVolumeView()

//        testString()

//        testArray()

//        testStride()

//        testSlice()

//        testStringView()

        testSequence()
    }

    private func testSequence() {
        var arr = [Int]()

        for i in 0 ..< 20 {
            arr.append(i)
        }

        var arr1 = arr.prefix(5)
        arr1[1] = 5

        print("arr1 is \(arr1)")
        print("arr is \(arr)")
    }

    private func testStringView() {
        let cafe = "Cafe\u{301} du 🌍"

        print(cafe.unicodeScalars.count)

        print(cafe.unicodeScalars)

        print(cafe.unicodeScalars.map{$0.value})

        print(cafe.utf16.count)

        print(cafe.utf16)

        print(cafe.utf8.count)

        print(cafe.utf8)
    }

    private func testSlice() {
        var array: [Int] = []

        for i in 0..<1000 {
            array.append(i * Int(arc4random()))
        }

        let slice = array[100..<300]

        for item in slice {
            print("item is \(item)")
        }

        let result = slice.map {
            $0 * 2
            }.reduce(0) {
                $0 + $1
        }

        print(result)
    }

    private func testStride() {
//        _ = stride(from: 0, to: 3, by: 0.3)
        let array2 = stride(from: 0, through: 3, by: 0.3)

        for item in array2 {
            print("array is \(item)")
        }
    }

    private func testArray() {
        let user1 = User.init(name: "wang", age: 15)
        let user2 = User.init(name: "yi", age: 45)
        let user3 = User.init(name: "nan", age: 53)
        let user4 = User.init(name: "nan", age: 53)
        let user5 = User.init(name: "nan", age: 53)
        let user6 = User.init(name: "nan", age: 53)
        let user7 = User.init(name: "nan", age: 53)
        let user8 = User.init(name: "nan", age: 53)

        print("user1 \(user1.hashValue) && \(user1.hash)")
        print("user2 \(user2.hashValue) && \(user2.hash)")
        print("user3 \(user3.hashValue) && \(user3.hash)")
        print("user4 \(user4.hashValue) && \(user4.hash)")
        print("user5 \(user5.hashValue) && \(user5.hash)")
        print("user6 \(user6.hashValue) && \(user6.hash)")
        print("user7 \(user7.hashValue) && \(user7.hash)")
        print("user8 \(user8.hashValue) && \(user8.hash)")

        let array = [user1, user2, user3, user4, user5, user6, user7, user8]

        print("array is \(array)")

        print("array.contains(User.init(name: \"nan\", age: 53)) is \(array.contains(User.init(name: "nan", age: 53)))")
        print("array.contains(user1) is \(array.contains(user1))")
    }

    private func testString() {
        let content:NSString = "我 是 高 老 师 哦！"
        print(content.applyingTransform(StringTransform.toLatin, reverse: false) ?? "")
        print(content.applyingTransform(StringTransform.toLatin, reverse: false) ?? "")

    }

    private func addVolumeView() {
        for view in self.volumeView.subviews {
            print("view.classForCoder is %@", String(describing: view.classForCoder))
            if String(describing: view.classForCoder) == "MPVolumeSlider" {
                self.volumeSlider = view as? UISlider

                break
            }
        }

        print("self.volumeView is \(self.volumeView)")

        self.view.addSubview(self.volumeView)

        print("self.volumeSlider?.value is \(String(describing: self.volumeSlider?.value))")

        self.volumeSlider?.addTarget(self, action: #selector(updateSlider(slider:)), for: UIControl.Event.valueChanged)

        print("AVAudioSession.sharedInstance().outputVolume is \(AVAudioSession.sharedInstance().outputVolume)")

        NotificationCenter.default.addObserver(self, selector: #selector(volumeChanged(notification:)), name: NSNotification.Name.init("AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
    }

    @objc
    private func updateSlider(slider: UISlider) {
        print("slider.value is \(slider.value)")
    }

    @objc
    private func volumeChanged(notification: Notification) {
        let volume = notification.userInfo?["AVSystemController_AudioVolumeNotificationParameter"]

        print("volume is \(String(describing: volume))")
    }

    private func testScanner() {
        let originalStr = "131-0000-2222"
        var stripStr = ""
        let scanner = Scanner(string: originalStr)
        let numbers = CharacterSet(charactersIn: "0123456789")

        while scanner.isAtEnd == false {
            var buffer:NSString?
            if scanner.scanCharacters(from: numbers, into: &buffer) {
                stripStr.append(String(buffer ?? ""))
            } else {
                scanner.scanLocation = scanner.scanLocation + 1
            }
        }

        print("wyn stripStr is \(stripStr)")
    }



    
    @IBAction func clickedChangeIcon(_ sender: Any) {
        if #available(iOS 10.3, *) {
            if UIApplication.shared.supportsAlternateIcons {
                let iconName = "mogu"

                UIApplication.shared.setAlternateIconName(iconName) { (error) in
                    if nil != error {
                        print("设置失败")
                    } else {
                        print("设置成功")
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    

}

extension String {
    func htmlAttributeString(with fontName: String, fontSize: Int, colorHex: String) -> NSAttributedString? {
        do {
            let cssPrefix =  "<style>* { font-family: \(fontName); color: #\(colorHex); font-size: \(fontSize); }</style>"
            let html = cssPrefix + self
            guard let data = html.data(using: String.Encoding.utf8) else {
                return nil
            }

            return try NSAttributedString(data: data, options: [.documentType : NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue
                ], documentAttributes: nil)
        } catch {
            return nil
        }
    }
}

