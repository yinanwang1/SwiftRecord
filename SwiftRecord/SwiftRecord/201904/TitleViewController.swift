//
//  TitleViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2019/4/12.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "我想出去走走"

        if #available(iOS 11.0, *) {
            self.view.backgroundColor = UIColor.init(named: "MainColor")
        } else {
            // Fallback on earlier versions
        }
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
