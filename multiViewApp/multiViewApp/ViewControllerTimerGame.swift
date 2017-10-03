//
//  ViewControllerTimerGame.swift
//  multiViewApp
//
//  Created by Nabeel Ahmad Khan on 24/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

class ViewControllerTimerGame: UIViewController{
    
    var startButtonPressed = false
    @IBOutlet weak var timerCount: UILabel!
    var count = 0
    var countFunction = 0
    var remainingTime = 10
    var timer = Timer()
    
    
    @IBAction func screenTapped(_ sender: UITapGestureRecognizer) {
        count += 1
        print("the number of taps are \(count)")
    }
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if startButtonPressed == false{
            timerCount.text = "Time Remaining : \(remainingTime)"
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
            count = 0
            startButtonPressed = true
            button.setTitle("Running", for: .normal)
        }
    }

    @objc func update() {
        print("function fired \(countFunction) times")
        countFunction += 1
        timerCount.text = "Time Remaining : \(remainingTime)"
        remainingTime -= 1
        if(remainingTime < 0){
            timer.invalidate()
            timerCount.text = "Number of Taps \(count)"
            startButtonPressed = false
            remainingTime = 10
            button.setTitle("Over, Start Again", for: .normal)
            
            // Assigning the highest value to the user
            let defaults = UserDefaults.standard
            let activeEmail = defaults.string(forKey: "email")
            let userinfo = defaults.data(forKey: activeEmail!)
            let items = NSKeyedUnarchiver.unarchiveObject(with: userinfo as! Data)
            
            let userdata = items as! userData
            
            print("the data fetched is \(userdata.name)")
            if(count > userdata.game){
                userdata.game = count
                defaults.removeObject(forKey: userdata.email)
                let data = NSKeyedArchiver.archivedData(withRootObject: userdata)
                defaults.set(data, forKey: userdata.email)
            }
            
        }
    }
}
