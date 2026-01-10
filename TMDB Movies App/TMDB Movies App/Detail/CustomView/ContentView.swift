//
//  ContentView.swift
//  TMDB Movies App
//
//  Created by Leyla Jafarova on 10/01/2026.
//
//import UIKit
//import SnapKit
//
//final class ContentView: UIView {
//    
//    let overviewLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont(name: "Poppins-Regular", size: 12)
//        label.textColor = .white
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    let reviewsTableView: UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        tableView.estimatedRowHeight = 120
//        tableView.register(ReviewCell.self, forCellReuseIdentifier: ReviewCell.identifier)
//        return tableView
//    }()
//    
//    private let stackView: UIStackView = {
//        let sv = UIStackView()
//        sv.axis = .vertical
//        sv.spacing = 16
//        return sv
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        addSubviews()
//        setupConstraints()
//    }
//    
//    required init?(coder: NSCoder) { fatalError() }
//    
//    private func addSubviews() {
//        [overviewLabel, reviewsTableView].forEach(stackView.addArrangedSubview)
//        addSubview(stackView)
//    }
//    
//    private func setupConstraints() {
//        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        reviewsTableView.snp.makeConstraints { make in
//            make.height.equalTo(400)
//        }
//    }
//}
