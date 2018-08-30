//
//  LottieViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2018/8/30.
//  Copyright © 2018年 wang. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {

    var animationView: LOTAnimationView = LOTAnimationView(name: "SpinnerSpin");

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup our animaiton view
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: 20, y: 20, width: 200, height: 200)

        self.view.addSubview(animationView)
        // Lets change some of the properties of the animation
        // We arent going to use the MaskLayer, so lets just hide it
        animationView.setValue(0, forKeypath: "MaskLayer.Ellipse 1.Transform.Opacity")
        // All of the strokes and fills are white, lets make them DarkGrey
        animationView.setValue(UIColor.darkGray, forKeypath: "OuterRing.Stroke.Color")
        animationView.setValue(UIColor.darkGray, forKeypath: "InnerRing.Stroke.Color")
        animationView.setValue(UIColor.darkGray, forKeypath: "InnerRing.Fill.Color")

        // Lets turn looping on, since we want it to repeat while the image is 'Downloading'
        animationView.loopAnimation = true
        // Now play from 0 to 0.5 progress and loop indefinitely.
        animationView.play(fromProgress: 0, toProgress: 0.5, withCompletion: nil)

        // Lets simulate a download that finishes in 4 seconds.
        let dispatchTime = DispatchTime.now() + 4.0
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.simulateImageDownloaded()
        }
    }

    

    func simulateImageDownloaded() {
        // Our downloaded image
        let image = UIImage(named: "avatar")
        let imageView = UIImageView(image: image)

        // We want the image to show up centered in the animation view at 150Px150P
        // Convert that rect to the animations coordinate space
        // The origin is set to -75, -75 because the origin is centered in the animation view
        let imageRect = animationView.convert(CGRect(x: -75, y: -75, width: 150, height: 150), toKeypathLayer: LOTKeypath.init())

        // Setup our image view with the rect and add rounded corners
        imageView.frame = imageRect
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageRect.width / 2;

        // Now we set the completion block on the currently running animation
        animationView.completionBlock = { (result: Bool) in ()
            // Add the image view to the layer named "TransformLayer"
            self.animationView.addSubview(imageView, toKeypathLayer: LOTKeypath(string: "TransformLayer"))
            // Now play the last half of the animation
            self.animationView.play(fromProgress: 0.5, toProgress: 1, withCompletion: { (complete: Bool) in
                // Now the animation has finished and our image is displayed on screen
                print("Image Downloaded and Displayed")
            })
        }

        // Turn looping off. Once the current loop finishes the animation will stop
        // and the completion block will be called.
        animationView.loopAnimation = false
    }

}
