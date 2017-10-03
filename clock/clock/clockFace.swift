//
//  clockFace.swift
//  clock
//
//  Created by Nabeel Ahmad Khan on 17/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

@IBDesignable
class clockFace: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    
    let innerCircleRadius = 94
    let outerCircleRadius = 100
    let markerWidth:CGFloat = 4.0
    let smallMarketWidth:CGFloat = 2.0
    var scaleFactor = 1.2
    
    func setscaleFactor(_ scale:Double){
        scaleFactor = scale
        setNeedsDisplay()
    }
    
    
    // Making the inner and outer circle.
    func drawCircle(){
        //let radius = CGFloat(Double(innerCircleRadius) * scaleFactor)
        let biggerRadius = CGFloat(Double(outerCircleRadius) * scaleFactor)
        let center = CGPoint(x:bounds.midX, y:bounds.midY)
    
        //let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
    
        let path2 = UIBezierPath(arcCenter: center, radius: biggerRadius, startAngle: 0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        
        let path3 = UIBezierPath(arcCenter: center, radius: CGFloat(Double(outerCircleRadius+10) * scaleFactor), startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true)
        

        UIColor.gray.setFill()
        path2.fill()
    
        path2.lineWidth = CGFloat(3.5 * scaleFactor)
        path2.stroke()
        
        path3.lineWidth = CGFloat(10.0 * scaleFactor)
        var strokeColor = UIColor.red
        strokeColor.setStroke()
        path3.stroke()
    }
    
    
    // Drawing the Hour Markers of the circles.
    func drawHourMarkers(_ iteration:Int){
        let path = UIBezierPath()
        path.lineWidth = CGFloat(Double(markerWidth) * scaleFactor)
        
        let pointXInnerCircle = bounds.midX + CGFloat(Double(Double(innerCircleRadius-5) * scaleFactor) * (sin(Double.pi * Double(iteration)/6)))
        let pointYInnerCircle = bounds.midY - CGFloat(Double(Double(innerCircleRadius-5) * scaleFactor) * (cos(Double.pi * Double(iteration)/6)))
        
        let pointXOuterCircle = bounds.midX + CGFloat(Double(Double(outerCircleRadius) * scaleFactor) * (sin(Double.pi * Double(iteration)/6)))
        let pointYOuterCircle = bounds.midY - CGFloat(Double(Double(outerCircleRadius) * scaleFactor) * (cos(Double.pi * Double(iteration)/6)))
        
        path.move(to: CGPoint(x:pointXInnerCircle, y:pointYInnerCircle))
        path.addLine(to: CGPoint(x: pointXOuterCircle,y: pointYOuterCircle))
        path.stroke()
    }
    
    
    // Drawing the Minutes Markers of the circles.
    func drawMinuteMarkers(_ iteration:Int){
        let path = UIBezierPath()
        path.lineWidth = CGFloat(Double(smallMarketWidth) * scaleFactor)
        
        let pointXInnerCircle = bounds.midX + CGFloat(Double(Double(innerCircleRadius) * scaleFactor) * (sin(Double.pi * Double(iteration)/30)))
        let pointYInnerCircle = bounds.midY - CGFloat(Double(Double(innerCircleRadius) * scaleFactor) * (cos(Double.pi * Double(iteration)/30)))
        
        let pointXOuterCircle = bounds.midX + CGFloat(Double(Double(outerCircleRadius) * scaleFactor) * (sin(Double.pi * Double(iteration)/30)))
        let pointYOuterCircle = bounds.midY - CGFloat(Double(Double(outerCircleRadius) * scaleFactor) * (cos(Double.pi * Double(iteration)/30)))
        
        path.move(to: CGPoint(x:pointXInnerCircle, y:pointYInnerCircle))
        path.addLine(to: CGPoint(x: pointXOuterCircle,y: pointYOuterCircle))
        path.stroke()
    }
    
    
    // Drawing the center dot.
    func drawCenter(){
        let center:CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: center, radius: CGFloat(10), startAngle: CGFloat(0), endAngle: CGFloat(2*Double.pi), clockwise: true)
        print("drawcenter called")
        path.lineWidth = 4.0
        path.stroke()
    }
    
        
    // Drawing the hour, minute and second hand.
    func drawHourMinuteSecondHand(){
        let hourPath = UIBezierPath()
        let minutePath = UIBezierPath()
        let secondPath = UIBezierPath()
        let center:CGPoint = CGPoint(x: bounds.midX,y: bounds.midY)
        
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("\(hour) \(minutes) \(seconds) ")
        if hour >= 12{
            hour -= 12
        }
        
        let totalHourOffset = (hour * 5) + (minutes/12)
        let totalMinuteOffset = minutes
        let totalSecondOffset = seconds
        
        let hourHandX = bounds.midX + CGFloat(Double(CGFloat(45  * scaleFactor)) * (sin(Double.pi * Double(totalHourOffset)/30)))
        let hourHandY = bounds.midY - CGFloat(Double(CGFloat(45 * scaleFactor)) * (cos(Double.pi * Double(totalHourOffset)/30)))
        
        let minuteHandX = bounds.midX + CGFloat(Double(CGFloat(75 * scaleFactor)) * (sin(Double.pi * Double(totalMinuteOffset)/30)))
        let minuteHandY = bounds.midY - CGFloat(Double(CGFloat(75 * scaleFactor)) * (cos(Double.pi * Double(totalMinuteOffset)/30)))
        
        let secondHandX = bounds.midX + CGFloat(Double(CGFloat(80 * scaleFactor)) * (sin(Double.pi * Double(totalSecondOffset)/30)))
        let secondHandY = bounds.midY - CGFloat(Double(CGFloat(80 * scaleFactor)) * (cos(Double.pi * Double(totalSecondOffset)/30)))
        
        hourPath.lineWidth = CGFloat(5.0 * scaleFactor)
        hourPath.move(to: center)
        hourPath.addLine(to: CGPoint(x:hourHandX, y:hourHandY))
        hourPath.stroke()
        
        
        minutePath.lineWidth = CGFloat(4.0 * scaleFactor)
        minutePath.move(to: center)
        minutePath.addLine(to: CGPoint(x:minuteHandX, y:minuteHandY))
        minutePath.stroke()
        
        secondPath.lineWidth = CGFloat(2.0 * scaleFactor)
        secondPath.move(to: center)
        secondPath.addLine(to: CGPoint(x:secondHandX, y:secondHandY))
        let strokeColor = UIColor.red
        
        strokeColor.setStroke()
       
        secondPath.stroke()
        
        setNeedsDisplay()
    }
    
    func makeRectangle(){
        let path = UIBezierPath(rect: CGRect(x: (bounds.midX - CGFloat(Double(outerCircleRadius + 30) * scaleFactor)), y: (bounds.midY - CGFloat(Double(outerCircleRadius + 30) * scaleFactor)), width: CGFloat(260 * scaleFactor), height: CGFloat(260 * scaleFactor)))
        
        path.lineWidth = CGFloat(10.0 * scaleFactor)
        UIColor(red:0.53, green:0.69, blue:0.89, alpha:1.0).setFill()
        var strokeColor = UIColor(red:0.15, green:0.38, blue:0.66, alpha:1.0)
        strokeColor.setStroke()
        path.fill()
        path.stroke()
    }
    
    // calling all the functions for drawing
    override func draw(_ rect: CGRect) {
        makeRectangle()
        var strokeColor = UIColor.black
        strokeColor.setStroke()
        drawCenter()
        drawCircle()
        strokeColor = UIColor.black
        strokeColor.setStroke()
        for i in 0...11{
            drawHourMarkers(i)
        }
        
        for i in 0...59{
            drawMinuteMarkers(i)
        }
        
        drawHourMinuteSecondHand()
        
    }
}
