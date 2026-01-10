//
//  SearchHeaderView.swift
//  TMDB Movies App
//
//  Created by Əzi Cəbrayılov on 11.01.26.
//

import UIKit

class SearchHeaderView: UIView {

      let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 22, weight: .bold)
            label.textColor = .white
            return label
        }()

        let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.searchBarStyle = .minimal
            searchBar.backgroundImage = UIImage()
            searchBar.placeholder = "Search"
            searchBar.searchTextField.backgroundColor = UIColor.white.withAlphaComponent(0.1)
            searchBar.searchTextField.textColor = .white
            searchBar.searchTextField.leftView?.tintColor = .white
            return searchBar
        }()

        init(title: String) {
            super.init(frame: .zero)
            titleLabel.text = title
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            addSubview(titleLabel)
            addSubview(searchBar)

            titleLabel.snp.makeConstraints { make in
                make.top.leading.trailing.equalToSuperview()
            }

            searchBar.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(8)
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(50)
            }
        }

}
