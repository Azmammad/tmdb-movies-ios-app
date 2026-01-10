//
//  ReviewResponse.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 08/01/2026.
//

import Foundation

struct ReviewsResponse: Decodable {
    let results: [ReviewResponse]
}

struct ReviewResponse: Decodable {
    let author: String
    let content: String
    let authorDetails: AuthorDetails?

    enum CodingKeys: String, CodingKey {
        case author, content
        case authorDetails = "author_details"
    }
}

struct AuthorDetails: Decodable {
    let rating: Double?
}

