//
//  MovieEndpoint.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 05.01.26.
//


import Foundation

enum MovieEndpoint {
    case getTrendingMovies
    case getNowPlayingMovies
    case getPopularMovies
    case getUpcomingMovies
    case getTopRatedMovies
    case searchMovies(query: String)
}

extension MovieEndpoint: Endpoint {
    var baseURL: String {
        return Configuration.baseURL
    }
    
    var path: String {
        switch self {
        case .getTrendingMovies:
            return "/3/trending/movie/day"
        case .getNowPlayingMovies:
            return "/3/movie/now_playing"
        case .getPopularMovies:
            return "/3/movie/popular"
        case .getUpcomingMovies:
            return "/3/movie/upcoming"
        case .getTopRatedMovies:
            return "/3/movie/top_rated"
        case .searchMovies:
            return "/3/search/movie"
        }
    }
    
    var method: HttpMethod { .get }
    
    var headers: [String: String]? {
        [
            "Authorization": "Bearer \(Configuration.tmdbBearerToken)",
            "accept": "application/json"
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchMovies(let query):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        default:
            return [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1")
            ]
        }
    }
    
    var httpBody: Encodable? { nil }
}
