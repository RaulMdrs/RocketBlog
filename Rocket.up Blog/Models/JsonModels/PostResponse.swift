//
//  PostResponse.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 20/01/23.
//

import Foundation

struct PostResponse: Codable {
    let status: String
    let errors : [ErrorResponse]?
    let data: FeaturedPosts?
}
