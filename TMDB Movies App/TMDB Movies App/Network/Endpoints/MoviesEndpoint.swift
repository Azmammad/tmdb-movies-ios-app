//
//  MoviesEndpoint.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 05.01.26.
//


import Foundation

enum MoviesEndpoint {
    // Movie Lists
    case trending(timeWindow: String = "day")
    case nowPlaying
    case popular
    case upcoming
    case topRated
    
    // Search
    case searchMovie(query: String)
    
    // Movie Details
    case movieDetail(id: Int)
    case movieReviews(id: Int)
    
    // Watchlist
    case addToWatchlist(accountId: String, movieId: Int, watchlist: Bool)
    case getWatchlist(accountId: String)
}

extension MoviesEndpoint: Endpoint {
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var path: String {
        switch self {
        case .trending(let timeWindow):
            return "/trending/movie/\(timeWindow)"
        case .nowPlaying:
            return "/movie/now_playing"
        case .popular:
            return "/movie/popular"
        case .upcoming:
            return "/movie/upcoming"
        case .topRated:
            return "/movie/top_rated"
        case .searchMovie:
            return "/search/movie"
        case .movieDetail(let id):
            return "/movie/\(id)"
        case .movieReviews(let id):
            return "/movie/\(id)/reviews"
        case .addToWatchlist(let accountId, _, _):
            return "/account/\(accountId)/watchlist"
        case .getWatchlist(let accountId):
            return "/account/\(accountId)/watchlist/movies"
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .addToWatchlist:
            return .post
        default:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .addToWatchlist:
            return ["Content-Type": "application/json"]
        default:
            return nil
        }
    }
    
    var queryItems: [URLQueryItem]? {
        let apiKey = Configuration.tmdbAPIKey
        
        var items: [URLQueryItem] = [
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        
        switch self {
        case .searchMovie(let query):
            items.append(URLQueryItem(name: "query", value: query))
        default:
            break
        }
        
        return items
    }
    
    var httpBody: Encodable? {
        switch self {
        case .addToWatchlist(_, let movieId, let watchlist):
            return WatchlistRequest(
                mediaType: "movie",
                mediaId: movieId,
                watchlist: watchlist
            )
        default:
            return nil
        }
    }
}

struct WatchlistRequest: Encodable {
    let mediaType: String
    let mediaId: Int
    let watchlist: Bool
    
    enum CodingKeys: String, CodingKey {
        case mediaType = "media_type"
        case mediaId = "media_id"
        case watchlist
    }
}
