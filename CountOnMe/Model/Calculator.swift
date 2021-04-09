//
//  Calculator.swift
//  CountOnMe
//
//  Created by Pierre Lemère on 26/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

struct Calculator {
    
    //MARK: Variables
    var elements: [String] = []
    
    // Error check computed variables
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/"
    }
    
    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }
    
    var canAddOperator: Bool {
        var ok = false
        
        if elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" {
            ok = true
        }
        return ok
    }
    
    var expressionHaveResult: Bool = false
    
    enum Operand {
        case addition
        case substraction
        case multiplication
        case division
    }
    
    //MARK: Functions
    
    func addition(a: Double, b: Double) -> Double {
        return a + b
    }
    
    func substraction(a: Double, b: Double) -> Double {
        return a - b
    }
    
    func multipication(a: Double, b: Double) -> Double {
        return a * b
    }
    
    func division(a: Double, b: Double) -> Double {
        return a / b
    }
    
    func updateElements(text: String) -> [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    mutating func resetCalculator() {
        elements = []
    }
    
    mutating func findPriorityCalculate() -> [String]{
        var newArray: [String] = [""]
        let arraySize = elements.count
        var position = 0
        var result = 0.0
        for i in 0 ... arraySize {
            if i < arraySize - 1 {
                let element: String = elements[i]
                
                if element == "x" || element == "/" {
                    let firstIndex = elements.index(before: position)
                    let firstNumber = elements[firstIndex]
                    print(firstNumber)
                    print(element)
                    let secondNumber = elements[elements.index(after: position)]
                    print(secondNumber)
                    
                    if element == "x" {
                        result = multipication(a: Double(firstNumber)!, b: Double(secondNumber)!)
                        print("result : \(result)")
                    } else {
                        result = division(a: Double(firstNumber)!, b: Double(secondNumber)!)
                    }
                    
                    elements[position] = String(result)
                    elements.remove(at: position - 1)
                    elements.remove(at: position)
                    
                    print(elements)
                }
                
                position += 1
            }
            
        }
        return newArray
    }
    
//    // Create local copy of operations
//    var operationsToReduce = elements
//
//    // Iterate over operations while an operand still here
//    while operationsToReduce.count > 1 {
//        let left = Int(operationsToReduce[0])!
//        let operand = operationsToReduce[1]
//        let right = Int(operationsToReduce[2])!
//
//        let result: Int
//        switch operand {
//        case "+": result = left + right
//        case "-": result = left - right
//        default: fatalError("Unknown operator !")
//        }
//
//        operationsToReduce = Array(operationsToReduce.dropFirst(3))
//        operationsToReduce.insert("\(result)", at: 0)
//    }
//
//    textView.text.append(" = \(operationsToReduce.first!)")

}



