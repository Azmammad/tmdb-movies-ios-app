//
//  MovieCategory.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 09/01/2026.
//

import Foundation

enum MovieCategory: String, CaseIterable {
    
    case trending
    case nowPlaying
    case upcoming
    case topRated
    case popular
    
    
    var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now playing"
        case .upcoming:
            return "Upcoming"
        case .topRated:
            return "Top rated"
        case .popular:
            return "Popular"
        }
    }
    
    var endpoint: MovieEndpoint {
        switch self {
        case .trending:
            return .getTrendingMovies
        case .nowPlaying:
            return .getNowPlayingMovies
        case .upcoming:
            return .getUpcomingMovies
        case .topRated:
            return .getTopRatedMovies
        case .popular:
            return .getPopularMovies
        }
    }
    
    static var filterCategories: [MovieCategory] {
        [.nowPlaying, .upcoming, .topRated, .popular]
    }
}
