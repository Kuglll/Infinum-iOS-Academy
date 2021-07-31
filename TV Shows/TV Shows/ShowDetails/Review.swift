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
    let show_id: Int
    let user: User
}

struct ReviewResponse: Decodable {
    let reviews: [Review]
}
