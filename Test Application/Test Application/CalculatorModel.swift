//
//  CalculatorModel.swift
//  Test Application
//
//  Created by Nabeel Ahmad Khan on 30/08/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation

struct calculatorModel{
    var firstOperand: Double=0
    var secondOperand: Double=0
    private var result:Double?
    var operation:String? = nil
    var finalResult:Double?{
        get{
            return result
        }
    }
    
    mutating func calculations(_ Operand: String){
        
        switch Operand{
        case "^":
            result = pow(Double(firstOperand), 2.0)
            firstOperand = 0
            secondOperand = 0
            operation = nil
        case "√":
            result = sqrt(Double(firstOperand))
            firstOperand = 0
            secondOperand = 0
            operation = nil
        case "+":
            operation = "plus"
            print("case 1")
        case "-":
            operation = "minus"
        case "*":
            operation = "multiply"
        case "/":
            operation = "divide"
        case "=":
            calculateResult()
        default:
            break
        }
    }
    
    mutating func setOperand(_ operand: Double){
        if firstOperand == 0{
            firstOperand = operand
        }
        else{
            secondOperand = operand
        }
    }
    
    mutating func calculateResult(){
        if operation == "plus"{
            result = firstOperand + secondOperand
            firstOperand = 0
            secondOperand = 0
            operation = nil
        }
        else if operation == "minus"{
            result = firstOperand - secondOperand
            firstOperand = 0
            secondOperand = 0
            operation = nil
        }
        else if operation == "multiply"{
            result = firstOperand * secondOperand
            firstOperand = 0
            secondOperand = 0
            operation = nil
        }
        else if operation == "divide"{
            result = firstOperand / secondOperand
            firstOperand = 0
            secondOperand = 0
            operation = nil
        }
        else{
            result = 0
        }
    }
}
