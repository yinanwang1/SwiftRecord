//
//  DisplayView.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2016/12/28.
//  Copyright © 2016年 wang. All rights reserved.
//

import UIKit

class DisplayView: UIView {
    
    public var ballLabel:UILabel? = nil;

    override func draw(_ rect: CGRect) {
        let color:UIColor = UIColor.blue
        color.set();
        
        let width = rect.size.width
        let height = rect.size.height
        
        
        let path:UIBezierPath = UIBezierPath.init()
        path.lineWidth = 5.0
        path.lineCapStyle = CGLineCap.round
        path.lineJoinStyle = CGLineJoin.round
        
        let startPoint:CGPoint = CGPoint.init(x: 0, y: 0)
        path.move(to: startPoint)
        
        var controlY:CGFloat = (self.ballLabel?.frame.origin.y)!
        if nil != self.ballLabel!.layer.presentation() {
            let layer:CALayer = self.ballLabel!.layer.presentation()!
            let postion:CGPoint = layer.value(forKey: "position") as! CGPoint
            
            controlY = postion.y
        }
        
//        print("(self.ballLabel?.frame.origin.y)! is \((self.ballLabel?.frame.origin.y)!)")
//        print("controlY is \(controlY)")
        
        let endPoint:CGPoint = CGPoint.init(x: UIScreen.main.bounds.size.width, y: 0)
        let controlPoint:CGPoint = CGPoint.init(x: UIScreen.main.bounds.size.width / 2, y: controlY)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint);
        
        path.addLine(to: CGPoint.init(x: width, y: height))
        path.addLine(to: CGPoint.init(x: 0, y: height))
        path.close()
        
        path.fill()
    }

}
