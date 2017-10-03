//
//  ViewController.swift
//  clock
//
//  Created by Nabeel Ahmad Khan on 17/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var clockView: clockFace!
    var timer = Timer()
    
    @IBOutlet weak var ampmStetter: UILabel!
    
    @IBAction func scaleSlider(_ sender: UISlider) {
        print(sender.value)
        let zoomScale = (sender.value * 1.2) + 0.3
        clockView.setscaleFactor(Double(zoomScale))
    }
    
    @IBAction func scaleClockView(_ sender: UIPinchGestureRecognizer) {
        let zoomScale = sender.scale
        print(zoomScale)
        clockView.setscaleFactor(Double(zoomScale))
    }
    
    func reloadDrawingFunction(){
        clockView.drawHourMinuteSecondHand()
        let date = Date()
        let calendar = Calendar.current
        var hour = calendar.component(.hour, from: date)
        if hour>11{
            ampmStetter.text = "PM"
        }else{
            ampmStetter.text = "AM"
        }
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("reloadDrawingFunction"), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scheduledTimerWithTimeInterval()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
