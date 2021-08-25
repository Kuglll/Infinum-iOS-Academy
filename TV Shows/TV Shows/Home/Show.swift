//
//  Show.swift
//  TV Shows
//
//  Created by Mark Frelih on 30.07.2021..
//

import Foundation


struct Show: Decodable {
    let id: String
    let averageRating: Int?
    let description: String?
    let imageUrl: String
    let numOfReviews: Int
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case averageRating = "average_rating"
        case description
        case imageUrl = "image_url"
        case numOfReviews = "no_of_reviews"
        case title
    }
}

struct ShowsResponse: Decodable {
    let shows: [Show]
}

struct ShowLocal{
    let id: String
    let averageRating: Int?
    let description: String?
    let imageUrl: String
    let numberOfReviews: Int
    let title: String
}
