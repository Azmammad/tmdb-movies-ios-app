//
//  MovieListViewController.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 09.01.26.
//

import UIKit
import SnapKit

final class MovieListViewController: UIViewController {
    
    private let viewModel: MovieListViewModel
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to watch?"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.leftView?.tintColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.5)]
        )
        return searchBar
    }()
    
    private let trendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private lazy var trendingCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createTrendingLayout())
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(TrendingMovieCell.self, forCellWithReuseIdentifier: TrendingMovieCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return collectionView
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        layout.estimatedItemSize = CGSize(width: 100, height: 40)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var moviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 20, bottom: 100, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private func createTrendingLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { index,  environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(144), heightDimension: .absolute(210))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(144), heightDimension: .absolute(210))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            
            let section = NSCollectionLayoutSection(group: group)
            
            section.interGroupSpacing = 16
            
            return section
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        config.scrollDirection = .horizontal
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        
        return layout
    }
    
    private var moviesCollectionViewHeightConstraint: Constraint?

    
    init(viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        loadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .appbackground
        searchBar.delegate = self
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [headerLabel, searchBar, trendingLabel, trendingCollectionView, categoryCollectionView, moviesCollectionView].forEach(contentView.addSubview)
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)

    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
//            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
//            make.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        trendingLabel.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        trendingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(trendingLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(210)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(trendingCollectionView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        moviesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            moviesCollectionViewHeightConstraint = make.height.equalTo(800).constraint
            make.bottom.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.onTrendingMoviesLoaded = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.trendingCollectionView.reloadData()
            }
            
        }
        
        viewModel.onCategoryMoviesLoaded = { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
                self.updateMoviesCollectionViewHeight()
            }

        }
        
        viewModel.onSearchResultsLoaded = { [weak self] in
            guard let self else {return}
            DispatchQueue.main.async {
                self.moviesCollectionView.reloadData()
                self.updateMoviesCollectionViewHeight()
            }
        }
        
        viewModel.onError = { [weak self] message in
            self?.showError(message)
        }
    }
    
    private func loadData() {
        Task {
            await viewModel.loadInitialData()
        }
        categoryCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: [])
    }
    
    private func updateMoviesCollectionViewHeight() {
        let itemsPerRow: CGFloat = 3
        let spacing: CGFloat = 12
        let horizontalPadding: CGFloat = 40
        let availableWidth = view.bounds.width - horizontalPadding - (spacing * (itemsPerRow - 1))
        let itemWidth = availableWidth / itemsPerRow
        let itemHeight = itemWidth * 1.5
        
        let numberOfRows = ceil(CGFloat(viewModel.categoryMovies.count) / itemsPerRow)
        let totalHeight = (numberOfRows * itemHeight) + ((numberOfRows - 1) * spacing)
        
        moviesCollectionView.snp.updateConstraints { make in
            make.height.equalTo(max(totalHeight, 800))
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}

extension MovieListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case trendingCollectionView:
            return viewModel.trendingMovies.count
        case categoryCollectionView:
            return viewModel.filterCategories.count
        case moviesCollectionView:
            return viewModel.displayedMovies.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case trendingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingMovieCell.reuseIdentifier, for: indexPath) as! TrendingMovieCell
            let movie = viewModel.trendingMovies[indexPath.item]
            print("Movie \(movie)")
            cell.configure(with: movie)
            return cell
            
        case categoryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as! CategoryCell
            let category = viewModel.filterCategories[indexPath.item]
            cell.configure(with: category)
            return cell
            
        case moviesCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
            let movie = viewModel.displayedMovies[indexPath.item]
            cell.configure(with: movie)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            let category = viewModel.filterCategories[indexPath.item]
            Task {
                await viewModel.loadCategoryMovies(category: category)
            }
        }
    }
}

extension MovieListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Task {
            await viewModel.searchMovies(query: searchText)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        viewModel.clearSearch()
        moviesCollectionView.reloadData()
        updateMoviesCollectionViewHeight()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moviesCollectionView {
            let itemsPerRow: CGFloat = 3
            let spacing: CGFloat = 12
            let horizontalPadding: CGFloat = 40
            let availableWidth = view.bounds.width - horizontalPadding - (spacing * (itemsPerRow - 1))
            let itemWidth = availableWidth / itemsPerRow
            let itemHeight = itemWidth * 1.5
            return CGSize(width: itemWidth, height: itemHeight)
        }
        return .zero
    }
}
