//
//  CalculatorTestCase.swift
//  CountOnMeTests
//
//  Created by Pierre Lemère on 29/04/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CalculatorTestCase: XCTestCase {
    
    var calc: Calculator!
    
    override func setUp() {
        super.setUp()
        calc = Calculator()
    }

    func testGivenArrayIsEmpty_WhenAddFourElements_ThenResulShouldBeTrue() {
        // When
        calc.elements = ["2", "+", "8", "+"]
        
        //Then
        XCTAssertTrue(calc.expressionHaveEnoughElement)
    }
    
    func testGivenArrayIsEmpty_WhenAddTwoElements_ThenResulShouldBeFalse() {
        calc.elements = ["2", "+"]
        
        XCTAssertFalse(calc.expressionHaveEnoughElement)
    }
    
    func testGivenLastElementInArrayIsMore_WhenAddOperatorSymbol_ThenShouldBeReturnFalse() {
        calc.elements = ["1", "+"]
        
        XCTAssertFalse(calc.canAddOperator)
    }
    
    func testGivenLastElementInArrayIsntOperator_WhenAddOperatorSymbol_ThenShouldBeReturnTrue() {
        calc.elements = ["1", "+", "2"]
        
        XCTAssertTrue(calc.canAddOperator)
    }
    
    func testGivenString_WhenConvertToArrayBySplitBySpace_ThenShouldBeReturn(){
        let exempleString = "2 + 3 / 4"
        
        let expectedResult = ["2", "+", "3", "/", "4"]
        
        XCTAssertEqual(calc.updateElements(text: exempleString), expectedResult)
    }
    
    func testGivenCalculator_WhenResultGivenIsFalse_ThenResultIsFalse() {
        XCTAssertFalse(calc.checkIfResultIsGiven())
    }
    
    func testGivenCalculator_WhenResultGivenIsTrue_ThenResultIsTrue() {
        calc.resultIsGiven = true
        
        XCTAssertTrue(calc.checkIfResultIsGiven())
    }
    
    func testGivenCalculatorWithResultIsGiven_WhenUserTouchAnOperator_ThenElementsResetAndAddTheLastResult() {
        let textView = UITextView()
        calc.resultCalcul = "10"
        calc.elements = ["5", "+", "5"]
        calc.resultIsGiven = true
        
        calc.resetElementsAndAddBeforeResult(textView: textView)
        
        XCTAssert(calc.elements == ["10"] )
        
    }
    
    func testGivenArrayWithMultiplication_whenMakePriorityCalculates_ThenShouldBeReturnArrayLessMultiplicationOrDivision() {
        calc.elements = ["1.0", "+", "2.0", "x", "6.0", "-", "14.0", "/", "4.0"]
        
        let expectedResult = ["1.0", "+", "12.0","-", "3.5"]
        
        XCTAssertEqual(calc.findPriorityCalculate(), expectedResult)
    }
  
    func testGivenArrayWithOnlyAdditionAndSubstraction_WhenOperations_ThenShouldBeReturnGoodResult() {
        calc.elements = ["-1.0", "+", "12.0","-", "3.5"]
        
        let expectedResult = String(7.5)
        
        XCTAssertEqual(calc.makeAdditionAndSubstraction(data: calc.elements), expectedResult)
    }
    
    func testGivenArrayWithAllCalculOperators_WhenAllOperationsArePrresnet_ThenShouldBeReturnGoodResult() {
        calc.elements = ["1.0", "+", "2.0", "x", "6.0", "-", "14.0", "/", "4.0"]
        
        let expectedResult = String(9.5)
        
        XCTAssertEqual(calc.giveResult(), expectedResult)
    }
    
    func testGivenArrayWithAllCalculOperators_WhenAllOperationsArePresent_ThenShouldBeReturnGoodResult() {
        calc.elements = ["1.0", "-", "2.0", "x", "6.0", "-", "14.0", "/", "4.0"]
        
        let expectedResult = String(-14.5)
        
        XCTAssertEqual(calc.giveResult(), expectedResult)
    }
    
    func testGivenArrayWithAllCalculOperators_WhenAllOperationsArePresentAndArrayStartByLess_ThenShouldReturnGoodResult() {
        calc.elements = ["-", "1.0", "-", "2.0", "x", "6.0", "-", "14.0", "/", "4.0"]
        
        let expectedResult = String(-16.5)
        
        XCTAssertEqual(calc.giveResult(), expectedResult)
    }
    
    func testGivenArrayWithAllCalculOperatorsAndDivisionByZero_WhenAllOperationsArePrresnet_ThenShouldReturnImpossible() {
        calc.elements = ["1.0", "+", "6.0", "/", "0", "-", "14.0", "/", "4.0"]
        
        let expectedResult = " : impossible"
        
        XCTAssertEqual(calc.giveResult(), expectedResult)
    }
    
    func testGivenArrayOfThreeOperations_WhenAllOperationsAreMultiplicationByFive_ThenShouldReturnOneHundredTwentyFive() {
        calc.elements = ["5", "x", "5", "x", "5"]
        
        let expectedResult = "125.0"
        
        XCTAssertEqual(calc.giveResult(), expectedResult)
    }
    
    func testGivenArrayOfThreeOperations_WhenAllOperationsAreMultiplicationByFiveAndFinishWithAddition_ThenShouldReturnOneHundredThirty() {
        calc.elements = ["5", "x", "5", "x", "5", "+", "5"]
        
        let expectedResult = "130.0"
        
        XCTAssertEqual(calc.giveResult(), expectedResult)
    }
}
