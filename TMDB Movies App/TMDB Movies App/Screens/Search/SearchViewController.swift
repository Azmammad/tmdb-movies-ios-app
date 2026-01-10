//
//  SearchViewController.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//


import UIKit

class SearchViewController: UIViewController {
    
    private let viewModel: SearchViewModel
    
    private let searchHeaderView = SearchHeaderView(title: "")
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(MovieInfoCell.self, forCellReuseIdentifier: MovieInfoCell.reuseIdentifier)
//        tableView.dataSource = self
//        tableView.delegate = self
        return tableView
    }()
    
    private let emptyStateView = EmptyStateView()
    
    
    init(viewModel: SearchViewModel) {
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
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupUI() {
        view.backgroundColor = .appbackground
        title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [ .foregroundColor: UIColor.white]
        
        searchHeaderView.searchBar.delegate = self
        
        addSubviews()
        setupConstraints()
        
        emptyStateView.isHidden = false
    }
    
    private func addSubviews() {
        [searchHeaderView, tableView, emptyStateView].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        searchHeaderView.titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        searchHeaderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchHeaderView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(searchHeaderView.snp.bottom).offset(40)
            make.leading.trailing.bottom.equalToSuperview()
        }

    }
    
    private func bindViewModel() {
        viewModel.onMoviesUpdated = { [weak self] in
            guard let self else {return}
            
            DispatchQueue.main.async {
                let isEmpty = self.viewModel.movies.isEmpty
                self.tableView.isHidden = isEmpty
                self.emptyStateView.isHidden = !isEmpty
                self.tableView.reloadData()
            }
        }
        
        viewModel.onError = { error in
            print(error)
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieInfoCell.reuseIdentifier, for: indexPath) as? MovieInfoCell
        
        guard let cell else {return UITableViewCell()}
        
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    
}
extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        
        if trimmedText.isEmpty {
            emptyStateView.isHidden = true
            tableView.isHidden = false
            viewModel.clearMovies()
            tableView.reloadData()
            return
        }
        
        viewModel.searchMovies(query: trimmedText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModel.clearMovies()
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
