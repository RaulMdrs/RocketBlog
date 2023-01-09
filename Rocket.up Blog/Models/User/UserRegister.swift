//
//  User.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 23/12/22.
//

import Foundation

struct UserRegister : Codable {
    var name: String
    var email: String
    var password: String
    var confirmPassword: String
}
