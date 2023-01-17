//
//  getUserFirstName.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 09/01/23.
//

import Foundation

struct GetUserFirstName {
    static func firstName(_ name: String) -> String {
        let incomeName = name.components(separatedBy: " ")
        guard let outcomeName = incomeName.first else { return "Something went wrong"}
        return outcomeName
    }
}
