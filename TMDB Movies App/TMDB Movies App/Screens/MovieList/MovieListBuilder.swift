//
//  MovieListBuilder.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

class MovieListBuilder {
    
    func build() -> MovieListViewController {
        let networkService = DefaultNetworkService()
        let viewModel = MovieListViewModel(networkService: networkService)
        
        let viewController = MovieListViewController(viewModel: viewModel)
        return viewController

    }
}

