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
//    var expressionIsCorrect: Bool {
//        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.first != "+" && elements.first != "x" && elements.first != "/"
//    }
    
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
    
    func hasExpressionResult(textView: UITextView) -> Bool {
        return textView.text.firstIndex(of: "=") != nil
    }
    
    enum Operand {
        case addition
        case substraction
        case multiplication
        case division
    }
    
    //MARK: Functions
    func updateElements(text: String) -> [String] {
        return text.split(separator: " ").map { "\($0)" }
    }
    
    mutating func reset(textView: UITextView) {
        elements = []
        textView.text = ""
    }
    
    private func addition(a: Double, b: Double) -> Double {
        return a + b
    }
    
    private func substraction(a: Double, b: Double) -> Double {
        return a - b
    }
    
    private func multipication(a: Double, b: Double) -> Double {
        return a * b
    }
    
    private func division(a: Double, b: Double) -> Double {
        return a / b
    }
    
    private func elementIsNotOperator(element: String) -> Bool {
        if element != "+" && element != "-" && element != "x" && element != "/" {
            return true
        } else {
            return false
        }
    }
    
    private func elementIsMultiplication(elements: [String], i: Int) -> String {
        let firstNumber = elements[i - 1]
        let secondNumber = elements[i + 1]
        let result = String(multipication(a: Double(firstNumber)!, b: Double(secondNumber)!))
        print("multiplication : \(firstNumber) x \(secondNumber) = \(result)")
        
        return result
    }
    
    private func elementIsDevision(elements: [String], i: Int) -> String {
        let firstNumber = elements[i - 1]
        let secondNumber = elements[i + 1]
        let result = String(division(a: Double(firstNumber)!, b: Double(secondNumber)!))
        print("multiplication : \(firstNumber) / \(secondNumber) = \(result)")
        
        return result
    }
    
    private func checkIfIsNotDevisionByZero(firstElement: String, secondElement: String) -> Bool{
        if firstElement != "0" && secondElement != "0" {
            return true
        } else {
            return false
        }
    }
    
    func findPriorityCalculate() -> [String] {
        var newArray: [String] = []
        let arraySize = elements.count
        let indexMax = arraySize - 1
        
        for i in 0 ... arraySize - 1 {
            let element = elements[i]
            
            if i == 0 {
                let nextElement = elements[i + 1]
                if nextElement == "+" || nextElement == "-" {
                    newArray.append(element)
                } else if element == "-" {
                    
                    if elementIsNotOperator(element: nextElement) {
                        newArray.append(element)
                    }
                }
                
            } else if i == indexMax {
                if elementIsNotOperator(element: element) {
                    let beforeElement = elements[i - 1]
                    if beforeElement != "x" && beforeElement != "/" {
                        newArray.append(element)
                    }
                }
            } else {
                let beforeElement = elements[i - 1]
                print("element : \(element) | index : \(i)")
                
                //i is a number
                if elementIsNotOperator(element: element) {
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
                    //check if is a succession of multiplications
                    if i > 3 {
                        let elementLessTwo = elements[-2]
                        if elementLessTwo == "x" || elementLessTwo == "/" {
                            let lastElementInNewArray = Double(newArray.last!)
                            let lastIndexInNewArray = newArray.count - 1
                            
                            let result = lastElementInNewArray! * Double(elements[i + 1])!
                            
                            newArray[lastIndexInNewArray] = String(result)
                            
                            
                        } else {
                            newArray.append(elementIsMultiplication(elements: elements, i: i))
                        }
                    } else {
                        newArray.append(elementIsMultiplication(elements: elements, i: i))
                    }
                    
                    
                
                //i is /
                } else {
                    if checkIfIsNotDevisionByZero(firstElement: elements[i - 1], secondElement: elements[i + 1]){
                        newArray.append(elementIsDevision(elements: elements, i: i))
                    } else {
                        newArray.append(" / 0 = impossible")
                    }
                }
            }
        }
        print("The new array is : \(newArray)")
        
        return newArray
    }
    
    func makeAdditionAndSubstraction(data: [String]) -> String{
        var finalResult = 0.0
        let arraySize = data.count
        let indexMax = arraySize - 1
        var operatorUse = ""
        
        if indexMax >= 0 {
            for i in 0 ... indexMax {
                let element = data[i]
                
                if element != " / 0 = impossible" {
                    if i == 0 {
                        if element == "-" {
                            
                            operatorUse = "-"
                        } else {
                            finalResult = Double(element)!
                        }
                        
                    } else if element != "+" && element != "-" {
                        if operatorUse == "+" {
                            finalResult = addition(a: finalResult, b: Double(element)!)
                            operatorUse = ""
                            print("result after addition : \(finalResult)")
                        } else if operatorUse == "-" {
                            finalResult = substraction(a: finalResult, b: Double(element)!)
                            operatorUse = ""
                            print("result after substraction : \(finalResult)")
                        } else {
                            print("error : !")
                        }
                    } else if element == "+" {
                        operatorUse = "+"
                    } else if element == "-" {
                        operatorUse = "-"
                    }
                } else {
                    return " : impossible"
                }
            }
        }
        print(finalResult)
        return String(finalResult)
    }
    
    func giveResult() -> String {
        let newArrayLessMultiAndDivi = findPriorityCalculate()
        print("in func giveResult newArrayless ... = \(newArrayLessMultiAndDivi)")
        let result = makeAdditionAndSubstraction(data: newArrayLessMultiAndDivi)
        print("result = \(result)")

        return result
    }
    
}



