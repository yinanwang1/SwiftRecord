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

//        let html = "<strong>Dear Friend</strong> I hope this <i>tip</i> will be useful for <b>you</b>."
//        let attributedString = html.htmlAttributeString(with: "Futura", fontSize: 14, colorHex: "ff0000")
//
//        self.htmlLabel.attributedText = attributedString
//
//        testScanner()
//
//        addVolumeView()
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

        self.volumeSlider?.addTarget(self, action: #selector(updateSlider(slider:)), for: UIControlEvents.valueChanged)

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

