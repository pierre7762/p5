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
    
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "x" && elements.last != "/" && elements.first != "+" && elements.first != "x" && elements.first != "/"
    }
    
    var elements: [String] {
        calculator.elements = calculator.updateElements(text: textView.text)
        return calculator.elements
    }
    
    var result = ""

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculator.reset(textView: textView)
    }
    
    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if calculator.checkIfResultIsGiven() {
            calculator.reset(textView: textView)
            
            if let numberText = sender.title(for: .normal) {
                if numberText != "AC" {
                    textView.text.append(numberText)
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
                } else {
                    //reset calculator
                    calculator.reset(textView: textView)
                    return
                }
            }
        }
    }
    
    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        if calculator.resultIsGiven {
            calculator.resetElementsAndAddBeforeResult(textView: textView)
            
            if calculator.canAddOperator {
                textView.text.append(" + ")
                
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        } else {
            if calculator.canAddOperator {
                textView.text.append(" + ")
                
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
        
        
    }
    
    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        if calculator.checkIfResultIsGiven() {
            calculator.resetElementsAndAddBeforeResult(textView: textView)
            
            if calculator.canAddOperator {
                textView.text.append(" - ")
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        } else {
            if calculator.canAddOperator {
                textView.text.append(" - ")
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func tappedMultiplicationButton(_ sender: UIButton) {
        if calculator.checkIfResultIsGiven() {
            calculator.resetElementsAndAddBeforeResult(textView: textView)
            
            if calculator.canAddOperator {
                textView.text.append(" x ")
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                calculator.reset(textView: textView)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        } else {
            if calculator.canAddOperator {
                textView.text.append(" x ")
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                calculator.reset(textView: textView)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func tappedDivisionButton(_ sender: UIButton) {
        if calculator.checkIfResultIsGiven() {
            calculator.resetElementsAndAddBeforeResult(textView: textView)
            
            if calculator.canAddOperator {
                textView.text.append(" / ")
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                calculator.reset(textView: textView)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        } else {
            if calculator.canAddOperator {
                textView.text.append(" / ")
            } else {
                let alertVC = UIAlertController(title: "Zéro!", message: "Un operateur est déja mis !", preferredStyle: .alert)
                calculator.reset(textView: textView)
                alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alertVC, animated: true, completion: nil)
            }
        }
        
    }
    
    
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard expressionIsCorrect else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Entrez une expression correcte !", preferredStyle: .alert)
            calculator.reset(textView: textView)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        guard calculator.expressionHaveEnoughElement else {
            let alertVC = UIAlertController(title: "Zéro!", message: "Démarrez un nouveau calcul !", preferredStyle: .alert)
            calculator.reset(textView: textView)
            alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            return self.present(alertVC, animated: true, completion: nil)
        }
        
        let textResult = calculator.giveResult()
        result = textResult
        
        textView.text.append(" = \(textResult)")
        
    }
        
    

}

