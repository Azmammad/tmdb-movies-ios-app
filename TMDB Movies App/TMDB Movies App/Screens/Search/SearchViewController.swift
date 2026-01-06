//
//  SearchViewController.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//


import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appbackground
    }
}
