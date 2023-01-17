//
//  ReadyToLogin.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 02/01/23.
//

import Foundation

struct ReadyToLogin {
    private var emailIsSet : Bool = false
    private var passwordIsSet : Bool = false
    
    mutating func setEmail(state: Bool) {
        emailIsSet = state
    }
    
    mutating func setPassword(state: Bool) {
        passwordIsSet = state
    }
    
    func readyToLogin() -> Bool {
        if emailIsSet && passwordIsSet {
            return true
        } else {
            return false
        }
    }
}
