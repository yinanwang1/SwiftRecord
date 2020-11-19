//
//  Switft5OverrideViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2019/11/7.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit

class Switft5OverrideViewController: UIViewController, UINavigationControllerDelegate {
    
    var interactiveTransition: UIPercentDrivenInteractiveTransition?

    @IBOutlet weak var testButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let pan = UIPanGestureRecognizer.init()
        pan.addTarget(self, action: #selector(panGestureRecognizerAction(pan:)))
        self.view.addGestureRecognizer(pan)
        
        let testImage = UIImage.init(named: "test")
        
//        self.testImageView.image = testImage
        
        self.testButton.setBackgroundImage(testImage?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: UIControl.State.normal)
        self.testButton.tintColor = UIColor.orange
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.delegate = self
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationController.Operation.pop {
            return HSPopAnimation.init()
        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?
    {
        if animationController is HSPopAnimation {
            return self.interactiveTransition
        }
        
        return nil
    }
    
    @IBAction func onClickPopBtn(_ sender: Any) {
        print("123")
//        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    private func panGestureRecognizerAction(pan: UIPanGestureRecognizer) {
        var process = pan.translation(in: self.view).x / UIScreen.main.bounds.size.width
        process = min(1.0, max(0.0, process))
        
        print("process is \(process)")
        
        if pan.state == UIPanGestureRecognizer.State.began {
            print("began")
            self.interactiveTransition = UIPercentDrivenInteractiveTransition.init()
            
            self.navigationController?.popViewController(animated: true)
        } else if pan.state == UIPanGestureRecognizer.State.changed {
            print("changed")
            self.interactiveTransition?.update(process)
        } else if pan.state == UIPanGestureRecognizer.State.ended || pan.state == UIGestureRecognizer.State.cancelled {
            print("ended")
            if process > 0.3 {
                self.interactiveTransition?.finish()
            } else {
                self.interactiveTransition?.cancel()
            }
            
            self.interactiveTransition = nil
        }
    }

}
