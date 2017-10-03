//  Calculator Controller as per Reverse Polish  Notation
//  ViewControllerCalc.swift
//  Lec4Calculator
//
//  Created by Nabeel Ahmad Khan on 24/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

class ViewControllerCalc: UIViewController {
    
    @IBOutlet weak var theDisplay: UILabel!     // calculator display
    @IBOutlet weak var fullStack: UILabel!
    
    var userIsInMiddleOfEnteringANumber = false     // user ??
    
    var calcBrain = CalculatorModel()       // creating an object of the model class created in CalculatorModel.swift
    
    
    
    @IBAction func digitPressed(_ sender: UIButton) {   // function to capture the digit pressed
        let whichDigit = sender.currentTitle!
        print("digit pressed: \(whichDigit)")
        var currentDisplayText: String
        currentDisplayText = theDisplay.text!
        fullStack.text = getCompleteStack()
        
        if whichDigit == "pi"{  // use OR to add more Special Symbols here
            currentDisplayText = String(calcBrain.specialSymbols(whichDigit))
            //theDisplay.text = ""
            theDisplay.text = currentDisplayText
            enterPressed()
        }else{
            if userIsInMiddleOfEnteringANumber {
                theDisplay.text = currentDisplayText + whichDigit
            } else {
                theDisplay.text = sender.currentTitle!
                userIsInMiddleOfEnteringANumber  = true
            }
        }
    }
    
    @IBAction func backspace(_ sender: UIButton) {
        var tempvar = theDisplay.text!
        let length2 = tempvar.characters.count
        print(length2)
        let sublength = length2 - 1
        let index = tempvar.index(tempvar.startIndex, offsetBy: sublength)
        let display = tempvar.substring(to: index)
        theDisplay.text = display
        fullStack.text = getCompleteStack()
        
    }
    
    @IBAction func unaryOperationPresses(_ sender: UIButton) {
        let unaryOperation = sender.currentTitle!
        print("unary operation pressed: \(unaryOperation)")
        let result = calcBrain.performUnaryOperation(unaryOperation)
        theDisplay.text = "\(result)"
        fullStack.text = getCompleteStack()
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        let whichOperation = sender.currentTitle!
        print("operation pressed: \(whichOperation)")
        if userIsInMiddleOfEnteringANumber {
            enterPressed()
        }
        let result = calcBrain.performOperation(whichOperation)
        theDisplay.text = "\(result)"
        fullStack.text = getCompleteStack()
        
        let defaults = UserDefaults.standard
        let activeEmail = defaults.string(forKey: "email")
        let userinfo = defaults.data(forKey: activeEmail!)
        let items = NSKeyedUnarchiver.unarchiveObject(with: userinfo as! Data)
        
        let userdata = items as! userData
        
        print("the data fetched is \(userdata.name)")
        
        userdata.calculator = result
        defaults.removeObject(forKey: userdata.email)
        
        let data = NSKeyedArchiver.archivedData(withRootObject: userdata)
        defaults.set(data, forKey: userdata.email)
    }
    
    @IBAction func enterPressed() {
        
        userIsInMiddleOfEnteringANumber = false
        if theDisplay.text! == "."{
            calcBrain.enterNumber(number: 0.0)
            fullStack.text = getCompleteStack()
        }
        else{
            let enteredNumber = Double(theDisplay.text!)!
            print("number entered: \(enteredNumber)")
            calcBrain.enterNumber(number: enteredNumber)
            fullStack.text = getCompleteStack()
        }
    }
    
    @IBAction func clearStack(_ sender: UIButton) {
        calcBrain.clearStack()
        theDisplay.text = "0"
        fullStack.text = getCompleteStack()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //       digitPressed.backgroundRect(forBounds: )
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

