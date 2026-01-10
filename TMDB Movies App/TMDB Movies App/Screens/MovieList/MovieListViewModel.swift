//
//  MovieListViewModel.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//


import Foundation

class MovieListViewModel {
    private let networkService: NetworkService
    
    var onTrendingMoviesLoaded: (() -> Void)?
    var onCategoryMoviesLoaded: (() -> Void)?
    var onSearchResultsLoaded: (() -> Void)?
    var onError: ((String) -> Void)?
    
    private(set) var trendingMovies: [Movie] = []
    private(set) var categoryMovies: [Movie] = []
    private(set) var selectedCategory: MovieCategory = .nowPlaying
    let filterCategories = MovieCategory.filterCategories
    
    private(set) var searchResults: [Movie] = []
    private(set) var isSearching = false

    var displayedMovies: [Movie] {
        if isSearching {
            return filteredSearchResults
        }
        return categoryMovies
    }
    
    private var filteredSearchResults: [Movie] {
        guard isSearching else { return searchResults }
        
        let categoryMovieIds = Set(categoryMovies.map { $0.id })
        return searchResults.filter { categoryMovieIds.contains($0.id) }
    }
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadTrendingMovies() async {
        do {
            let response: MoviesResponse = try await networkService.request(MovieEndpoint.getTrendingMovies)
            trendingMovies = response.results
            onTrendingMoviesLoaded?()
        } catch {
            onError?("Failed to load trending movies")
        }
    }
    
    func loadCategoryMovies(category: MovieCategory) async {
        selectedCategory = category
        
        do {
            let response: MoviesResponse = try await networkService.request(category.endpoint)
            categoryMovies = response.results
            onCategoryMoviesLoaded?()
        } catch {
            onError?("Failed to load movies")
        }
    }

    func searchMovies(query: String) async {
        guard !query.isEmpty else {
            isSearching = false
            onSearchResultsLoaded?()
            return
        }
        
        isSearching = true
        
        do {
            let response: MoviesResponse = try await networkService.request(MovieEndpoint.searchMovies(query: query))
            searchResults = response.results
            onSearchResultsLoaded?()
        } catch {
            onError?("Failed to search movies")
        }
    }
    
    func clearSearch() {
        isSearching = false
        searchResults = []
        onSearchResultsLoaded?()
    }

    func loadInitialData() async {
        await loadTrendingMovies()
        await loadCategoryMovies(category: .nowPlaying)
    }
}
extension MovieListViewModel {
    func makeDetailViewModel(movieId: Int) -> DetailsViewModel {
        return DetailsViewModel(movieId: movieId, networkService: networkService)
    }
}
