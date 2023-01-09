//
//  Error.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 27/12/22.
//

import Foundation

struct RegisterResponse : Codable {
    let status : String
    let errors : [ErrorResponse]?
}
