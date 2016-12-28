//
//  ViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2016/12/27.
//  Copyright © 2016年 wang. All rights reserved.
//

import UIKit

let minPadding:CGFloat = 10
let maxPadding:CGFloat = 300

class ViewController: UIViewController
{
    @IBOutlet weak var ballLabel: UILabel!
    @IBOutlet weak var ballLabelTopLayout: NSLayoutConstraint!
    @IBOutlet weak var displayView: DisplayView!
    
    private var status:Bool = false
    private var changeFrame:Bool = false
    
    private var timer:CADisplayLink?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.ballLabel.layer.masksToBounds = true
        self.ballLabel.layer.cornerRadius  = 21.0
        
        self.displayView.ballLabel = self.ballLabel;
    }

    
    // MARK: Target Methods
    
    @IBAction func onClickQuickBtn(_ sender: Any)
    {
        if (self.status)
        {
            return;
        }
        
        self.status = true;
        
        if (minPadding == self.ballLabelTopLayout.constant)
        {
            self.ballLabelTopLayout.constant = maxPadding
        } else {
            self.ballLabelTopLayout.constant = minPadding
        }
        
        UIView.animate(withDuration: 2,
                       delay: 0.0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.1,
                       options: UIViewAnimationOptions.curveEaseInOut,
                       animations: {
                        self.view.layoutIfNeeded()
        }) { (complication:Bool) in
            if (complication) {
                print("complication is true")
            } else {
                print("complication is false")
            }
            
            self.timer?.invalidate()
            self.timer = nil
            
            self.status = false;
        }
        
        self.timer = CADisplayLink.init(target: self, selector: #selector(drawBezierPath))
        self.timer?.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    @objc private func drawBezierPath() -> Void
    {
        self.displayView.setNeedsDisplay()
    }
    
    
    
}

