//
//  ParametersVerifier.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 23/12/22.
//

import Foundation

class ParametersVerifier {
    var password: String?
    
    static func verifyNameTextField(_ name: String) -> Bool {
        let incomeName = name.components(separatedBy: " ")
        var counter = 0
        
        for char in name {
            if char != " " {
                counter += 1
            }
        }
        
        for position in incomeName {
            if position.isEmpty || position == " " {
                return false
            }
        }
        
        if incomeName.count > 1 && counter > 1 {
            return true
        } else {
            return false
        }
    }
    
    static func verifyEmailTextField(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func verifyPasswordTextField(_ myPassword: String) -> Bool {
        let passwordRegx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{6,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: myPassword)
    }
    
    static func verifyPasswordConfirmation(passwordReceived: String, newUserPassword: String) -> Bool {
        if passwordReceived == newUserPassword {
            return true
        } else {
            return false
        }
    }
    
    static func verifyLetterCount(texts : [Int]) -> Bool {
        for counter in texts {
            if !(counter >= 1){
                return false
            }
        }
        return true
    }
    
    static func verifyLetterCountLoginPassword(text: String) -> Bool {
        if !(text.count >= K.ParametersVerifier.minCharacter) {
                return false
        }
        return true
    }
}
