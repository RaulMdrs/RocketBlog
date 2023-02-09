//
//  User.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 09/01/23.
//

import Foundation

struct User: Codable {
    let avatar: String?
    let bio: String?
    let name: String
    let email: String
    let background: String?
    let id : String?
    
    
    func getFirstAndLastName() -> String{
        let firstAndLast = name.components(separatedBy: " ")
        
        if let firstName = firstAndLast.first, let lastName = firstAndLast.last {
            return "\(firstName) \(lastName)"
        } else {
            return name
        }
    }
}
