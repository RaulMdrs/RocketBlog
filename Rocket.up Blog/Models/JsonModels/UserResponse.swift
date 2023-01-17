//
//  UserResponse.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 09/01/23.
//

import Foundation

struct UserResponse: Codable {
    let status: String
    let errors: [ErrorResponse]?
    let data: User?
}
