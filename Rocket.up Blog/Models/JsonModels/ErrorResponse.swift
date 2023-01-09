//
//  ErrorResponse.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 04/01/23.
//

import Foundation

struct ErrorResponse : Codable {
    let value : String
    let msg : String
    let param : String
    let location : String
}
