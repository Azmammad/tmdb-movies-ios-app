//
//  MainTabBarController.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//


import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupAppearance()
    }
    
    private func setupViewControllers() {
        let movieListVC = MovieListBuilder().build()
        let movieListNavController = UINavigationController(rootViewController: movieListVC)
        movieListNavController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        let searchVC = SearchBuilder().build()
        let searchNavController = UINavigationController(rootViewController: searchVC)
        searchNavController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        let watchListVC = WatchListBuilder().build()
        let watchListNavController = UINavigationController(rootViewController: watchListVC)
        watchListNavController.tabBarItem = UITabBarItem(
            title: "Watch list",
            image: UIImage(systemName: "bookmark"),
            selectedImage: UIImage(systemName: "bookmark.fill")
        )
        
        viewControllers = [movieListNavController, searchNavController, watchListNavController]
    }
    
    private func setupAppearance() {
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
    }
}