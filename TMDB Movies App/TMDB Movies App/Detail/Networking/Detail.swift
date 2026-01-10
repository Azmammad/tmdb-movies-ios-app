//
//  Detail.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 09/01/2026.
//

import Foundation
struct Detail {
    let title: String
    let posterURL: String
    let backdropURL: String
    let rating: Double
    let year: String
    let duration: String
    let genre: String
    let overview: String
}

extension Detail {
    init(from response: MovieDetails) {
        self.title = response.title
        self.posterURL = "https://image.tmdb.org/t/p/w500" + (response.posterPath ?? "")
        self.backdropURL = "https://image.tmdb.org/t/p/w780" + (response.backdropPath ?? "")
        self.rating = response.voteAverage
        self.year = response.releaseDate?.prefix(4).description ?? ""
        self.duration = response.runtime.map { "\($0) min" } ?? ""
        self.genre = response.genres.map { $0.name }.joined(separator: ", ")
        self.overview = response.overview
    }
}
