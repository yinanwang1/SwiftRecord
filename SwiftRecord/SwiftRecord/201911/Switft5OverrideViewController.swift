//
//  Switft5OverrideViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2019/11/7.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class Switft5OverrideViewController: UIViewController {
    
    var imageUrl: String

    init(imageUrl: String) {
        self.imageUrl = imageUrl

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.imageUrl = ""
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coder = NSCoder.init()
        print("coder is \(coder)")

        print("imageUrl is \(self.imageUrl)")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
