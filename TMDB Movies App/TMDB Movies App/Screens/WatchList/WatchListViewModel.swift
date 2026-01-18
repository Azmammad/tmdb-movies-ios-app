//
//  WatchListViewModel.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

import Foundation

class WatchListViewModel {
    private let networkService: NetworkService
    
    private(set) var movies: [Movie] = []

    var onMoviesUpdated: (() -> Void)?

    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadWatchList() {
        let ids = UserDefaults.standard.array(forKey: "WatchList") as? [Int] ?? []

        guard !ids.isEmpty else {
            movies = []
            onMoviesUpdated?()
            return
        }

        Task {
            var loadedMovies: [Movie] = []

            for id in ids {
                do {
                    let detail: MovieDetails = try await networkService.request(
                        MovieEndpoint.getMovieDetail(movieId: id)
                    )

                    let movie = Movie(
                        id: detail.id,
                        title: detail.title,
                        overview: detail.overview,
                        posterPath: detail.posterPath,
                        backdropPath: detail.backdropPath,
                        releaseDate: detail.releaseDate,
                        voteAverage: detail.voteAverage,
                        voteCount: 0,
                        genreIds: detail.genres.map { $0.id }
                    )

                    loadedMovies.append(movie)

                } catch {
                    print(error)
                }
            }

            await MainActor.run {
                self.movies = loadedMovies
                self.onMoviesUpdated?()   
            }
        }
    }



    func clearWatchList() {
        movies.removeAll()
        onMoviesUpdated?()
    }
}
