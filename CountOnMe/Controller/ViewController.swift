//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!
    
    var calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        calculator.reset(textView: textView)
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if calculator.checkIfResultIsGiven() {
            calculator.reset(textView: textView)
            
            if let numberText = sender.title(for: .normal) {
                if numberText != "AC" {
                    textView.text.append(numberText)
                    calculator.updateElements(text: textView.text)
                } else {
                    //reset calculator
                    calculator.reset(textView: textView)
                    return
                }
            }
        } else {
            if let numberText = sender.title(for: .normal) {
                if numberText != "AC" {
                    textView.text.append(numberText)
                    calculator.updateElements(text: textView.text)
                } else {
                    //reset calculator
                    calculator.reset(textView: textView)
                    return
                }
            }
        }
        
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        calculator.actionButton(textView: textView, oper: "+")
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        calculator.actionButton(textView: textView, oper: "-")
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        calculator.actionButton(textView: textView, oper: "x")
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        calculator.actionButton(textView: textView, oper: "/")
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        if calculator.resultIsGiven {
            
        } else {
            print("elements = \(calculator.elements)")
            guard calculator.checkIfCanAddOperator() else {
                let alertVC = UIAlertController(title: "Incomplet!", message: "Écrire une opération complète !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)
            }
            
            guard calculator.expressionHaveEnoughElement else {
                let alertVC = UIAlertController(title: "Incomplet!", message: "Écrire une opération complète !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)
            }
            
            let textResult = calculator.giveResult()
            
            if textResult == " Division par zéro impossible" {
                calculator.reset(textView: textView)
                
                let alertVC = UIAlertController(title: "Impossible!", message: "On ne peut diviser par zéro !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                return self.present(alertVC, animated: true, completion: nil)
            } else {
                textView.text.append(" = \(textResult)")
            }
        }
    }
        
    

}

