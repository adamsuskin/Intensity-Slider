//
//  IntensitySliderView.swift
//  Intensity Slider
//
//  Created by Adam Suskin on 10/11/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

import UIKit

@IBDesignable

class IntensitySliderView: UIView {

    @IBInspectable var counter: Int = 0
    @IBInspectable var upperBound: Int? = 100
    @IBInspectable var lowerBound: Int?
    @IBInspectable var outlineColor: UIColor = UIColor.blackColor()
    @IBInspectable var color: UIColor = UIColor.greenColor()
    
    
    override func drawRect(rect: CGRect) {
        
        let center = CGPoint(x:bounds.width/2, y: bounds.width/2)
        
        let arcWidth: CGFloat = bounds.width/8
        
        let radius: CGFloat = bounds.width/2 - arcWidth/2
        
        
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * CGFloat(M_PI)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        outlineColor.setStroke()
        color.setFill()
        path.fill()
        path.stroke()
        
        let buttonCenter: CGPoint = CGPoint(x: center.x + radius * cos(CGFloat(counter)*CGFloat(2*M_PI)), y: center.y + radius * sin(CGFloat(counter)*CGFloat(2*M_PI)))
        let buttonRadius: CGFloat = radius / 10
        
        let buttonPath = UIBezierPath(arcCenter: buttonCenter, radius: buttonRadius, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        
        let buttonArcWidth: CGFloat = 2
        
        buttonPath.lineWidth = buttonArcWidth
        UIColor.blackColor().setStroke()
        UIColor.whiteColor().setFill()

        
        let shadow: UIColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        let shadowOffset = CGSizeMake(0, 0)
        let shadowBlurRadius: CGFloat = 5
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetShadowWithColor(context, shadowOffset, shadowBlurRadius, shadow.CGColor)
        
        buttonPath.fill()
        buttonPath.stroke()

    }

}
