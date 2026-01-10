//
//  GenreHelper.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 10.01.26.
//


import Foundation

struct GenreHelper {
    
    private static let genreMap: [Int: String] = [
        28: "Action",
        12: "Adventure",
        16: "Animation",
        35: "Comedy",
        80: "Crime",
        99: "Documentary",
        18: "Drama",
        10751: "Family",
        14: "Fantasy",
        36: "History",
        27: "Horror",
        10402: "Music",
        9648: "Mystery",
        10749: "Romance",
        878: "Science Fiction",
        10770: "TV Movie",
        53: "Thriller",
        10752: "War",
        37: "Western"
    ]
    
    static func getGenreName(for id: Int) -> String {
        return genreMap[id] ?? "Unknown"
    }
    
    static func getFirstGenreName(from ids: [Int]) -> String {
        guard let firstId = ids.first else {
            return "Unknown"
        }
        return getGenreName(for: firstId)
    }
}