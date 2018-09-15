//
//  CrownView.swift
//  FizzBuzz
//
//  Created by Elliot Goldman on 9/10/18.
//  Copyright © 2018 Elliot Keeler. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CrownView : UIView{
    
    @IBInspectable var lineWidth : CGFloat = 2.0
    @IBInspectable var color : UIColor = UIColor.white{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect){
        
        let path = UIBezierPath()
        let fourth = rect.width / 4
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + fourth, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + fourth, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = lineWidth
        layer.lineCap = kCALineCapRound
        layer.lineJoin = kCALineJoinRound
        layer.strokeColor = color.cgColor
        layer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(layer)
    }
}
