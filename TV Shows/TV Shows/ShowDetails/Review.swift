//
//  Review.swift
//  TV Shows
//
//  Created by Mark Frelih on 31.07.2021..
//

import Foundation

struct Review: Decodable {
    let id: String
    let comment: String
    let rating: Int
    let showId: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case comment
        case rating
        case showId = "show_id"
        case user
    }
}

struct ReviewResponse: Decodable {
    let reviews: [Review]
}
