//
//  Post.swift
//  Rocket.up Blog
//
//  Created by Aline do Amaral on 18/01/23.
//

import Foundation
import UIKit

struct Post: Codable {
    let id: String
    let title: String
    let image: String?
    let postedBy: [Author]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title = "title"
        case image = "image"
        case postedBy = "postedBy"
    }
}
