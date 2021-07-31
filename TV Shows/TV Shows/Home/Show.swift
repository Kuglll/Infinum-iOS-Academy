//
//  Show.swift
//  TV Shows
//
//  Created by Mark Frelih on 30.07.2021..
//

import Foundation


struct Show: Decodable {
    let id: String
    let average_rating: Int?
    let description: String?
    let image_url: String
    let no_of_reviews: Int
    let title: String
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
