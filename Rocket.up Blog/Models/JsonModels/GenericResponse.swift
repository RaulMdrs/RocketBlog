//
//  GenericResponse.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 23/01/23.
//

import Foundation

struct GenericResponse: Codable {
    let status: String
    let errors: ErrorResponse?
}
