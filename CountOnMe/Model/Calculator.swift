//
//  Calculator.swift
//  CountOnMe
//
//  Created by Pierre Lemère on 26/03/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation
import UIKit

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
    
    func findPriorityCalculate() -> [String] {
        var newArray: [String] = []
        let arraySize = elements.count
        let indexMax = arraySize - 1
        
        for i in 0 ... arraySize - 1 {
            let element = elements[i]
            
            
            if i == 0 {
                newArray.append(element)
            } else if i == indexMax {
                if element != "+" && element != "-" && element != "x" && element != "/" {
                    let beforeElement = elements[i - 1]
                    if beforeElement != "x" && beforeElement != "/" {
                        newArray.append(element)
                    }
                }
            } else {
                
                let beforeElement = elements[i - 1]
                
                print("element : \(element) | index : \(i)")
                
                //i is a number
                if element != "+" && element != "-" && element != "x" && element != "/" {
                    if (i+1) <= indexMax {
                        let nextElement = elements[i + 1]
                        if nextElement == "+" || nextElement == "-" {
                            if beforeElement != "x" && beforeElement != "/" {
                                newArray.append(element)
                            }
                        }
                    } else {
                        newArray.append(element)
                    }
                //i is + or -
                } else if element == "+" || element == "-" {
                    newArray.append(element)
                    
                //i is x
                } else if element == "x" {
                    let firstNumber = elements[i - 1]
                    let secondNumber = elements[i + 1]
                    let result = String(multipication(a: Double(firstNumber)!, b: Double(secondNumber)!))
                    newArray.append(result)
                    
                    print("multiplication : \(firstNumber) x \(secondNumber) = \(result)")
                
                //i is /
                } else {
                    let firstNumber = elements[i - 1]
                    let secondNumber = elements[i + 1]
                    let result = String(division(a: Double(firstNumber)!, b: Double(secondNumber)!))
                    newArray.append(result)
                    
                    print("division : \(firstNumber) / \(secondNumber) = \(result)")
                }
            }
        }
        print("The new array is : \(newArray)")
        
        return newArray
    }
    
    func makeAdditionAndSubstraction(data: [String]) -> Double{
        var finalResult = 0.0
        let arraySize = data.count
        
        if arraySize > 0 {
            let indexMax = arraySize - 1
            
            for i in 0 ... indexMax - 1{
                let element = data[i]
                
                if i == 0 {
                    finalResult = Double(element)!
                } else {
                    let nextElement = data[i + 1]
                    
                    if element == "+" {
                        finalResult = addition(a: finalResult, b: Double(nextElement)!)
                    } else {
                        finalResult = substraction(a: finalResult, b: Double(nextElement)!)
                    }
                }
            }
        }
        return finalResult
    }
    
    func giveResult() -> String {
        var newArrayLessMultiAndDivi = findPriorityCalculate()
        var result = makeAdditionAndSubstraction(data: newArrayLessMultiAndDivi)
        
        let resultText = " = \(result)"
        
        return resultText
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



