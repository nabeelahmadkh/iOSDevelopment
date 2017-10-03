//
//  ViewController.swift
//  Test Application
//
//  Created by Nabeel Ahmad Khan on 30/08/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var countButtonPressed = 0
//    var result: Double = 0
    @IBOutlet weak var buttonDisplay: UILabel!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let calculatorDigit = sender.currentTitle!
        
        if buttonDisplay.text! == "0" && calculatorDigit != "C"{
            buttonDisplay.text = calculatorDigit
            print("1st if case")
        }
        else{
            if calculatorDigit == "C"{
                buttonDisplay.text = "0"
                print("2nd of case")
            }
            else if buttonDisplay.text == String(Double.pi){
                buttonDisplay.text = calculatorDigit
            }
            else{
                buttonDisplay.text = buttonDisplay.text! + calculatorDigit
                print("else inside else")
            }
        }
        if calculatorDigit == "π"{
            buttonDisplay.text = String(Double.pi)
        }
    }
    
    var calculationModelObject = calculatorModel()
    
    @IBAction func calculatorOperation(_ sender: UIButton) {
        let firstOperator = buttonDisplay.text!
        let Operation = sender.currentTitle!
        buttonDisplay.text = String("0")
        calculationModelObject.setOperand(Double(firstOperator)!)
        calculationModelObject.calculations(Operation)
        
        if let result = calculationModelObject.finalResult{
            buttonDisplay.text = String(result)
        }
    }
}
//    var buttonCountDisplayValue: Double{
//        get{
//            return Double(buttonCountDisplay.text!)!
//        }
//        set{
//            buttonCountDisplay.text = String(newValue)
//        }
//    }
