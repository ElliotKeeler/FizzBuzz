//
//  NumberView.swift
//  FizzBuzz
//
//  Created by Elliot Goldman on 9/10/18.
//  Copyright © 2018 Elliot Keeler. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class NumberView : UIButton{
    
    @IBInspectable var lineWidth : CGFloat = 2.0
    @IBInspectable var color : UIColor = UIColor.white{
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect){
        
        var layers = [CAShapeLayer]()
        
        let third = rect.width / 3.5
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: (rect.minX + third), y: rect.minY))
        path.addLine(to: CGPoint(x: (rect.minX + third), y: rect.maxY))
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layers.append(layer)
        
        let pathII = UIBezierPath()
        pathII.move(to: CGPoint(x: (rect.maxX - third), y: rect.minY))
        pathII.addLine(to: CGPoint(x: (rect.maxX - third), y: rect.maxY))
        
        let layerII = CAShapeLayer()
        layerII.path = pathII.cgPath
        layers.append(layerII)
        
        let thirdH = rect.height / 3.5
        
        let pathIII = UIBezierPath()
        pathIII.move(to: CGPoint(x: rect.minX, y: (rect.minY + thirdH)))
        pathIII.addLine(to: CGPoint(x: rect.maxX, y: (rect.minY + thirdH)))
        
        let layerIII = CAShapeLayer()
        layerIII.path = pathIII.cgPath
        layers.append(layerIII)
        
        let pathIV = UIBezierPath()
        pathIV.move(to: CGPoint(x: rect.minX, y: (rect.maxY - thirdH)))
        pathIV.addLine(to: CGPoint(x: rect.maxX, y: (rect.maxY - thirdH)))
        
        let layerIV = CAShapeLayer()
        layerIV.path = pathIV.cgPath
        layers.append(layerIV)
        
        layers.forEach(){
            $0.lineWidth = lineWidth
            $0.lineCap = kCALineCapRound
            $0.lineJoin = kCALineJoinRound
            $0.strokeColor = color.cgColor
            $0.fillColor = UIColor.clear.cgColor
            self.layer.addSublayer($0)
        }
    }
}
