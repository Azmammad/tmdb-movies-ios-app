//
//  DetailsBuilder.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 07/01/2026.
//

final class DetailsBuilder {
    
    static func build(movieId: Int) -> DetailsViewController {
        let networkService = DefaultNetworkService()
        let viewModel = DetailsViewModel(movieId: movieId, networkService: networkService)
        let viewController = DetailsViewController(viewModel: viewModel)
        return viewController
    }
}
