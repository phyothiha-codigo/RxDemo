//
//  ValidationRules.swift
//  Domain
//
//  Created by Codigo Kaung Soe on 21/07/2020.
//  Copyright © 2020 codigo. All rights reserved.
//

import Foundation



public func validateNumber(_ input: String?) -> Validation<Int, String> {
    guard let ip = input, let num = Int(ip) else {
        return .invalid("Input is not number.")
    }
    return .valid(num)
}


public func validateNonEmpty(message: String = "Input is empty")-> (_ input: String?) -> Validation<String, String> {
        {
            guard $0?.isEmpty == false else {
                return .invalid(message)
            }
            return .valid($0!)
        }
}

public func validateLoginID(message: String = "Invalid Login ID") -> (_ input: String) -> Validation<String, String> {
        {
            let regex = "^[0-9]{3}[A-Z][896][0-9]{7}$"
            let loginIDPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
            let isValid = loginIDPredicate.evaluate(with: $0)
            
            if isValid {
                return .valid($0)
            } else {
                return .invalid(message)
            }
        }
}

public func validateNIRC(message: String = "Invalid NRIC")
    -> (_ input: String) -> Validation<String, String> {
        {
            let regex = "^[STFG]\\d{7}[A-Z]$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            let isValid = predicate.evaluate(with: $0)
            
            if isValid {
                return .valid($0)
            } else {
                return .invalid(message)
            }
        }
}

public func validateEmail(message: String = "invalid email")
    -> (_ input: String) -> Validation<String, String> {
        {
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            let isValid = predicate.evaluate(with: $0)
            
            if isValid {
                return .valid($0)
            } else {
                return .invalid(message)
            }
        }
}

public func validatePassword(message: String = "invalid password")
    -> (_ input: String) -> Validation<String, String> {
        {
            let specialCharacters = "!\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~"
            let regex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[\(specialCharacters)])[A-Za-z\\d\(specialCharacters)]{8,}$"
            
            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            let isValid = predicate.evaluate(with: $0)
            
            if isValid {
                return .valid($0)
            } else {
                return .invalid(message)
            }
        }
}

public func validateLoginPassword(message: String = "invalid password")
    -> (_ input: String) -> Validation<String, String> {
        {
            let specialCharacters = "!\"#$%&'()*+,-./:;<=>?@\\[\\\\\\]^_`{|}~"
            let regex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d\(specialCharacters)]{8,}$"

            let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
            let isValid = predicate.evaluate(with: $0)
            
            if isValid {
                return .valid($0)
            } else {
                return .invalid(message)
            }
        }
}

public func validateNonMatch(message: String = "inputs must not be the same") -> (_ input: String, _ input2: String) -> Validation<String, String> {
    { a, b in
        .condition({ a != b }, a, message)
    }
}

public func validateMatch(message: String = "input doesn't match")
    -> (_ input1: String?, _ input2: String?) -> Validation<String, String> {
        { a, b in
            .condition({ a == b }, a!, message)
        }
}

public func validateUserID(message: String = "invalid userID") -> (_ input: String?) -> Validation<String, String> {
        { a in
            .condition({a!.count == 12 }, a!, message)
        }
}

public func validateAlphaNumeric(message: String = "Invalid") -> (_ input: String?) -> Validation<String, String> {
        { a in
            .condition({
                guard let a = a else { return false }
                return !a.isEmpty && a.range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
            }, a!, message)
        }
}

public func validateNotNil(message: String = "Input not selected") -> (_ input: Bool?) -> Validation<Bool,String> {
    {   a in
            .condition({a != nil}, a!, message)
    }
}

public func validateNotNil(message: String = "String is nil") -> (_ input: String?) -> Validation<String, String> {
    {   a in
        .condition({a != nil}, a!, message)
    }
}

//public func validateNotNil(message: String = "FileData is nil") -> (_ input: FileData?) -> Validation<FileData, String> {
//    {   a in
//        .condition({a != nil}, a!, message)
//    }
//}

// MARK: - edit profile validation rules


