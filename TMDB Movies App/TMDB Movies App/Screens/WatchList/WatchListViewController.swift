//
//  WatchListViewController.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 06.01.26.
//

import UIKit
import SnapKit

class WatchListViewController: UIViewController {
    
    private let viewModel: WatchListViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.register(
            MovieInfoCell.self,
            forCellReuseIdentifier: MovieInfoCell.reuseIdentifier
        )
        return tableView
    }()
    
    private let emptyStateView = EmptyStateView()

    
    init(viewModel: WatchListViewModel) {
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

        //viewModel.loadWatchList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadWatchList()
    }
    
    func reloadWatchList() {
        viewModel.loadWatchList()
    }
    private func setupUI() {
        view.backgroundColor = .appbackground
        title = "Watch list"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]

        emptyStateView.isHidden = true

        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        [tableView, emptyStateView].forEach(view.addSubview)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
        }

        emptyStateView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
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
    }

}

extension WatchListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movies.count
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieInfoCell.reuseIdentifier,
            for: indexPath
        ) as? MovieInfoCell else {
            return UITableViewCell()
        }

        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
}
extension WatchListViewController: UITableViewDelegate {}
