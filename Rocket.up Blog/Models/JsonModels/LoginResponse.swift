//
//  LoginResponse.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 04/01/23.
//

import Foundation

struct LoginResponse : Codable {
    let status : String
    let errors : [ErrorResponse]?
    let data : LoginSuccessData?
}
