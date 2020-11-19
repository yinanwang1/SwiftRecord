//
//  HSPushAnimation.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2020/11/18.
//  Copyright © 2020 wang. All rights reserved.
//

import UIKit

class HSPushAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // from
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        // to
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let toView: UIView? = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let fromView: UIView? = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        
        transitionContext.containerView.addSubview(toView!)
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        toView?.frame = CGRect.init(x: width, y: 0, width: width, height: height)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext)) {
            toView?.frame = CGRect.init(x: 0, y: 0, width: width, height: height)
        } completion: { (finished) in
            transitionContext.completeTransition(true)
        }

        
    }
    

}
