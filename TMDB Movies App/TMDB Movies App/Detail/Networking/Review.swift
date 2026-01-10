//
//  Review.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 09/01/2026.
//

import Foundation

struct Review {
    let author: String
    let content: String
    let rating: Double?
    
}

extension Review {
    init(from response: ReviewResponse) {
        self.author = response.author
        self.content = response.content
        self.rating = response.authorDetails?.rating
        
    }
}
