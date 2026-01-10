//
//  DetailsViewController.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 07/01/2026.
//

import UIKit
import SnapKit

final class DetailsViewController: UIViewController {
    
    private var selectedTabIndex: Int = 0
    var viewModel: DetailViewModelProtocol?
    private let detailView = DetailsView()
    
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTabs()
        setupDelegates()
        bindViewModel()
        viewModel?.fetchMovieDetail()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if selectedTabIndex == 0, let firstButton = detailView.tabButtons.first {
            detailView.setupInitialIndicator(for: firstButton)
        }
    }
}

extension DetailsViewController {
    private func setupNavBar() {
        title = "Detail"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .appbackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "bookmark"),
            style: .plain,
            target: self,
            action: #selector(bookmarkTapped)
        )
    }
    
    private func setupTabs() {
        let titles = ["About Movie", "Reviews"]
        
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
            button.tag = index
            button.addTarget(self, action: #selector(tabTapped(_:)), for: .touchUpInside)
            
            detailView.tabsStack.addArrangedSubview(button)
            detailView.tabButtons.append(button)
        }
    }
}

extension DetailsViewController {
    
    private func bindViewModel() {
        viewModel?.didUpdateDetail = { [weak self] detail in
            DispatchQueue.main.async { self?.detailView.configureUI(with: detail) }
        }
        
        viewModel?.didUpdateReviews = { [weak self] in
            DispatchQueue.main.async { self?.detailView.reviewsTableView.reloadData() }
        }
    }
    
    @objc private func tabTapped(_ sender: UIButton) {
        selectedTabIndex = sender.tag
        
        if let titleLabel = sender.titleLabel {
            detailView.indicatorView.snp.remakeConstraints { make in
                make.top.equalTo(detailView.tabsStack.snp.bottom).offset(2)
                make.centerX.equalTo(titleLabel.snp.centerX)
                make.width.equalTo(titleLabel.intrinsicContentSize.width)
                make.height.equalTo(4)
            }
            UIView.animate(withDuration: 0.3) { self.view.layoutIfNeeded() }
        }
        
        detailView.overviewLabel.isHidden = (sender.tag != 0)
        detailView.reviewsTableView.isHidden = (sender.tag != 1)
        
        if sender.tag == 1 && (viewModel?.reviews.isEmpty ?? true) {
            viewModel?.fetchReviews()
        }
    }

    @objc private func bookmarkTapped() {
        guard let movie = viewModel?.movieDetail else { return }
        
        var watchList = UserDefaults.standard.array(forKey: "WatchList") as? [Int] ?? []
        
        if watchList.contains(movie.id) {
            watchList.removeAll { $0 == movie.id }
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark")
        } else {
            watchList.append(movie.id)
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "bookmark.fill")
        }
    
        UserDefaults.standard.set(watchList, forKey: "WatchList")
    }
}

extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func setupDelegates() {
        detailView.reviewsTableView.delegate = self
        detailView.reviewsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.reviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewCell.identifier, for: indexPath) as? ReviewCell else { return UITableViewCell() }
        if let review = viewModel?.reviews[indexPath.row] {
            cell.configure(with: review)
        }
        return cell
    }
}

