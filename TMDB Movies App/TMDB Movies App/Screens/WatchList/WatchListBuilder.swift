//
//  WatchListBuilder.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

class WatchListBuilder {
    
    func build() -> WatchListViewController {
        let networkService = DefaultNetworkService()
        let viewModel = WatchListViewModel(networkService: networkService)
        return WatchListViewController(viewModel: viewModel)
    }
}
