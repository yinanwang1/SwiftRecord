//
//  Swift5ViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2019/11/4.
//  Copyright © 2019 wang. All rights reserved.
//

import UIKit



class Swift5ViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet weak var greenView: UIView!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var testImageView: UIImageView!
    var times: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIApplication.shared.windows.last?.tintColor = UIColor.red
        
        
        let image = UIImage.init(named: "avatar")
        let insets = UIEdgeInsets.init(top: 25, left: 10, bottom: 25, right: 10)
        
        if let imageTemp = image {
//            self.testImageView.image = imageTemp.resizableImage(withCapInsets: insets, resizingMode: UIImage.ResizingMode.stretch)
            
            let left = (image?.size.width ?? 0) * 0.5
            let right = (image?.size.height ?? 0) * 0.5
            self.testImageView.image = image?.stretchableImage(withLeftCapWidth: Int(left), topCapHeight: Int(right))
        }
    
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.delegate = self
    }
    
    @IBAction func onClickMeBtn(_ sender: Any) {
        
    }
    
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == UINavigationController.Operation.push {
            return HSPushAnimation.init()
        }
        
        return nil
    }
    
    


}





