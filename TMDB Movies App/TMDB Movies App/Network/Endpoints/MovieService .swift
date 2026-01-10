//
//  MovieService.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 09/01/2026.
//

import Foundation

final class MovieService {

    private let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }

    func fetchDetailAndReviews(movieId: Int) async throws -> (Detail, [Review]) {
        
        
        let detailResponse: MovieDetails = try await networkService.request(
            MovieEndpoint.getMovieDetail(movieId: movieId)
        )
        
        let detail = Detail(
            title: detailResponse.title,
            posterURL: "https://image.tmdb.org/t/p/w500\(detailResponse.posterPath ?? "")",
            backdropURL: "https://image.tmdb.org/t/p/w780\(detailResponse.backdropPath ?? "")",
            rating: detailResponse.voteAverage,
            year: String(detailResponse.releaseDate?.prefix(4) ?? ""),
            duration: "\(detailResponse.runtime ?? 0)m",
            genre: detailResponse.genres.map { $0.name }.joined(separator: ", "),
            overview: detailResponse.overview
        )
        
        
        let reviewsResponse: ReviewsResponse = try await networkService.request(
            MovieEndpoint.getMovieReviews(movieId: movieId)
        )
        let reviews = reviewsResponse.results.map {
            Review(author: $0.author, content: $0.content, rating: $0.authorDetails?.rating ?? 0)
        }
        
        return (detail, reviews)
    }
}
