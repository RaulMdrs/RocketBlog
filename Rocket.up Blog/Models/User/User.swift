//
//  User.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 09/01/23.
//

import Foundation

struct User: Codable {
    let avatar: String?
    let bio: String
    let name: String
    let email: String
    let background: String?
}
