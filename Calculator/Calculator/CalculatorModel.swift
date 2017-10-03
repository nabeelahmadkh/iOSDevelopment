//
//  CalculatorModel.swift
//  Model in MVC
//  Calculator
//
//  Created by Nabeel Ahmad Khan on 27/08/17.
//  Copyright © 2017 Defcon. All rights reserved.
//

import Foundation

func power(operand: Double) -> Double{
    return pow(operand, 2)
}

func multiply(op1: Double, op2: Double) -> Double{
    return op1*op2
}

func add(op1: Double, op2: Double) -> Double{
    
    return op1 + op2
}

func subtract(op1: Double, op2: Double) -> Double{
    
    return op1 - op2
}

func divide(op1: Double, op2: Double) -> Double{
    
    return op1 / op2
}

struct calculateBrain{
    
    private var accumulator : Double?
    
    private enum Operation{
        case constant(Double)
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double,Double) -> Double)
        case equals
    }
    private var  operations: Dictionary<String,Operation> =
        [
            "π" : Operation.constant(Double.pi),
            "e" : Operation.constant(M_E),
            "√" : Operation.unaryOperation(sqrt),
            "^" : Operation.unaryOperation(power),
            "C" : Operation.constant(0.0),
            "*" : Operation.binaryOperation(multiply),
            "+" : Operation.binaryOperation(add),
            "-" : Operation.binaryOperation(subtract),
            "/" : Operation.binaryOperation(divide),
            "cos" : Operation.unaryOperation(cos),
            "sin" : Operation.unaryOperation(sin),
            "tan" : Operation.unaryOperation(tan),
            "=" : Operation.equals
    ]
    
    mutating func performOperation(_ symbol: String){   // in symbols "+" "-" "*" "/" is coming
        if let operation = operations[symbol] {   // symbols are translated into their respective values or functions
            switch operation{
            case .constant(let value):  // value -> is an associated contant value
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil{
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function): //function name will come from ??
                if accumulator != nil{
                    pbo = pendingBinaryOperation(function: function, firstOperand: accumulator!)  // pbo object -> contructor is initialized, 
                                                                                                  // this will initilize the function with the function (such as multiply, add etc) and and first operand.
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private mutating func performPendingBinaryOperation(){
        if pbo != nil && accumulator != nil{
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil
        }
    }
    
    
    private var pbo: pendingBinaryOperation?  // new object is created in Optional State
    
    private struct pendingBinaryOperation{
        let function: (Double, Double) -> Double
        let firstOperand: Double
        
        func perform(with secondOperand: Double) -> Double{
            return function(firstOperand, secondOperand)
        }
    }
    
    mutating func setOperand(_ operand: Double){
        accumulator = operand
    }
    
    var result : Double?{
        get{
            return accumulator
        }
    }
}
