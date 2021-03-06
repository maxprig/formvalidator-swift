//
//  PasswordStrengthCondition.swift
//  FormValidatorSwift
//
//  Created by Aaron McTavish on 13/01/2016.
//  Copyright © 2016 ustwo. All rights reserved.
//

import Foundation


public enum PasswordStrength: Int {
    case veryWeak, weak, medium, strong, veryStrong
}


/**
 *  The `PasswordStrengthCondition` checks for the strength of a password string.
 *  The strength is measured on five simple criteria:
 *      - contains lower case characters
 *      - contains upper case characters
 *      - contains numeric characters
 *      - contains special characters (e.g /';~)
 *      - is more than 8 characters long
 *
 *  Each of these matched criteria moves the password strength of the string up one strength, strength is measured on `PasswordStrength`.
 *
 *  If the password strength matches or is above the required strength than the condition will pass.
 */
public struct PasswordStrengthCondition: Condition {
    
    
    // MARK: - Properties
    
    public var localizedViolationString = StringLocalization.sharedInstance.localizedString("US2KeyConditionViolationPasswordStrength", comment: "")
    
    public let regex = ""
    
    public var shouldAllowViolation = true
    
    public let requiredStrength: PasswordStrength
    
    
    // MARK: - Initializers
    
    /**
    Initializes a `PasswordStrengthCondition` that requires a `VeryStrong` password.
    */
    public init() {
        self.init(requiredStrength: .veryStrong)
    }
    
    /**
    Initializes a `PasswordStrengthCondition`.
    - parameter requiredStrength: Minimum strength required to be considered valid.
    */
    init(requiredStrength: PasswordStrength) {
        self.requiredStrength = requiredStrength
    }
    
    
    // MARK: - Check
    
    public func check(_ text: String?) -> Bool {
        guard let sourceText = text else {
            return false
        }
        
        let matches = [numberOfMatchesWithPattern("\\d", text: sourceText), numberOfMatchesWithPattern("[a-z]", text: sourceText), numberOfMatchesWithPattern("[A-Z]", text: sourceText), numberOfMatchesWithPattern("[^a-zA-Z\\d]", text: sourceText)]
        
        var strength = matches.reduce(0, { $0 + ($1 > 0 ? 1 : 0)})
        
        if sourceText.characters.count > 8 {
            strength += 1
        } else {
            strength -= 1
        }
        
        return strength >= requiredStrength.rawValue
    }
    
    fileprivate func numberOfMatchesWithPattern(_ pattern: String, text: String) -> Int {
        guard let regExpression = try? NSRegularExpression(pattern: pattern, options: []) else {
            return 0
        }
        
        return regExpression.numberOfMatches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
    }
    
}
