//
//  ReadyToRegister.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 27/12/22.
//

import Foundation

struct ReadyToRegister {
    var nameIsSet : Bool = false
    var emailIsSet : Bool = false
    var passwordIsSet : Bool = false
    var confirmPasswordIsSet : Bool = false
    
    func readyToRegister() -> Bool {
        if nameIsSet && emailIsSet && passwordIsSet && confirmPasswordIsSet {
            return true
        } else {
            return false
        }
    }
}
