//
//  ViewController.swift
//  smileyApp
//
//  Created by Nabeel Ahmad Khan on 10/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    var count = 0
    var currentCount = 0
    var maxCount = 5
    
    var recentStatus:[String] = []
    var recentDates:[String] = []
    
    
    @IBAction func smileyFunction(_ sender: UIButton) {
        if sender.image(for: UIControlState()) == UIImage(named: "happySmiley"){
            sender.setImage(UIImage(named: "sadSmiley"), for: UIControlState())
        }else{
            sender.setImage(UIImage(named: "happySmiley"), for: UIControlState())
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        print("the text field resigned as first Responder")
        return false
    }

    @IBAction func textFieldChanged(_ sender: UITextField) {
        print(textField.text ?? "nothing in the text box")
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        
        count = recentStatus.count
        if ((currentCount < count) && (currentCount <= maxCount)){
            textLabel.text = recentStatus[currentCount]
            dateLabel.text = recentDates[currentCount]
            currentCount += 1
        }else{
            currentCount = 0
        }
    }
    
    @IBAction func textFieldEditingEnd(_ sender: UITextField) {
        print("Editing end")
        print(textField.text!)
        recentStatus.append(textField.text!)
        recentDates.append(String(describing: Date()))
        if recentStatus.count > maxCount{
            recentStatus.remove(at: 0)
            recentDates.remove(at: 0)
        }
        
        let defaults = UserDefaults.standard
        defaults.set(recentStatus, forKey: "status")
        defaults.set(recentDates, forKey: "dates")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let defaults = UserDefaults.standard
        if let statusString = defaults.stringArray(forKey: "status"){
            recentStatus = statusString
            recentDates = defaults.stringArray(forKey: "dates")!
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
