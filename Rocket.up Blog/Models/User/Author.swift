//
//  Author.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 20/01/23.
//

import Foundation

struct Author: Codable {
    let id: String
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name = "name"
        case avatar = "avatar"
    }
    
    func getFirstAndLastName() -> String{
        let firstAndLast = name.components(separatedBy: " ")
        
        if let firstName = firstAndLast.first, let lastName = firstAndLast.last {
            return "\(firstName) \(lastName)"
        } else {
            return name
        }
    }
}
