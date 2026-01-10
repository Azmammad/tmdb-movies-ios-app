//
//  SearchViewModel.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

import Foundation

class SearchViewModel {
    
    private let networkService: NetworkService
    
    private(set) var movies: [Movie] = []
    private(set) var isLoading: Bool = false
    
    var onMoviesUpdated: (() -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func searchMovies(query: String) {
        guard !query.isEmpty else {
            clearMovies()
            return
        }
        
        setLoading(true)
        
        Task {
            do {
                let endpoint = MovieEndpoint.searchMovies(query: query)
                let response: MoviesResponse = try await networkService.request(endpoint)
                
                await MainActor.run {
                    self.movies = response.results
                    self.setLoading(false)
                    self.onMoviesUpdated?()
                }
                
            } catch let error as NetworkError {
                await MainActor.run {
                    self.setLoading(false)
                    self.handleError(error)
                }
            } catch {
                await MainActor.run {
                    self.setLoading(false)
                    self.onError?("Unknown error occurred")
                }
            }
        }
    }
    
    func clearMovies() {
        movies = []
        onMoviesUpdated?()
    }
    
    private func setLoading(_ loading: Bool) {
        isLoading = loading
        onLoadingStateChanged?(loading)
    }
    
    private func handleError(_ error: NetworkError) {
        let message: String
        
        switch error {
        case .invalidURL:
            message = "Invalid URL"
        case .noData:
            message = "No data received"
        case .decodingError:
            message = "Failed to decode data"
        case .encodingError:
            message = "Failed to encode data"
        case .serverError(let statusCode):
            message = "Server error: \(statusCode)"
        case .unknown(let error):
            message = error.localizedDescription
        }
        
        onError?(message)
    }
}
