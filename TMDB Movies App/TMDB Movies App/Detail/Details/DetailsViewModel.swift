//
//  DetailsViewModel.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 07/01/2026.
//

import Foundation

protocol DetailViewModelProtocol {
    
    var movieDetail: MovieDetails? { get }
    var reviews: [Review] { get }
    var didUpdateDetail: ((MovieDetails) -> Void)? { get set }
    var didUpdateReviews: (() -> Void)? { get set }
    
    func fetchMovieDetail()
    func fetchReviews()
}

final class DetailsViewModel: DetailViewModelProtocol {
    private let networkService: NetworkService
    private let movieId: Int
    
    var movieDetail: MovieDetails?
    var reviews: [Review] = []
    
    var didUpdateDetail: ((MovieDetails) -> Void)?
    var didUpdateReviews: (() -> Void)?
    
    init(movieId: Int, networkService: NetworkService = DefaultNetworkService()) {
        self.movieId = movieId
        self.networkService = networkService
        
    }
    
    func fetchMovieDetail() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let detail: MovieDetails = try await self.networkService.request(MovieEndpoint.getMovieDetail(movieId: self.movieId))
                self.movieDetail = detail
                self.didUpdateDetail?(detail)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchReviews() {
            Task {
                do {
                    let response: ReviewsResponse = try await networkService.request(MovieEndpoint.getMovieReviews(movieId: movieId))
                    self.reviews = response.results.map { Review(from: $0) }
                    self.didUpdateReviews?()
                } catch {
                    print(error)
                }
            }
        }
    }

