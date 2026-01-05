//
//  Movie.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 05.01.26.
//


struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let voteAverage: Double
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}

struct MovieResponse: Decodable {
    let results: [Movie]
}