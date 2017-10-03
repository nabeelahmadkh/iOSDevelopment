//  *********************************************************************
//  ViewController.swift
//  Controller in MVC
//  Calculator
//  *********************************************************************
//  Created by Nabeel Ahmad Khan on 23/08/17.
//  Last Edit on 24/08/2017
//  Copyright © 2017 Defcon. All rights reserved.
//  Calculator Code can be found on GitHub Repository "URL"
//  *********************************************************************

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!   // Outlet means a reference to a variable, this variable is an Outlet.
    
    var displayValue: Double{
        // for set and get values of display variable declared right above.
        set{
            display.text = String(newValue) //newValue is the predefined variable for assigning the values.
        }
        get{
            return Double(display.text!)!
        }
    }
    
    var userInTheMiddleOfTyping = false
    
    @IBAction func touchButton(_ sender: UIButton) {
        // Function called when a button is pressed (1,2,3,4,5,6,7,8,9,0)
        // "_ sender" is used when don't define the argument ex: "from: sender" and we never used _ for the second and subsequent arguments. 
        // If we are using _ then when we call the function we can simpply pass the argument like this touchButton(argument)
        // We don't have to do like this touchButton(from: argument)
        // Just like we do in other functions.
        // "\(variable)" this will convert variable to string and then you can display it.
        
        let digit = sender.currentTitle!
        if userInTheMiddleOfTyping{
            let textCurrentlyInDisplay = display.text! // to create a constant we use let.
            display.text = textCurrentlyInDisplay + digit
        }
        else{
            display.text = digit
            userInTheMiddleOfTyping = true
        }
    }
    
    private var brain = calculateBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        // Function called when a pi, sqrt button is pressed.
        if userInTheMiddleOfTyping{
            brain.setOperand(displayValue)
            userInTheMiddleOfTyping = false
        }
        
        if let mathmaticalsymbol = sender.currentTitle{
            brain.performOperation(mathmaticalsymbol)
        }
        
        if let result = brain.result{
            displayValue = result
        }
    }
}
