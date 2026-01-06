//
//  SearchBuilder.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

class SearchBuilder {
    func build() -> SearchViewController {
        let networkService = DefaultNetworkService()
        let viewModel = SearchViewModel(networkService: networkService)
        return SearchViewController(viewModel: viewModel)
    }
}
