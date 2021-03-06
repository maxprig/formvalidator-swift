//
//  EmailValidatorTests.swift
//  FormValidatorSwift
//
//  Created by Aaron McTavish on 14/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import XCTest

@testable import FormValidatorSwift


final class EmailValidatorTests: XCTestCase {
    
    
    // MARK: - Properties
    
    let validator   = EmailValidator()
    
    
    // MARK: - Test Success
    
    func testEmailValidator_Success() {
        // Given
        let testInput                       = "e_x.a+m-p_l.e@ex.example-example.ex.am"
        let expectedResult: [Condition]?    = nil
        
        // When
        let actualResult = validator.checkConditions(testInput)
        
        // Test
        XCTAssertNil(actualResult, "The `\(type(of: validator))` should respond with \(expectedResult) and but received \(actualResult).")
    }
    
    
    // MARK: - Test Failure
    
    func testEmailValidator_Failure() {
        // Given
        let testInput                       = "example@"
        let expectedResult: [Condition]?    = validator.conditions
        
        // When
        let actualResult = validator.checkConditions(testInput)
        
        // Test
        XCTAssertNotNil(actualResult, "The `\(type(of: validator))` should respond with \(expectedResult) and but received \(actualResult).")
    }
    
}
