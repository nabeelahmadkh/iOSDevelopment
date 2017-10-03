//
//  faceView.swift
//  graphics
//
//  Created by Nabeel Ahmad Khan on 12/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

@IBDesignable
class faceView: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    @IBInspectable
    var scale:CGFloat = 0.9
    
    @IBInspectable
    var eyesOpen:Bool = true
    
    var mouthCurvature: Double = 1.0
    
    func setScaleValue(_ value:CGFloat){
        scale = value
        setNeedsDisplay()
    }
    
    func assignMouthCurvature(_ value:Double) {
        mouthCurvature = value
        setNeedsDisplay()
        
    }
    
    private var skullRadius:CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    private var skullCenter:CGPoint{
        return CGPoint(x: bounds.midX, y:bounds.midY)
    }
    
    private enum Eye{
        case left
        case right
    }
    
    private func pathForNose() -> UIBezierPath{
        let path = UIBezierPath()
        let start:CGPoint
        let end:CGPoint
        let controlPoint:CGPoint
        path.lineWidth=3.0
        start = CGPoint(x: bounds.midX, y: bounds.midY-20)
        end = CGPoint(x: bounds.midX, y: bounds.midY+40)
        controlPoint=CGPoint(x: bounds.midX - 5, y: bounds.midY + 30)
        path.move(to: start)
        path.addQuadCurve(to: end, controlPoint: controlPoint)
        
        return path
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath{
        let path:UIBezierPath
        let center:CGPoint
        let radius:CGFloat
        if eye == .left{
            if eyesOpen == true{
                center = CGPoint(x:(bounds.midX - 60),y:(bounds.midY-40))
                radius = CGFloat(20)
                path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
                path.lineWidth = 4.0
            }else{
                center = CGPoint(x:(bounds.midX - 60),y:(bounds.midY-40))
                radius = CGFloat(20)
                path = UIBezierPath()
                path.move(to: CGPoint(x: center.x - radius,y: center.y))
                path.addLine(to: CGPoint(x: center.x + radius,y:center.y))
            }
            
        }else{
            if eyesOpen == true{
                center = CGPoint(x:(bounds.midX + 60),y:(bounds.midY-40))
                radius = CGFloat(20)
                path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: false)
                path.lineWidth = 4.0
            }else{
                center = CGPoint(x:(bounds.midX + 60),y:(bounds.midY-40))
                radius = CGFloat(20)
                path = UIBezierPath()
                path.move(to: CGPoint(x: center.x - radius,y: center.y))
                path.addLine(to: CGPoint(x: center.x + radius,y:center.y))
            }
            
        }
        return path
    }
    
    private func pathForMouth() -> UIBezierPath{
        let mouthRect = CGRect(
            x: (bounds.midX - 40),
            y: (bounds.midY+40),
            width: CGFloat(80),
            height: CGFloat(20)
        )
        let path = UIBezierPath()
        path.lineWidth = 3.0
        
        let start = CGPoint(x:(bounds.midX-40), y:(bounds.midY+70))
        let end = CGPoint(x:(bounds.midX+40), y:(bounds.midY+70))
        let mouthOffset = ((bounds.midY+(100*CGFloat(mouthCurvature))))
        let controlPoint = CGPoint(x:(bounds.midX), y:mouthOffset)
        path.move(to: start)
        path.addQuadCurve(to: end, controlPoint: controlPoint)
        return path
    }
    
    private func pathForSkull() -> UIBezierPath{
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius - 40, startAngle: 0, endAngle:2 * CGFloat.pi, clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        pathForSkull().stroke()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
        pathForNose().stroke()
    }
}
