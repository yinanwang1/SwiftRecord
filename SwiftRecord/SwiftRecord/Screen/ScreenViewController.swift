//
//  ScreenViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2017/1/4.
//  Copyright © 2017年 wang. All rights reserved.
//

import UIKit

class ScreenViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.isIdleTimerDisabled = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func sliderChanged(_ sender: UISlider)
    {
        UIScreen.main.brightness = CGFloat(sender.value);
    }
}
