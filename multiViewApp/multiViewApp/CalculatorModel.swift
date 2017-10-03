//  Calculator Model as per Reverse Polish Notation
//  CalculatorModel.swift
//  Lec4Calculator
//
//  Created by Nabeel Ahmad Khan on 24/09/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation

var completeStack: [String] = []
var completeStack2 = ""
var flag = 0

func getCompleteStack() -> String{
    return completeStack2
}

struct Stack {
    // Data Structure for storing the operations as a stack
    var data: [Double] = []
    
    mutating func push(_ number:Double) {
        data.append(number)
        if flag == 0{
            completeStack.append(String(number))
            completeStack2.append(" ")
            completeStack2.append(String(number))
        }
    }
    
    mutating func pop() -> Double {
        let top:Double = data[data.count - 1]
        data.removeLast()
        return top
    }
    
    func stackSize() -> Int {
        return data.count
    }
}


class CalculatorModel {
    
    var stack = Stack()
    
    func performOperation(_ operation: String) -> Double {
        print("Calc received op request: \(operation)")
        completeStack.append(operation)
        completeStack2.append(" ")
        completeStack2.append(operation)
        completeStack2.append(" ")
        completeStack2.append("=")
        var operand1: Double = 0.0
        var operand2: Double = 0.0
        
        if stack.stackSize() >= 2{
            operand2 = stack.pop()
            operand1 = stack.pop()
        }
        else if stack.stackSize() >= 1{
            operand2 = stack.pop()
            operand1 = 0
        }
        else{
            operand2 = 0
            operand1 = 0
        }
        
        let result: Double
        if operation == "+" {
            result = operand1 + operand2
        } else if operation == "-" {
            result = operand1 - operand2
        } else if operation == "x" {
            result = operand1 * operand2
        } else if operation == "/" {
            result = operand1 / operand2
        } else {
            result = 0
        }
        flag = 1
        stack.push(result)
        //let temp = completeStack2.characters.last
        //print(temp ?? "null")
        print("stack is now: \(completeStack2)")
        return result
    }
    
    func performUnaryOperation(_ operation: String) -> Double {
        var operand1: Double = 0.0
        let result: Double
        completeStack2.append(operation)
        completeStack2.append(" ")
        completeStack2.append("=")
        if stack.stackSize() >= 1{
            operand1 = stack.pop()
        }else{
            print("Not enough operands for Unary Operations")
        }
        
        switch operation {
        case "sqrt":
            result = sqrt(operand1)
        case "^2":
            result = pow(operand1,2.0)
        case "±":
            result = -operand1
        case "sin":
            operand1 = ((operand1 * Double.pi)/180)
            result = sin(operand1)
        case "cos":
            if operand1 == 90{
                result = 0
            }else{
                operand1 = ((operand1 * Double.pi)/180)
                result = cos(operand1)
            }
        default:
            result = 0.0
        }
        flag = 1
        return result
    }
    
    func specialSymbols(_ symbol: String) -> Double {
        let result: Double
        if symbol == "pi"{
            result = Double.pi
        }
        else{
            result = 0.0
        }
        return result
    }
    
    func clearStack() {
        var size = stack.stackSize()
        while size > 0 {
            stack.pop()
            size -= 1
        }
        print(stack)
        print("stack empty")
        completeStack = []
        completeStack2 = ""
        flag = 0
    }
    
    func enterNumber(number: Double) {
        print("Calc received : \(number)")
        if flag == 1{
            completeStack2.characters.popLast()
            flag = 0
        }
        stack.push(number)
        print(stack)
    }
}

