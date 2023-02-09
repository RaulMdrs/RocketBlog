//
//  PeopleResponse.swift
//  Rocket.up Blog
//
//  Created by Raul de Medeiros on 06/02/23.
//

import Foundation

struct PeopleResponse : Codable{
    let status: String
    let errors : [ErrorResponse]?
    let data: Users
}

struct Users : Codable{
    let users : [User]?
}
