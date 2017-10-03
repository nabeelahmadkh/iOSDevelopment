//
//  viewControllerForTimer.swift
//  clock
//
//  Created by Nabeel Ahmad Khan on 19/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerForTimer: UIViewController {
    
    var timer = Timer()
    
    @IBOutlet weak var analogTimer: timerFace!
    
    @IBAction func timerStop(_ sender: UIButton) {
        timer.invalidate()
        
    }
    
    @IBAction func timerReset(_ sender: UIButton) {
        timer.invalidate()
        analogTimer.resetTimer()
    }
    
    @IBAction func timerStart(_ sender: UIButton) {
        scheduledTimerWithTimeInterval()
    }
    
    func reloadDrawingFunction(){
        analogTimer.startTimer()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewControllerForTimer.reloadDrawingFunction), userInfo: nil, repeats: true)
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
