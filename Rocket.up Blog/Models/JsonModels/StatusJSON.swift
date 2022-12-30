//
//  Error.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 27/12/22.
//

import Foundation

struct Response: Codable {
    let status: String
    let errors: [ErrorResponse]?
}

struct ErrorResponse : Codable {
    let value : String
    let msg : String
    let param : String
    let location : String
}

