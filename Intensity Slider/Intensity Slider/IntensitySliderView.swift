//
//  IntensitySliderView.swift
//  Intensity Slider
//
//  Created by Adam Suskin on 10/11/15.
//  Copyright © 2015 Adam Suskin. All rights reserved.
//

import UIKit

@IBDesignable

extension UIColor {
    
    func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}

public class IntensitySliderView: UIView {

    @IBInspectable var counter: Float = 0
    @IBInspectable var upperBound: Float = 100
    @IBInspectable var lowerBound: Float = 0
    @IBInspectable var upperBoundSet: Bool = true
    @IBInspectable var lowerBoundSet: Bool = true
    @IBInspectable var outlineColor: UIColor = UIColor.blackColor()
    @IBInspectable var minColor: UIColor = UIColor.greenColor()
    @IBInspectable var maxColor: UIColor = UIColor.redColor()
    @IBInspectable var arcWidth: CGFloat = 10
    
    let stepFactor: Int = 100
    
    private func getDiffTuple(x: (Int, Int, Int, Int), y: (Int, Int, Int, Int)) -> (red:Int, green:Int, blue:Int, alpha:Int) {
        return ((x.0 - y.0), (x.1 - y.1), (x.2 - y.2), (x.3 - y.3));
    }
    
    private func getFillColor() -> UIColor {
        
        if(upperBoundSet && lowerBoundSet) {
            let maxVals:(Int, Int, Int, Int) = maxColor.rgb()!
            let minVals:(Int, Int, Int, Int) = minColor.rgb()!

            let diff:(Int, Int, Int, Int) = getDiffTuple(maxVals, y: minVals);
            
            let red:CGFloat = CGFloat(minVals.0) + CGFloat(Float(diff.0) * ((counter - lowerBound) / (upperBound - lowerBound)))
            let green:CGFloat = CGFloat(minVals.1) + CGFloat(Float(diff.1) * ((counter - lowerBound) / (upperBound - lowerBound)))
            let blue:CGFloat = CGFloat(minVals.2) + CGFloat(Float(diff.2) * ((counter - lowerBound) / (upperBound - lowerBound)))
            let alpha:CGFloat = CGFloat(minVals.3) + CGFloat(Float(diff.3) * ((counter - lowerBound) / (upperBound - lowerBound)))
            
            return UIColor.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha / 255.0)
            
        }
        else {
            return minColor
        }
        
    }
    
    override public func drawRect(rect: CGRect) {
        
        let center = CGPoint(x:bounds.width/2, y: bounds.width/2)
        
        let radius: CGFloat = bounds.width/2 - (arcWidth/2 + (bounds.width/2 - arcWidth/2)/10)
        
        
        let startAngle: CGFloat = 0
        let endAngle: CGFloat = 2 * CGFloat(M_PI)
        
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        path.lineWidth = arcWidth
        outlineColor.setStroke()
        let fillColor: UIColor = getFillColor()
        fillColor.setFill()
        path.fill()
        path.stroke()
        
        let buttonCenter: CGPoint = CGPoint(x: center.x + radius * cos(CGFloat(counter)*CGFloat(2*M_PI)/CGFloat(stepFactor)), y: center.y + radius * sin(CGFloat(counter)*CGFloat(2*M_PI)/CGFloat(stepFactor)))
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
